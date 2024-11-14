//
//  NetworkManager.swift
//  ModiSpace
//
//  Created by 최승범 on 10/26/24.
//

import Foundation
import Combine

final class NetworkManager: NSObject {
    
    private let session: URLSessionProtocol
    private let decoder = JSONDecoder()
    private var webSocket: URLSessionWebSocketTask?
    private var cancelable = Set<AnyCancellable>()
    private var timer: Timer?
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
}

//MARK: - NetworkManagerProtocol
extension NetworkManager: NetworkManagerProtocol {
    
    func getData(from router: RouterProtocol,
                 retryCount: Int = 1) async throws -> Data {
        let (data, response) = try await session.getData(from: router)
        
        do {
            try validateResponse(response)
        } catch {
            if let handledError = await handleErrorDataWithError(data: data) {
                
                if handledError == .refreshTokenExpired {
                    throw APIError.refreshTokenExpired
                }
            }
            
            if retryCount > 0 {
                print("토큰 갱신 성공, 원래 요청을 다시 시도합니다.")
                return try await getData(from: router,
                                         retryCount: retryCount - 1)
            }
        }
        return data
    }
    
    func getDecodedData<T: Decodable>(from router: RouterProtocol,
                                      type: T.Type,
                                      retryCount: Int = 1) async throws -> T {
        let (data, response) = try await session.getData(from: router)
        
        do {
            try validateResponse(response)
        } catch {
            
            if let handledError = await handleErrorDataWithError(data: data) {
                
                if handledError == .refreshTokenExpired {
                    throw APIError.refreshTokenExpired
                }
            }
            
            if retryCount > 0 {
                print("토큰 갱신 성공, 원래 요청을 다시 시도합니다.")
                return try await getDecodedData(from: router,
                                                type: type, retryCount: retryCount - 1)
            }
        }
        
        do {
            let decodedData = try decoder.decode(type, from: data)
            return decodedData
        } catch {
            print(NetworkError.decodingFailed("\(type)"))
            throw NetworkError.decodingFailed("\(type)")
        }
    }
    
    func getDataWithPublisher(from router: RouterProtocol,
                              retryCount: Int = 1) -> AnyPublisher<Data, Error> {
        Future { promise in
            Task { [weak self] in
                guard let self = self else { return }
                
                let (data, response) = try await self.session.getData(from: router)
                
                do {
                    try validateResponse(response)
                    promise(.success(data))
                } catch {
                    
                    let handledError = await handleErrorDataWithError(data: data)
                    
                    if let handledError = handledError {
                        if handledError == .refreshTokenExpired {
                            promise(.failure(APIError.refreshTokenExpired))
                            return
                        }
                    }
                    
                    if  handledError == nil {
                        if retryCount > 0 {
                            print("토큰 갱신 성공, 원래 요청을 다시 시도")
                            
                            let newPublisher = getDataWithPublisher(from: router,
                                                                    retryCount: retryCount - 1)
                            newPublisher.sink(receiveCompletion: { completion in
                                switch completion {
                                case .failure(let error):
                                    promise(.failure(error))
                                case .finished:
                                    break
                                }
                            }, receiveValue: { value in
                                promise(.success(value))
                            })
                            .store(in: &self.cancelable)
                        }
                        return
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func getDecodedDataWithPublisher<T: Decodable>(from router: RouterProtocol,
                                                   type: T.Type,
                                                   retryCount: Int = 1) -> AnyPublisher<T, Error> {
        return Future { promise in
            Task { [weak self] in
                guard let self = self else { return }
                
                let (data, response) = try await self.session.getData(from: router)
                
                do {
                    try validateResponse(response)
                } catch {
                    if let _ = error as? NetworkError {
                        promise(.failure(NetworkError.decodingFailed("\(type)")))
                    }
                    
                    let handledError = await handleErrorDataWithError(data: data)
                    
                    if let handledError = handledError {
                        if handledError == .refreshTokenExpired {
                            promise(.failure(APIError.refreshTokenExpired))
                        }
                    }
                    
                    if  handledError == nil {
                        if retryCount > 0 {
                            
                            let newPublisher = getDecodedDataWithPublisher(from: router,
                                                                           type: type,
                                                                           retryCount: retryCount - 1)
                            newPublisher.sink(receiveCompletion: { completion in
                                switch completion {
                                case .failure(let error):
                                    promise(.failure(error))
                                case .finished:
                                    break
                                }
                            }, receiveValue: { value in
                                promise(.success(value))
                            })
                            .store(in: &self.cancelable)
                        }
                    }
                    promise(.failure(error))
                }
                
                do {
                    let decodedData = try self.decoder.decode(type, from: data)
                    promise(.success(decodedData))
                } catch {
                    print("실패한 라우터:", router.url!.absoluteString)
                    print(NetworkError.decodingFailed("\(type)"))
                    if let string = String(data: data, encoding: .utf8) {
                        print("\(router.url!.absoluteString): 에서 보내온 Data", string)
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
}

//MARK: - Socket 통신
//TODO: - 소켓 통신 아직 안됨
extension NetworkManager {
    
    func openWebSocket(from router: RouterProtocol) {
        do {
            let socketSession = URLSession(configuration: .default,
                                           delegate: self,
                                           delegateQueue: nil)
            webSocket = try socketSession.webSocket(from: router)
            webSocket?.resume()
            startPing()
//            send()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func closeWebSocket() {
        webSocket?.cancel(with: .goingAway,
                          reason: nil)
        webSocket = nil
    }
    
    func send() {
        let string = """
    {"event":"channel"}
    """
        
        webSocket?.send(.string(string),
                        completionHandler: { error in
            if let error {
                print("send error, \(error)")
            }
        })
    }
    
    func receive() {
        webSocket?.receive { [weak self] result in
            switch result {
            case .success(let message):
                switch message {
                case .string(let text):
                    print("서버 -> 클라: \(text)")
                case .data(let data):
                    print("서버 -> 클라: \(data)")
                @unknown default:
                    print("Received unknown message")
                }
                self?.receive()
            case .failure(let error):
                print("Receive error: \(error.localizedDescription)")
            }
        }
    }
    
    private func startPing() {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(
            withTimeInterval: 10,
            repeats: true,
            block: { [weak self] _ in self?.ping() }
        )
    }
    
    private func ping() {
        self.webSocket?.sendPing(pongReceiveHandler: { [weak self] error in
            if let error {
                print("ping pong Error, \(error)")
            } else {
                print("Ping")
            }
            self?.startPing()
        })
    }
}

extension NetworkManager: URLSessionWebSocketDelegate {
    
    func urlSession(_ session: URLSession,
                    webSocketTask: URLSessionWebSocketTask,
                    didOpenWithProtocol protocol: String?) {
        
        print("Websoket OPEN")
        receive()
    }
    
    func urlSession(_ session: URLSession,
                    webSocketTask: URLSessionWebSocketTask,
                    didCloseWith closeCode: URLSessionWebSocketTask.CloseCode,
                    reason: Data?) {
        
        print("webSocket Close")
    }
}

//MARK: - 유효성, Error핸들링
extension NetworkManager {
    
    private func validateResponse(_ response: URLResponse) throws {
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { throw NetworkError.invalidResponse }
        
        guard (200..<300) ~= statusCode else {
            print("StatusCode: \(statusCode)")
            throw NetworkError.invalidResponse
        }
    }
    
    private func handleErrorDataWithError(data: Data) async -> APIError? {
        do {
            let errorData = try decoder.decode(ErrorDTO.self, from: data)
            let error = APIError(errorCode: errorData.errorCode)
            print(error.description)
            
            if error == .tokenExpired {
                return await refreshAccessToken()
            }
            
            return error
        } catch {
            print(NetworkError.decodingFailed("ErrorDTO"))
            return nil
        }
    }
    
    private func refreshAccessToken() async -> APIError? {
        print("토큰 갱신 시도")
        return await withCheckedContinuation { continuation in
            getDecodedDataWithPublisher(from: TokenRouter.refreshToken,
                                        type: TokenDTO.self)
            .sink { completion in
                switch completion {
                case .finished:
                    continuation.resume(returning: nil)
                case .failure:
                    continuation.resume(returning: .refreshTokenExpired)
                }
            } receiveValue: { tokens in
                KeychainManager.save(tokens.accessToken,
                                     forKey: .accessToken)
            }
            .store(in: &cancelable)
        }
    }
    
}


//
//  RequestBuilder.swift
//  ModiSpace
//
//  Created by 최승범 on 10/25/24.
//

import Foundation

final class RequestBuilder {
    
    private var url: URL?
    private var method: HTTPMethod = .get
    private var headers: [String: String] = [:]
    private var body: Data?
    private var multipartFormData: [MultipartFormData] = []

    func setRouter(_ router: RouterProtocol) -> RequestBuilder {
        url = router.url
        method = router.method
        headers = router.headers
        body = router.body
        multipartFormData = router.multipartFormData
        return self
    }
    
    func setURL(_ url: URL) -> RequestBuilder {
        self.url = url
        return self
    }

    func setHeaders(_ headers: [String: String]) -> RequestBuilder {
        headers.forEach { self.headers[$0.key] = $0.value }
        return self
    }

    func setBody(_ body: Data?) -> RequestBuilder {
        self.body = body
        return self
    }

    func addMultipartFormData(_ data: MultipartFormData) -> RequestBuilder {
        multipartFormData.append(data)
        return self
    }

    func build() throws -> URLRequest {
        guard let url = url else { throw NetworkError.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        if !multipartFormData.isEmpty {
            let boundary = UUID().uuidString
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            request.httpBody = createMultipartBody(boundary: boundary)
        } else {
            request.httpBody = body
        }
        
        return request
    }
    
    private func createMultipartBody(boundary: String) -> Data {
        var body = Data()

        for formData in multipartFormData {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(formData.name)\"; filename=\"\(formData.fileName)\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: \(formData.mimeType)\r\n\r\n".data(using: .utf8)!)
            body.append(formData.data)
            body.append("\r\n".data(using: .utf8)!)
        }

        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        return body
    }
}

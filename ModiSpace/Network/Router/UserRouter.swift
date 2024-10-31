//
//  User.swift
//  ModiSpace
//
//  Created by 최승범 on 10/28/24.
//

import Foundation

enum UserRouter {
    
    case join(body: JoinRequestBody) // 회원가입
    case validateEmail(body: CheckEmailRequestBody) // 이메일 중복 확인
    case login(body: LoginRequestBody) // 로그인
    case loginKakao(body: KakaoLoginRequestBody) // 카카오 로그인
    case loginApple(body: AppleLoginRequestBody) // 애플 로그인
    case logout // 로그아웃
    case saveDeviceToken(body: DeviceTokenRequestBody) // FCM 디바이스 토큰 저장
    case getMyProfile // 내 프로필 정보 조회
    case updateMyProfile(body: EditMyProfileRequestBody) // 프로필 정보 수정 (이미지 제외)
    case updateMyProfileImage(body: UpdateMyProfileImageRequestBody) // 프로필 이미지 수정
    case getOtherUserProfile(userId: String) // 다른 유저 프로필 조회
    
}

extension UserRouter: RouterProtocol {
    
    var scheme: String { return "http" }
    
    var host: String? { return BundleManager.loadBundleValue(.host) }
    
    var port: Int? { return BundleManager.loadBundlePort() }
    
    var path: String {
        switch self {
        case .join:
            return "/v1/users/join"
            
        case .validateEmail:
            return "/v1/users/validation/email"
            
        case .login:
            return "/v1/users/login"
            
        case .loginKakao:
            return "/v1/users/login/kakao"
            
        case .loginApple:
            return "/v1/users/login/apple"
            
        case .logout:
            return "/v1/users/logout"
            
        case .saveDeviceToken:
            return "/v1/users/deviceToken"
            
        case .getMyProfile:
            return "/v1/users/me"
            
        case .updateMyProfile:
            return "/v1/users/me"
            
        case .updateMyProfileImage:
            return "/v1/users/me/image"
            
        case .getOtherUserProfile(let userId):
            return "/v1/users/\(userId)"
        }
    }
    
    var query: [URLQueryItem] {
        return []
    }
    
    var body: Data? {
        
        let jsonEncoder = JSONEncoder()
        var data: Data?
            
        switch self {
        case .join(let body):
            data = try? jsonEncoder.encode(body)
            
        case .validateEmail(let body):
            data = try? jsonEncoder.encode(body)
            
        case .login(let body):
            data = try? jsonEncoder.encode(body)
            
        case .loginKakao(let body):
            data = try? jsonEncoder.encode(body)
        
        case .loginApple(let body):
            data = try? jsonEncoder.encode(body)
            
        case .logout:
            data = nil
            
        case .saveDeviceToken(let body):
            data = try? jsonEncoder.encode(body)
            
        case .getMyProfile:
            data = nil
            
        case .updateMyProfile(let body):
            data = try? jsonEncoder.encode(body)
            
        case .getOtherUserProfile:
            data = nil
            
        default:
            data = nil
        }
        
        return data
    }
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.port = port
        components.path = path
        components.queryItems = query
        
        return components.url
    }
    
    var headers: [String : String] {
        let headers = [
            Header.sesacKey.key: Header.sesacKey.value,
            Header.contentTypeJson.key: Header.contentTypeJson.value
        ]
        
        return headers
    }
    
    var method: HTTPMethod {
        switch self {
        case .join, .validateEmail, .login, .loginKakao, .loginApple, .saveDeviceToken:
            return .post
            
        case .logout, .getMyProfile, .getOtherUserProfile:
            return .get
            
        case .updateMyProfile, .updateMyProfileImage:
            return .put
        }
    }
    
    var responseType: Decodable.Type? {
        switch self {
        case .join, .login, .loginKakao, .loginApple:
            return UserDTO.self
            
        case .validateEmail:
            return nil
            
        case .logout:
            return nil
            
        case .saveDeviceToken:
            return nil
            
        case .getMyProfile, .updateMyProfile:
            return UserDTO.self
            
        case .getOtherUserProfile:
            return OtherUserDTO.self
            
        case .updateMyProfileImage:
            return UserDTO.self
        }
    }
    
    var multipartFormData: [MultipartFormData] {
        switch self {
        case .updateMyProfileImage(let body):
           return body.toMultipartFormData()
        default:
            return []
        }
    }
    
}

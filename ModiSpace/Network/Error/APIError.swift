//
//  APIError.swift
//  ModiSpace
//
//  Created by 최승범 on 10/26/24.
//

import Foundation

enum APIError: Error {
    
    case unauthorized // E01 접근권한
    case unknownRoute // E97 알 수 없는 라우터 경로
    case tokenExpired // E05 액세스 토큰 만료
    case authenticationFailed // E02 인증 실패
    case unknownAccount // E03 알 수 없는 계정
    case rateLimitExceeded // E98 과호출
    case serverError // E99 서버 오류
    case refreshTokenExpired // E06 리프레시 토큰 만료
    case badRequest // E11 잘못된 요청
    case duplicateData // E12 중복 데이터
    case insufficientSesacCoin // E21 새싹코인 부족
    case dataNotFound // E13 존재하지 않는 데이터
    case noPermission // E14 권한 없음
    case exitDenied // E15 요청 거절
    
}

extension APIError {
    
    init?(errorCode: String) {
        switch errorCode {
        case "E01":
            self = .unauthorized
        case "E97":
            self = .unknownRoute
        case "E05":
            self = .tokenExpired
        case "E02":
            self = .authenticationFailed
        case "E03":
            self = .unknownAccount
        case "E98":
            self = .rateLimitExceeded
        case "E99":
            self = .serverError
        case "E06":
            self = .refreshTokenExpired
        case "E11":
            self = .badRequest
        case "E12":
            self = .duplicateData
        case "E21":
            self = .insufficientSesacCoin
        case "E13":
            self = .dataNotFound
        case "E14":
            self = .noPermission
        case "E15":
            self = .exitDenied
        default:
            return nil
        }
    }
    
    var description: String {
        switch self {
        case .unauthorized:
            return "E01 접근 권한이 없습니다. SesacKey가 필요합니다."
        case .unknownRoute:
            return "E97 잘못된 라우터 경로입니다."
        case .tokenExpired:
            return "E05 액세스 토큰이 만료되었습니다."
        case .authenticationFailed:
            return "E02 토큰 인증에 실패했습니다."
        case .unknownAccount:
            return "E03 알 수 없는 계정입니다."
        case .rateLimitExceeded:
            return "E98 서버에 너무 많은 요청을 보냈습니다."
        case .serverError:
            return "E99 서버에서 오류가 발생했습니다."
        case .refreshTokenExpired:
            return "E06 리프레시 토큰이 만료되었습니다. 재로그인이 필요합니다."
        case .badRequest:
            return "E11 잘못된 요청입니다. 요청의 필수 사항을 확인하세요"
        case .duplicateData:
            return "E12 중복된 데이터입니다. 워크스페이스 이름이 중복될 수 없습니다."
        case .insufficientSesacCoin:
            return "E21 새싹코인이 부족합니다."
        case .dataNotFound:
            return "E13 존재하지 않는 데이터입니다."
        case .noPermission:
            return "E14 권한이 없습니다."
        case .exitDenied:
            return "E15 워크스페이스에 속한 관리자 권한이 있는 경우 퇴장이 불가능합니다."
        }
    }
    
}

//
//  APIEndpoint.swift
//  Network Manager SwiftUi
//
//  Created by Hamid on 10/17/24.
//

import Foundation

enum APIEndpoint {

    // MARK: - Cases

    case login(username: String, password: String, expiresInMins: Int)
    case userInfo
    case refreshToken
    case carts
    
    // MARK: - Properties

    func request() throws -> URLRequest {
        var request = URLRequest(url: url)

        request.addHeaders(headers)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = httpBody

        return request
    }

    private var url: URL {
        Environment.apiBaseURL.appendingPathComponent(path)
    }
    
    private var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .userInfo:
            return "/auth/me"
        case .refreshToken:
            return "/auth/refresh"
        case .carts:
            return "/carts"
        }
    }

    private var httpMethod: HTTPMethod {
        switch self {
        case .login, .refreshToken:
            return .post
        case .userInfo, .carts:
            return .get
        }
    }

    private var httpBody: Data? {
        switch self {
        case .login(let username, let password, let expiresInMins):
            let requestBody = LoginRequestBody(username: username, password: password, expiresInMins: expiresInMins)
            return try? JSONEncoder().encode(requestBody)
        case .userInfo, .carts:
            return nil
        case .refreshToken:
            let requestBody = RefreshTokenRequestBody(refreshToken: AuthTokenManager.shared.getRefreshToken() ?? "-")
            return try? JSONEncoder().encode(requestBody)
        }
    }
    
    private var headers: Headers {
        switch self {
        case .login, .refreshToken, .carts:
            return ["Content-Type": "application/json"]
        case .userInfo:
            return ["Authorization": "Bearer " + (AuthTokenManager.shared.getAccessToken() ?? "-")]
        }
    }
}

extension URLRequest {

    mutating func addHeaders(_ headers: Headers) {
        headers.forEach { header, value in
            addValue(value, forHTTPHeaderField: header)
        }
    }

}

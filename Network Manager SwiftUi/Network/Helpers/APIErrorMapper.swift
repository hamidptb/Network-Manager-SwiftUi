//
//  APIErrorMapper.swift
//  Network Manager SwiftUi
//
//  Created by Hamid on 10/17/24.
//

import Foundation

struct APIErrorMapper {

    // MARK: - Types

    enum Context {
        case login
    }

    // MARK: - Properties

    let error: APIError
    let context: Context

    // MARK: - Public API

    var message: String {
        switch error {
        case .unreachable:
            return "You need to have a network connection."
        case .unauthorized:
            switch context {
            default:
                return "You need to be signed in."
            }
        case .unknown,
             .failedRequest,
             .invalidResponse:
            switch context {
            case .login:
                return "Can not be logged in."
            }
        }
    }

}

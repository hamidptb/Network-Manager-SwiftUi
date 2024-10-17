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
        case categories
        case sliders
        case services
        case customerStat
        case pointTransactions
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
            case .categories:
                return "The list of categories could not be fetched."
            case .sliders:
                return "The list of sliders could not be fetched."
            case .services:
                return "The list of services could not be fetched."
            case .customerStat:
                return "The customer stat could not be fetched."
            case .pointTransactions:
                return "The list of point transactions could not be fetched."
            }
        }
    }

}

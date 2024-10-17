//
//  APIPreviewClient.swift
//  Network Manager SwiftUi
//
//  Created by Hamid on 10/17/24.
//

import Combine
import Foundation

struct APIPreviewClient: APIService {
    // MARK: - Methods
    
    func categories() -> AnyPublisher<[Temp], APIError> {
        publisher(for: "categories")
    }
    
    func sliders() -> AnyPublisher<[Temp], APIError> {
        publisher(for: "sliders")
    }

    func services() -> AnyPublisher<[Temp], APIError> {
        publisher(for: "services")
    }
    
    func customerStat() -> AnyPublisher<Temp, APIError> {
        publisher(for: "customerStat")
    }
    
    func pointTransactions() -> AnyPublisher<[Temp], APIError> {
        publisher(for: "pointTransactions")
    }
}

fileprivate extension APIPreviewClient {

    func publisher<T: Decodable>(for resource: String) -> AnyPublisher<T, APIError> {
        Just(stubData(for: resource))
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }

    func stubData<T: Decodable>(for resource: String) -> T {
        guard
            let url = Bundle.main.url(forResource: resource, withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let stubData = try? JSONDecoder().decode(T.self, from: data)
        else {
            fatalError("Unable to Load Stub Data")
        }

        return stubData
    }

}



struct Temp: Codable, Hashable {
}

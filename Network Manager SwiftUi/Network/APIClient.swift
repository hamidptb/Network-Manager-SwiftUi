//
//  APIClient.swift
//  Network Manager SwiftUi
//
//  Created by Hamid on 10/17/24.
//

import Combine
import Foundation

class APIClient: APIService {

    // MARK: - API Service

    func categories() -> AnyPublisher<[Temp], APIError> {
        request(.categories)
    }
    
    func sliders() -> AnyPublisher<[Temp], APIError> {
        request(.sliders)
    }
    
    func services() -> AnyPublisher<[Temp], APIError> {
        request(.services)
    }
    
    func customerStat() -> AnyPublisher<Temp, APIError> {
        request(.customerStat)
    }
    
    func pointTransactions() -> AnyPublisher<[Temp], APIError> {
        request(.pointTransactions)
    }
    
    // MARK: - Helper Methods

    private func request<T: Decodable>(_ endpoint: APIEndpoint) -> AnyPublisher<T, APIError> {
        do {
            let request = try endpoint.request()

            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { data, response -> T in
                    print(String(decoding: data, as: UTF8.self))
                    guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                        throw APIError.failedRequest
                    }

                    guard (200..<300).contains(statusCode) else {
                        if statusCode == 401 {
                            throw APIError.unauthorized
                        } else {
                            throw APIError.failedRequest
                        }
                    }

                    if statusCode == 204, let noContent = NoContent() as? T {
                        return noContent
                    }

                    do {
                        return try JSONDecoder().decode(T.self, from: data)
                    } catch {
                        print("Unable to Decode Response \(error)")
                        throw APIError.invalidResponse
                    }
                }
                .mapError { error -> APIError in
                    switch error {
                    case let apiError as APIError:
                        return apiError
                    case URLError.notConnectedToInternet:
                        return APIError.unreachable
                    default:
                        return APIError.failedRequest
                    }
                }
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        } catch {
            if let apiError = error as? APIError {
                return Fail(error: apiError)
                    .eraseToAnyPublisher()
            } else {
                return Fail(error: APIError.unknown)
                    .eraseToAnyPublisher()
            }
        }
    }

}

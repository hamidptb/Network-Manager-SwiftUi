//
//  APIService.swift
//  Network Manager SwiftUi
//
//  Created by Hamid on 10/17/24.
//

import Combine
import Foundation

protocol APIService {

    // MARK: - Properties
    
    func login(username: String, password: String, expiresInMins: Int) -> AnyPublisher<User, APIError>
    
    func userInfo() -> AnyPublisher<User, APIError>
    
    func carts() -> AnyPublisher<CartResponse, APIError>
}

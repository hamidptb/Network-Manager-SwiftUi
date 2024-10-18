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
    
//    func categories() -> AnyPublisher<[Temp], APIError>
//    
//    func sliders() -> AnyPublisher<[Temp], APIError>
//    
//    func services() -> AnyPublisher<[Temp], APIError>
//    
//    func customerStat() -> AnyPublisher<Temp, APIError>
//    
//    func pointTransactions() -> AnyPublisher<[Temp], APIError>
    
    func login(username: String, password: String, expiresInMins: Int) -> AnyPublisher<User, APIError>
    
    func userInfo() -> AnyPublisher<User, APIError>
    
    
}

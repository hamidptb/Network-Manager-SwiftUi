//
//  HomeViewModel.swift
//  Network Manager SwiftUi
//
//  Created by Hamid on 10/17/24.
//

import Combine
import Foundation

class HomeViewModel: ObservableObject {

    // MARK: - Properties
    
    @Published private(set) var isFetching = false

    @Published private(set) var errorMessage: String?
    
    // MARK: -

    private let apiService: APIService

    // MARK: -

    private var subscriptions: Set<AnyCancellable> = []

    // MARK: -
    
    let dispatchGroup = DispatchGroup()
    
    // MARK: - Initialization

    init(apiService: APIService) {
        self.apiService = apiService
    }

    // MARK: - Helper Methods

    func login(username: String, password: String, expiresInMins: Int) {
        isFetching = true
        
        apiService.login(username: username, password: password, expiresInMins: expiresInMins)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isFetching = false
                
                switch completion {
                case .finished:
                    print("Successfully login")
                case .failure(let error):
                    print("Unable to login \(error)")

                    self?.errorMessage = APIErrorMapper(
                        error: error,
                        context: .login
                    ).message
                }
            }, receiveValue: { [weak self] categories in
//                self?.categories = categories
            }).store(in: &subscriptions)
    }
}

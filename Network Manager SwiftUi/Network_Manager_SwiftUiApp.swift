//
//  Network_Manager_SwiftUiApp.swift
//  Network Manager SwiftUi
//
//  Created by Hamid on 10/17/24.
//

import SwiftUI

@main
struct Network_Manager_SwiftUiApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewModel(apiService: APIClient()))
        }
    }
}

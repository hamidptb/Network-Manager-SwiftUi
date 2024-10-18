//
//  HomeView.swift
//  Network Manager SwiftUi
//
//  Created by Hamid on 10/17/24.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            Button("Login") {
                viewModel.login(username: "emilys", password: "emilyspass", expiresInMins: 30)
            }
            
            Button("User Information") {
                viewModel.userInfo()
            }
            
            Button("Carts") {
                viewModel.carts()
            }
        }
        .padding()
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(apiService: APIPreviewClient()))
}

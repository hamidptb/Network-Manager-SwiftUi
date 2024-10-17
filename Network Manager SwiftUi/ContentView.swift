//
//  ContentView.swift
//  Network Manager SwiftUi
//
//  Created by Hamid on 10/17/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text("Hello, world!")
            
            Button("Login") {
                performLogin(username: "emilys", password: "emilyspass", expiresInMins: 30)
            }
        }
        .padding()
    }
    
    
    
}

#Preview {
    ContentView()
}

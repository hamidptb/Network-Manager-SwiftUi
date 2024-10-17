//
//  Net.swift
//  Network Manager SwiftUi
//
//  Created by Hamid on 10/17/24.
//

import Foundation

struct LoginRequestBody: Codable {
    let username: String
    let password: String
    let expiresInMins: Int
}

struct LoginResponse: Codable {
    let id: Int
    let username: String
    let email: String
    let firstName: String
    let lastName: String
    let gender: String
    let image: String
    let accessToken: String
    let refreshToken: String
}

func performLogin(username: String, password: String, expiresInMins: Int) {
    // The URL of the API
    let url = URL(string: "https://dummyjson.com/auth/login")!
    
    // Create the request body
    let requestBody = LoginRequestBody(username: username, password: password, expiresInMins: expiresInMins)
    
    // Create the URLRequest
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//    request.httpShouldHandleCookies = true  // Equivalent to `credentials: 'include'` in fetch

    // Convert the request body to JSON
    do {
        let jsonData = try JSONEncoder().encode(requestBody)
        request.httpBody = jsonData
    } catch {
        print("Error encoding request body: \(error)")
        return
    }
    
    // Perform the request
    URLSession.shared.dataTask(with: request) { data, response, error in
        // Handle errors
        if let error = error {
            print("Request error: \(error)")
            return
        }
        
        // Check for valid data
        guard let data = data else {
            print("No data returned from the server")
            return
        }
        
        // Decode the response
        do {
            let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
            print("""
                Login successful:
                ID: \(loginResponse.id)
                Username: \(loginResponse.username)
                Email: \(loginResponse.email)
                Name: \(loginResponse.firstName) \(loginResponse.lastName)
                Gender: \(loginResponse.gender)
                Image URL: \(loginResponse.image)
                AccessToken: \(loginResponse.accessToken)
                RefreshToken: \(loginResponse.refreshToken)
            """)
        } catch {
            print("Error decoding response: \(error)")
        }
    }.resume()
}


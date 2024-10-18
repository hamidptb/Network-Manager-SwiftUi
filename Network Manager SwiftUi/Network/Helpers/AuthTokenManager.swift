//
//  AuthTokenManager.swift
//  Network Manager SwiftUi
//
//  Created by Hamid on 10/18/24.
//

import Foundation
import KeychainSwift

class AuthTokenManager {
    static let shared = AuthTokenManager()
    
    private init() {}
    
    let keychain = KeychainSwift()
    
    func setAuthTokens(access: String, refresh: String) {
        keychain.set(access, forKey: "access")
        keychain.set(refresh, forKey: "refresh")
    }
    
    func removeAuthTokens() {
        keychain.delete("access")
        keychain.delete("refresh")
    }
    
    func getAccessToken() -> String? {
        return keychain.get("access")
    }
    
    func getRefreshToken() -> String? {
        return keychain.get("refresh")
    }
}

//
//  APIEndpoint.swift
//  Network Manager SwiftUi
//
//  Created by Hamid on 10/17/24.
//

import Foundation

enum APIEndpoint {

    // MARK: - Cases

    case categories
    case sliders
    case services
    case customerStat
    case pointTransactions
    
    // MARK: - Properties

    func request() throws -> URLRequest {
        var request = URLRequest(url: url)

        request.addHeaders(headers)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = httpBody

        return request
    }

    private var url: URL {
        Environment.apiBaseURL.appendingPathComponent(path)
    }
    
    private var path: String {
        switch self {
        case .categories:
            return "categories"
        case .sliders:
            return "sliders"
        case .services:
            return "services"
        case .customerStat:
            return "customers/1006/stats"
        case .pointTransactions:
            return "customers/1006/point-transactions"
        }
    }

    private var httpMethod: HTTPMethod {
        switch self {
        case .categories, .sliders, .services, .customerStat, .pointTransactions:
            return .get
        }
    }

    private var httpBody: Data? {
        switch self {
        case .categories, .sliders, .services, .customerStat, .pointTransactions:
            return nil
        }
    }

    private var headers: Headers {
        let headers: Headers = [
            "Content-Type": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiIyOTVkZWJkOC00YzJiLTQyMTYtOTIyYS05ZjdjZGQ2MzQzZTciLCJzdWIiOiJhcHAtdXNlckBhcHAubG9jYWwiLCJlbWFpbCI6ImFwcC11c2VyQGFwcC5sb2NhbEBhcHAubG9jYWwiLCJhY2Nlc3NGdWxsIjoiMSIsInBlcm1pc3Npb24iOiIvcmVzb3VyY2VzLyovcGVybWlzc2lvbnMvQ3VzdG9tZXJMb3lhbHR5TWFuYWdlbWVudCIsImF1dGhvcml6YXRpb25fY29kZSI6IjVCMENEQkU0LTMxNTAtNDQxQS04N0ZFLTlCMDA2NTk1QUI4OSIsImV4cCI6MjAxMzA3NjkwNiwiaXNzIjoibG95YWx0eS1hcHBsaWNhdGlvbi1zZXJ2ZXIiLCJhdWQiOiJsb3lhbHR5LWFwcGxpY2F0aW9uLXNlcnZlciJ9.MFpVDpX-wPZPHrIytO995Z0Fb9Lj1llRLeIJW6pQBZU"
        ]
        
        return headers
    }

}

extension URLRequest {

    mutating func addHeaders(_ headers: Headers) {
        headers.forEach { header, value in
            addValue(value, forHTTPHeaderField: header)
        }
    }

}

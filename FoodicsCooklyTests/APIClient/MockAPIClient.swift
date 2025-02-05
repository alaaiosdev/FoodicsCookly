//
//  MockAPIClient.swift
//  FoodicsCooklyTests
//
//  Created by Alaa Abu-Taha on 05/02/2025.
//

import XCTest
@testable import FoodicsCookly

class MockAPIClient: APIClient {
    var mockData: Data?
    var mockError: APIError?
    
    override func performRequest<T>(endpoint: String, parameters: [String : Any]? = nil) async throws -> T where T : Decodable {
        if let error = mockError {
            throw error
        }
        
        guard let data = mockData else {
            throw APIError.invalidResponse
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Decoding Error: \(error)")
            throw APIError.decodingFailed(error)
        }
    }
}

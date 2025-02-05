//
//  APIClient.swift
//  FoodicsCookly
//
//  Created by Alaa Abu-Taha on 05/02/2025.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
}

class APIClient {
    static let shared = APIClient()
    private let baseURL = "https://dummyjson.com"
    
    func performRequest<T: Decodable>(
        endpoint: String,
        parameters: [String: Any]? = nil) async throws -> T {
            
            guard var urlComponents = URLComponents(string: "\(baseURL)/\(endpoint)") else {
                throw APIError.invalidURL
            }
            
            if let params = parameters {
                urlComponents.queryItems = params.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            }
            
            guard let url = urlComponents.url else {
                throw APIError.invalidURL
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    throw APIError.invalidResponse
                }
                
                do {
                    return try JSONDecoder().decode(T.self, from: data)
                } catch {
                    throw APIError.decodingFailed(error)
                }
            } catch {
                throw APIError.requestFailed(error)
            }
        }
}

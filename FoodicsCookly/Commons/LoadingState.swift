//
//  LoadingState.swift
//  FoodicsCookly
//
//  Created by Alaa Abu-Taha on 04/02/2025.
//

import Foundation

enum LoadingState {
    case idle
    case loading
    case error(String)
    
    var isIdle: Bool {
        if case .idle = self { return true }
        return false
    }
    
    var isLoading: Bool {
        if case .loading = self { return true }
        return false
    }
    
    var errorMessage: String? {
        if case .error(let message) = self { return message }
        return nil
    }
}

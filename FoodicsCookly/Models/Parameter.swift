//
//  Parameter.swift
//  FoodicsCookly
//
//  Created by Alaa Abu-Taha on 05/02/2025.
//

import Foundation

struct Parameter: Encodable {
    var limit: Int = 10
    var skip: Int = 0
    var order: Order = .asc

    init() {}
}

enum Order: String, Encodable {
    case asc
    case desc
}

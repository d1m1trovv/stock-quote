//
//  StockDetailsResponseResource.swift
//  stocks
//
//  Created by Admin on 1.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

struct StockDetailsResponseResource: Codable, Hashable {
    let date: String
    let status: String
    let quote: QuoteResponseResource
}

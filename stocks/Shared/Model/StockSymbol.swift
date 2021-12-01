//
//  StockSymbol.swift
//  stocks
//
//  Created by Admin on 1.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

struct StockSymbol {
    let date: String
    let status: String
    let ticker_symbol: String
    
    init(date: String, status: String, ticker_symbol: String) {
        self.date = date
        self.status = status
        self.ticker_symbol = ticker_symbol
    }
}

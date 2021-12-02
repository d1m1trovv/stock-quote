//
//  File.swift
//  stocksTests
//
//  Created by Admin on 2.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation
@testable import stocks

class SearchServiceMock: SearchServiceProtocol {
    var isGetCompanySymbolByNameSuccess = true
    
    var error: NetworkError = .connectionFailed
    var stockSymbol = StockSymbol(date: "", status: "", ticker_symbol: "TEST")
    
    func getCompanySymbolByName(_ companyName: String, completion: @escaping (StockSymbol?, NetworkError?) -> Void) {
        isGetCompanySymbolByNameSuccess ? completion(stockSymbol, nil) : completion(nil, error)
    }
}

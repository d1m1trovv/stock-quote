//
//  File.swift
//  stocksTests
//
//  Created by Admin on 2.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation
@testable import stocks

class HTTPServieMock: HTTPServiceProtocol {
    var error: NetworkError? = nil
    var isGetCompanySymbolByNameSuccess = true
    var isGetStockDetailsBySymbolSuccess = true
    
    var searchResponseResource = SearchStockResponseResource(date: "", status: "", ticker_symbol: "Test")
    var detailsResponseResource = StockDetailsResponseResource(date: "",
                                                               status: "",
                                                               quote: QuoteResponseResource(currentPrice: 1,
                                                                                            todaysOpen: 1,
                                                                                            todaysHigh: 1,
                                                                                            todaysLow: 1,
                                                                                            todaysVolume: 1,
                                                                                            todaysChange: 1,
                                                                                            shares: 1,
                                                                                            marketCapitalization: 1,
                                                                                            fiftyTwoWeekChange: 1,
                                                                                            fiftyTwoWeekLow: 1,
                                                                                            fiftyTwoWeekHigh: 1,
                                                                                            companyName: "Apple",
                                                                                            shortCompanyName: "Apple",
                                                                                            exchange: "test"))
    
    func getCompanySymbolByName(_ companyName: String, completion: @escaping (SearchStockResponseResource?, NetworkError?) -> Void) {
        isGetCompanySymbolByNameSuccess ? completion(searchResponseResource, nil) : completion(nil, error)
    }
    
    func getStockDetailsBySymbol(_ symbol: String, completion: @escaping (StockDetailsResponseResource?, NetworkError?) -> Void) {
        isGetStockDetailsBySymbolSuccess ? completion(detailsResponseResource, nil) : completion(nil, error)
    }
    
    
}

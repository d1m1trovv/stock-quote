//
//  StocksAssemblerMock.swift
//  stocksTests
//
//  Created by Admin on 2.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation
@testable import stocks

class StocksAssemblerMock: StockAssemblerProtocol {
    func convertToStockSymbol(from searchStockResponseResource: SearchStockResponseResource) -> StockSymbol {
        return StockSymbol(date: "", status: "", ticker_symbol: "TEST")
    }
    
    func convertToStock(from stockDetailsResponseResource: StockDetailsResponseResource) -> Stock {
        return Stock(currentPrice: 1,
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
                     companyName: "Test",
                     shortCompanyName: "Test",
                     exchange: "Test")
    }
}

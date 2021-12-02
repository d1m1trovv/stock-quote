//
//  StockAssembler.swift
//  stocks
//
//  Created by Admin on 1.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

protocol StockAssemblerProtocol: AnyObject {
    func convertToStockSymbol(from searchStockResponseResource: SearchStockResponseResource) -> StockSymbol
    func convertToStock(from stockDetailsResponseResource: StockDetailsResponseResource) -> Stock
}

class StockAssembler: StockAssemblerProtocol {
    func convertToStockSymbol(from searchStockResponseResource: SearchStockResponseResource) -> StockSymbol {
        return StockSymbol(date: searchStockResponseResource.date,
                           status: searchStockResponseResource.status,
                           ticker_symbol: searchStockResponseResource.ticker_symbol)
    }
    
    func convertToStock(from stockDetailsResponseResource: StockDetailsResponseResource) -> Stock {
        return Stock(currentPrice: stockDetailsResponseResource.quote.currentPrice,
                     todaysOpen: stockDetailsResponseResource.quote.todaysOpen,
                     todaysHigh: stockDetailsResponseResource.quote.todaysHigh,
                     todaysLow: stockDetailsResponseResource.quote.todaysLow,
                     todaysVolume: stockDetailsResponseResource.quote.todaysVolume,
                     todaysChange: stockDetailsResponseResource.quote.todaysChange,
                     shares: stockDetailsResponseResource.quote.shares,
                     marketCapitalization: stockDetailsResponseResource.quote.marketCapitalization,
                     fiftyTwoWeekChange: stockDetailsResponseResource.quote.fiftyTwoWeekChange,
                     fiftyTwoWeekLow: stockDetailsResponseResource.quote.fiftyTwoWeekLow,
                     fiftyTwoWeekHigh: stockDetailsResponseResource.quote.fiftyTwoWeekHigh,
                     companyName: stockDetailsResponseResource.quote.companyName,
                     shortCompanyName: stockDetailsResponseResource.quote.shortCompanyName,
                     exchange: stockDetailsResponseResource.quote.exchange)
    }
}

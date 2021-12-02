//
//  StockAssemblerTests.swift
//  stocksTests
//
//  Created by Admin on 2.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import XCTest
@testable import stocks

class StockAssemblerTests: XCTestCase {
    var stockAssembler: StockAssembler!
    var searchResponseResource: SearchStockResponseResource!
    var detailsResponseResource: StockDetailsResponseResource!

    override func setUp() {
        super.setUp()
        stockAssembler = StockAssembler()
        searchResponseResource = SearchStockResponseResource(date: "", status: "", ticker_symbol: "Test")
        detailsResponseResource = StockDetailsResponseResource(date: "",
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
    }

    override func tearDown() {
        stockAssembler = nil
        detailsResponseResource = nil
        searchResponseResource = nil
        super.tearDown()
    }
    
    func testIsProperlyConvertedToStockSymbol() {
        let symbol = stockAssembler.convertToStockSymbol(from: searchResponseResource)
        
        XCTAssertEqual(symbol.ticker_symbol, searchResponseResource.ticker_symbol)
    }
    
    func testIsProperlyConvertedToStock() {
        let stock = stockAssembler.convertToStock(from: detailsResponseResource)
        
        XCTAssertEqual(stock.companyName, detailsResponseResource.quote.companyName)
        XCTAssertEqual(stock.shortCompanyName, detailsResponseResource.quote.shortCompanyName)
        XCTAssertEqual(stock.exchange, detailsResponseResource.quote.exchange)
    }
}

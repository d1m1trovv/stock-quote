//
//  StockDetailsInteractorTests.swift
//  stocksTests
//
//  Created by Admin on 2.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import XCTest
@testable import stocks

class StockDetailsInteractorTests: XCTestCase {
    var stockDetailsInteractor: StockDetailsInteractor!
    var detailsService: StockDetailsServiceMock!
    var controller: StockDetailsControllerMock!

    override func setUp() {
        super.setUp()
        detailsService = StockDetailsServiceMock()
        controller = StockDetailsControllerMock()
        stockDetailsInteractor = StockDetailsInteractor(detailsService: detailsService, controller: controller)
        stockDetailsInteractor.symbol = "TEST"
        stockDetailsInteractor.stockDetails = Stock(currentPrice: 1,
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

    override func tearDown() {
        detailsService = nil
        controller = nil
        stockDetailsInteractor = nil
        super.tearDown()
    }
    
    func testIsSetDetailsViewModelExecuted() {
        stockDetailsInteractor.viewLoaded()
        
        XCTAssertEqual(controller.isSetDetailsViewModelExecuted, 1)
    }
    
    func testIsReloadDataExecuted() {
        stockDetailsInteractor.viewLoaded()
        
        XCTAssertEqual(controller.isReloadDataExecuted, 1)
    }
}

//
//  SearchStockInteractorTests.swift
//  stocksTests
//
//  Created by Admin on 2.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import XCTest
@testable import stocks

class SearchStockInteractorTests: XCTestCase {
    var searchInteractor: SearchStockInteractor!
    var searchService: SearchServiceMock!
    var detailsService: StockDetailsServiceMock!
    var mainController: MainControllerMock!
    var resultsController: SearchResultsControllerMock!

    override func setUp() {
        searchService = SearchServiceMock()
        detailsService = StockDetailsServiceMock()
        mainController = MainControllerMock()
        resultsController = SearchResultsControllerMock()
        searchInteractor = SearchStockInteractor(searchService: searchService,
                                                 controller: resultsController,
                                                 detailsService: detailsService,
                                                 mainController: mainController)
        super.setUp()
    }

    override func tearDown() {
        searchService = nil
        detailsService = nil
        resultsController = nil
        mainController = nil
        searchInteractor = nil
        super.tearDown()
    }
    
    func testIsUpdateTableWithSearchResultsExecuted() {
        searchInteractor.readyToUpdateResults("Test")
        
        XCTAssertEqual(resultsController.isUpdateTableWithSearchResultsExecuted, 1)
    }
    
    func testIsErrorThrownWhileUpdatingResults() {
        searchService.isGetCompanySymbolByNameSuccess = false
        
        searchInteractor.readyToUpdateResults("Test")
        
        XCTAssertEqual(resultsController.isUpdateTableWithSearchResultsExecuted, 0)
    }
    
    func testIsNavigateToStockDetailsExecuted() {
        searchInteractor.stockSymbolClicked("TEST")
        
        XCTAssertEqual(mainController.isNavigateToStockDetailsExecuted, 1)
    }
    
    func testIsErrorThrowsWhileFetchingStockDetails() {
        detailsService.isGetStockDetailsBySymbolSuccess = false
        
        searchInteractor.stockSymbolClicked("TEST")
        
        XCTAssertEqual(mainController.isNavigateToStockDetailsExecuted, 0)
    }
}

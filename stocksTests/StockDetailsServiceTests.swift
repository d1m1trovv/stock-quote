//
//  StockDetailsServiceTests.swift
//  stocksTests
//
//  Created by Admin on 2.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import XCTest
@testable import stocks

class StockDetailsServiceTests: XCTestCase {
    var detailsService: StockDetailsService!
    var httpService: HTTPServieMock!
    var stockAssembler: StocksAssemblerMock!
    
    override func setUp() {
        super.setUp()
        httpService = HTTPServieMock()
        stockAssembler = StocksAssemblerMock()
        detailsService = StockDetailsService(httpService: httpService, stockAssembler: stockAssembler)
    }

    override func tearDown() {
        httpService = nil
        stockAssembler = nil
        detailsService = nil
        super.tearDown()
    }

    func testIsGetStockDetailsBySymbolSuccess() {
        let exp = expectation(description: "Success")
        
        detailsService.getStockDetailsBySymbol("TEST") { result, error in
            exp.fulfill()
            if let result = result,
                error == nil {
                XCTAssertEqual(result.companyName, "Test")
                XCTAssertEqual(result.shortCompanyName, "Test")
                XCTAssertEqual(result.exchange, "Test")
            } else {
                XCTFail()
            }
        }
        
        wait(for: [exp], timeout: 0.1)
    }
    
    func testIsGetStockDetailsBySymbolDecodingError() {
        let exp = expectation(description: "Failure")
        
        httpService.isGetStockDetailsBySymbolSuccess = false
        httpService.error = .decodingError
        
        detailsService.getStockDetailsBySymbol("TEST") { result, error in
            exp.fulfill()
            if let _ = result,
                error == nil {
                XCTFail()
            } else {
                XCTAssertEqual(error, .decodingError)
            }
        }
        
        wait(for: [exp], timeout: 0.1)
    }
    
    func testIsGetStockDetailsBySymbolConnectionFailed() {
        let exp = expectation(description: "Failure")
        
        httpService.isGetStockDetailsBySymbolSuccess = false
        httpService.error = .connectionFailed
        
        detailsService.getStockDetailsBySymbol("TEST") { result, error in
            exp.fulfill()
            if let _ = result,
                error == nil {
                XCTFail()
            } else {
                XCTAssertEqual(error, .connectionFailed)
            }
        }
        
        wait(for: [exp], timeout: 0.1)
    }
}

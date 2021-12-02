//
//  SearchServiceTests.swift
//  stocksTests
//
//  Created by Admin on 2.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import XCTest
@testable import stocks

class SearchServiceTests: XCTestCase {
    var searchService: SearchService!
    var httpService: HTTPServieMock!
    var stockAssembler: StocksAssemblerMock!

    override func setUp() {
        super.setUp()
        httpService = HTTPServieMock()
        stockAssembler = StocksAssemblerMock()
        searchService = SearchService(httpService: httpService, stocksAssembler: stockAssembler)
    }

    override func tearDown() {
        httpService = nil
        stockAssembler = nil
        searchService = nil
        super.tearDown()
    }
    
    func testIsGetCompanySymbolByNameSuccess() {
        let exp = expectation(description: "Success")
        
        searchService.getCompanySymbolByName("Apple") { result, error in
            exp.fulfill()
            if let result = result,
                error == nil {
                XCTAssertEqual(result.ticker_symbol, "TEST")
            } else {
                XCTFail()
            }
        }
        
        wait(for: [exp], timeout: 0.1)
    }
    
    func testIsGetCompanySymbolByNameDecodingError() {
        let exp = expectation(description: "Failure")
        
        httpService.isGetCompanySymbolByNameSuccess = false
        httpService.error = .decodingError
        
        searchService.getCompanySymbolByName("Apple") { result, error in
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
    
    func testIsGetCompanySymbolByNameConnectionFailed() {
        let exp = expectation(description: "Failure")
        
        httpService.isGetCompanySymbolByNameSuccess = false
        httpService.error = .connectionFailed
        
        searchService.getCompanySymbolByName("Apple") { result, error in
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

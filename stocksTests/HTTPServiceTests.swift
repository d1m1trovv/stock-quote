//
//  HTTPServiceTests.swift
//  stocksTests
//
//  Created by Admin on 2.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import XCTest
@testable import stocks

class HTTPServiceTests: XCTestCase {
    var httpService: HTTPService!
    var urlSessionMock: URLSessionMock!
    var searchResponseResource: SearchStockResponseResource!
    var detailsResponseResource: StockDetailsResponseResource!
    var quoteResponseResource: QuoteResponseResource!

    override func setUp() {
        super.setUp()
        urlSessionMock = URLSessionMock()
        httpService = HTTPService(session: urlSessionMock)
        searchResponseResource = SearchStockResponseResource(date: "", status: "", ticker_symbol: "Test")
        quoteResponseResource = QuoteResponseResource(currentPrice: 1,
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
                                                      exchange: "test")
        detailsResponseResource = StockDetailsResponseResource(date: "", status: "", quote: quoteResponseResource)
    }

    override func tearDown() {
        urlSessionMock = nil
        httpService = nil
        searchResponseResource = nil
        quoteResponseResource = nil
        detailsResponseResource = nil
        super.tearDown()
    }
    
    func testGetCompanySymbolByNameSuccess() throws {
        let exp = expectation(description: "Success")
        
        let data = try JSONEncoder().encode(searchResponseResource)
        let response = HTTPURLResponse(url: URL(string: "http://google.com")!,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: nil)
        
        urlSessionMock.result = (data, response, nil)
        
        httpService.getCompanySymbolByName("Apple") { result, error in
            exp.fulfill()
            if let result = result,
                error == nil {
                XCTAssertEqual(result, self.searchResponseResource)
            } else {
                XCTFail()
            }
        }
        
        wait(for: [exp], timeout: 0.1)
    }
    
    func testGetCompanySymbolByNameDecodingError() {
        let exp = expectation(description: "Failure")
        
        let data = "Test".data(using: .utf8)
        let response = HTTPURLResponse(url: URL(string: "http://google.com")!,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: nil)
        
        urlSessionMock.result = (data, response, nil)
        
        httpService.getCompanySymbolByName("Apple") { result, error in
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
    
    func testGetCompanySymbolByNameConnectionFailed() {
        let exp = expectation(description: "Failure")
        
        let response = HTTPURLResponse(url: URL(string: "http://google.com")!,
                                       statusCode: 400,
                                       httpVersion: nil,
                                       headerFields: nil)
        
        urlSessionMock.result = (nil, response, nil)
        
        httpService.getCompanySymbolByName("Apple") { result, error in
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
    
    func testGetStockDetailsBySymbol() throws {
        let exp = expectation(description: "Success")
        
        let data = try JSONEncoder().encode(detailsResponseResource)
        let response = HTTPURLResponse(url: URL(string: "http://google.com")!,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: nil)
        
        urlSessionMock.result = (data, response, nil)
        
        httpService.getStockDetailsBySymbol("APPL") { result, error in
            exp.fulfill()
            if let result = result,
                error == nil {
                XCTAssertEqual(result, self.detailsResponseResource)
            } else {
                XCTFail()
            }
        }
        
        wait(for: [exp], timeout: 0.1)
    }
    
    func testGetStockDetailsBySymbolDecodingError() {
        let exp = expectation(description: "Failure")
        
        let data = "Test".data(using: .utf8)
        let response = HTTPURLResponse(url: URL(string: "http://google.com")!,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: nil)
        
        urlSessionMock.result = (data, response, nil)
        
        httpService.getStockDetailsBySymbol("APPL") { result, error in
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
    
    func testGetStockDetailsBySymbolConnectionFailed() {
        let exp = expectation(description: "Failure")

        let response = HTTPURLResponse(url: URL(string: "http://google.com")!,
                                       statusCode: 400,
                                       httpVersion: nil,
                                       headerFields: nil)
        
        urlSessionMock.result = (nil, response, nil)
        
        httpService.getStockDetailsBySymbol("APPL") { result, error in
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

//
//  SearchService.swift
//  stocks
//
//  Created by Admin on 1.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

protocol SearchServiceProtocol: AnyObject {
    func getCompanySymbolByName(_ companyName: String, completion: @escaping (StockSymbol?, NetworkError?) -> Void)
}

class SearchService: SearchServiceProtocol {
    private let httpService: HTTPServiceProtocol
    private let stocksAssembler: StockAssemblerProtocol
    
    init(httpService: HTTPServiceProtocol = HTTPService(),
         stocksAssembler: StockAssemblerProtocol = StockAssembler()) {
        self.httpService = httpService
        self.stocksAssembler = stocksAssembler
    }
    
    func getCompanySymbolByName(_ companyName: String, completion: @escaping (StockSymbol?, NetworkError?) -> Void) {
        httpService.getCompanySymbolByName(companyName) { [weak self] result, error in
            guard let self = self else { return }
            if let result = result,
                error == nil {
                let stockSymbols = self.stocksAssembler.convertToStockSymbol(from: result)
                print(stockSymbols)
                completion(stockSymbols, nil)
            } else {
                completion(nil, error)
            }
        }
    }
}

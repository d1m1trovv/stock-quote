//
//  StockDetailsService.swift
//  stocks
//
//  Created by Admin on 1.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

protocol StockDetailsServiceProtocol: AnyObject {
    func getStockDetailsBySymbol(_ symbol: String,
                                 completion: @escaping (Stock?, NetworkError?) -> Void)
}

class StockDetailsService: StockDetailsServiceProtocol {
    private let httpService: HTTPServiceProtocol
    private let stockAssembler: StockAssemblerProtocol
    
    init(httpService: HTTPServiceProtocol = HTTPService(),
         stockAssembler: StockAssemblerProtocol = StockAssembler()) {
        self.httpService = httpService
        self.stockAssembler = stockAssembler
    }
    
    func getStockDetailsBySymbol(_ symbol: String,
                                 completion: @escaping (Stock?, NetworkError?) -> Void) {
        httpService.getStockDetailsBySymbol(symbol) { [weak self] result, error in
            guard let self = self else { return }
            if let result = result,
                error == nil {
                let stock = self.stockAssembler.convertToStock(from: result)
                completion(stock, nil)
            } else {
                completion(nil, error)
            }
        }
    }
}

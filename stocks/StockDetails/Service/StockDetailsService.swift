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
                                 completion: @escaping (Stock) -> Void)
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
                                 completion: @escaping (Stock) -> Void) {
        //
    }
}

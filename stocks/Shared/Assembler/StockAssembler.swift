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
}

class StockAssembler: StockAssemblerProtocol {
    func convertToStockSymbol(from searchStockResponseResource: SearchStockResponseResource) -> StockSymbol {
        return StockSymbol(date: searchStockResponseResource.date,
                           status: searchStockResponseResource.status,
                           ticker_symbol: searchStockResponseResource.ticker_symbol)
    }
}

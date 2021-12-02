//
//  MainControllerMock.swift
//  stocksTests
//
//  Created by Admin on 2.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation
@testable import stocks

class MainControllerMock: MainControllerProtocol {
    var isNavigateToStockDetailsExecuted = 0
    
    func navigateToStockDetails(_ stockDetails: Stock, _ symbol: String) {
        isNavigateToStockDetailsExecuted += 1
    }
}

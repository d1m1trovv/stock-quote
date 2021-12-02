//
//  File.swift
//  stocksTests
//
//  Created by Admin on 2.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation
@testable import stocks

class StockDetailsControllerMock: StockDetailsControllerProtocol {
    var isSetDetailsViewModelExecuted = 0
    var isReloadDataExecuted = 0
    
    func setDetailsViewModel(_ viewModel: StockDetailsViewModel) {
        isSetDetailsViewModelExecuted += 1
    }
    
    func reloadData() {
        isReloadDataExecuted += 1
    }
}

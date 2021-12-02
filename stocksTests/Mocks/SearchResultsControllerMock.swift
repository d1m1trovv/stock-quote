//
//  SearchResultsControllerMock.swift
//  stocksTests
//
//  Created by Admin on 2.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation
@testable import stocks

class SearchResultsControllerMock: SearchResultsControllerProtocol {
    var isUpdateTableWithSearchResultsExecuted = 0
    
    func updateTableWithSearchResults(_ searchResult: SearchResultViewModel) {
        isUpdateTableWithSearchResultsExecuted += 1
    }
}

//
//  SearchStockInteractor.swift
//  stocks
//
//  Created by Admin on 1.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

protocol SearchStockInteractorProtocol: AnyObject {
    func readyToUpdateResults(_ searchingText: String?)
}

class SearchStockInteractor: SearchStockInteractorProtocol {
    private let searchService: SearchServiceProtocol
    
    weak var controller: SearchResultsControllerProtocol?
    
    init(searchService: SearchServiceProtocol = SearchService(),
         controller: SearchResultsControllerProtocol = SearchResultsController()) {
        self.searchService = searchService
        self.controller = controller
    }
    
    func readyToUpdateResults(_ searchingText: String?) {
        guard let searchingText = searchingText else { return }
        searchService.getCompanySymbolByName(searchingText) { [weak self] result in
            guard let self = self else { return }
            let searchResultViewModels = self.convertToSearchResultViewModel(result) 
            self.controller?.updateTableWithSearchResults(searchResultViewModels)
        }
    }
    
    private func convertToSearchResultViewModel(_ stockSymbol: StockSymbol) -> SearchResultViewModel {
        return SearchResultViewModel(symbol: stockSymbol.ticker_symbol)
    }
}

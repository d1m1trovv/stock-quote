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
    func stockSymbolClicked(_ symbol: String?)
}

class SearchStockInteractor: SearchStockInteractorProtocol {
    private let searchService: SearchServiceProtocol
    private let detailsService: StockDetailsServiceProtocol
    
    weak var controller: SearchResultsControllerProtocol?
    
    init(searchService: SearchServiceProtocol = SearchService(),
         controller: SearchResultsControllerProtocol = SearchResultsController(),
         detailsService: StockDetailsServiceProtocol = StockDetailsService()) {
        self.searchService = searchService
        self.controller = controller
        self.detailsService = detailsService
    }
    
    func readyToUpdateResults(_ searchingText: String?) {
        guard let searchingText = searchingText else { return }
        searchService.getCompanySymbolByName(searchingText) { [weak self] result in
            guard let self = self else { return }
            let searchResultViewModels = self.convertToSearchResultViewModel(result) 
            self.controller?.updateTableWithSearchResults(searchResultViewModels)
        }
        controller?.updateTableWithSearchResults(SearchResultViewModel(symbol: "PSFE"))
    }
    
    func stockSymbolClicked(_ symbol: String?) {
        guard let symbol = symbol else { return }
        detailsService.getStockDetailsBySymbol(symbol) { [weak self] result in
            guard let self = self else { return }
            self.controller?.navigateToStockDetails(result, symbol)
        }
    }
    
    private func convertToSearchResultViewModel(_ stockSymbol: StockSymbol) -> SearchResultViewModel {
        return SearchResultViewModel(symbol: stockSymbol.ticker_symbol)
    }
}

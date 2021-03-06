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
    
    weak var resultsController: SearchResultsControllerProtocol?
    weak var mainController: MainControllerProtocol?
    
    init(searchService: SearchServiceProtocol = SearchService(),
         controller: SearchResultsControllerProtocol = SearchResultsController(),
         detailsService: StockDetailsServiceProtocol = StockDetailsService(),
         mainController: MainControllerProtocol = MainController()) {
        self.searchService = searchService
        self.resultsController = controller
        self.detailsService = detailsService
        self.mainController = mainController
    }
    
    func readyToUpdateResults(_ searchingText: String?) {
        guard let searchingText = searchingText else { return }
        searchService.getCompanySymbolByName(searchingText) { [weak self] result, error in
            guard let self = self else { return }
            if let result = result,
                error == nil {
                let searchResultViewModels = self.convertToSearchResultViewModel(result)
                self.resultsController?.updateTableWithSearchResults(searchResultViewModels)
            } else {
                print(error?.localizedDescription ?? "")
            }
        }
        //resultsController?.updateTableWithSearchResults(SearchResultViewModel(symbol: "PSFE"))
    }
    
    func stockSymbolClicked(_ symbol: String?) {
        guard let symbol = symbol else { return }
        detailsService.getStockDetailsBySymbol(symbol) { [weak self] result, error in
            guard let self = self else { return }
            if let result = result,
                error == nil {
                self.mainController?.navigateToStockDetails(result, symbol)
            } else {
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
    private func convertToSearchResultViewModel(_ stockSymbol: StockSymbol) -> SearchResultViewModel {
        return SearchResultViewModel(symbol: stockSymbol.ticker_symbol)
    }
}

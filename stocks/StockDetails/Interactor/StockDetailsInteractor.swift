//
//  StockDetailsInteractor.swift
//  stocks
//
//  Created by Admin on 2.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

protocol StockDetailsInteractorProtocol: AnyObject {
    func viewLoaded()
}

class StockDetailsInteractor: StockDetailsInteractorProtocol {
    private let detailsService: StockDetailsServiceProtocol
    
    weak var controller: StockDetailsControllerProtocol?
    var stockDetails: Stock?
    var symbol: String?
    
    init(detailsService: StockDetailsServiceProtocol = StockDetailsService(),
         controller: StockDetailsControllerProtocol = StockDetailsController()) {
        self.detailsService = detailsService
        self.controller = controller
    }
    
    func viewLoaded() {
        guard let stock = stockDetails else { return }
        guard let symbol = symbol else { return }
        let detailsViewModel = configureDetailsViewModel(stock, symbol)
        controller?.setDetailsViewModel(detailsViewModel)
        controller?.reloadData()
    }
    
    private func configureDetailsViewModel(_ stock: Stock, _ symbol: String) -> StockDetailsViewModel {
        let quote: [String: Any] = ["Current Price: ": stock.currentPrice,
                                    "Today's Open: ": stock.todaysOpen,
                                    "Today's High: ": stock.todaysHigh,
                                    "Today's Low: ": stock.todaysLow,
                                    "Today's Volumne: ": stock.todaysVolume,
                                    "Today's Change: ": stock.todaysChange,
                                    "Shares Outstanding: ": stock.shares,
                                    "Market Capitalization: ": stock.marketCapitalization,
                                    "52-Week Change: ": stock.fiftyTwoWeekChange,
                                    "52-Week Low: ": stock.fiftyTwoWeekLow,
                                    "52-Week High: ": stock.fiftyTwoWeekHigh,
                                    "Company Name: ": stock.companyName,
                                    "Short Company Name: ": stock.shortCompanyName,
                                    "Exchange: ": stock.exchange]
        return StockDetailsViewModel(title: symbol, quote: quote)
    }
}

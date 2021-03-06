//
//  SearchController.swift
//  stocks
//
//  Created by Admin on 1.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation
import UIKit

protocol MainControllerProtocol: AnyObject {
    func navigateToStockDetails(_ stockDetails: Stock, _ symbol: String)
}

class MainController: UIViewController {
    private var searchController: UISearchController?
    //let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        view.backgroundColor = UIColor(white: 1, alpha: 1)
        configureSearchController()
    }

    private func configureSearchController() {
        let searchResultsController = SearchResultsController()
        let searchInteractor = SearchStockInteractor()
        searchResultsController.interactor = searchInteractor
        searchInteractor.resultsController = searchResultsController
        searchInteractor.mainController = self
        
        searchController = UISearchController(searchResultsController: searchResultsController)
        
        guard let searchController = searchController else { return }
        searchController.searchResultsUpdater = searchResultsController
        searchController.searchBar.placeholder = "Search stocks.."
        searchController.searchBar.sizeToFit()
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
}

extension MainController: MainControllerProtocol {
    func navigateToStockDetails(_ stockDetails: Stock, _ symbol: String) {
        let detailsController = StockDetailsController()
        let detailsInteractor = StockDetailsInteractor(controller: detailsController)
        detailsInteractor.stockDetails = stockDetails
        detailsInteractor.symbol = symbol
        detailsController.interactor = detailsInteractor
        navigationController?.pushViewController(detailsController, animated: true)
    }
}

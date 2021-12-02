//
//  SearchResultsController.swift
//  stocks
//
//  Created by Admin on 1.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation
import UIKit

struct SearchResultViewModel {
    let symbol: String
}

protocol SearchResultsControllerProtocol: AnyObject {
    func updateTableWithSearchResults(_ searchResult: SearchResultViewModel)
}

class SearchResultsController: UITableViewController {
    private var searchResultsViewModel: SearchResultViewModel?
    var interactor: SearchStockInteractorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(SymbolCell.self, forCellReuseIdentifier: SymbolCell.reuseIdentifier)
    }
    
    @objc func sendSearchRequest(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, searchText.trimmingCharacters(in: .whitespaces) != "" else {
            print("empty search")
            return
        }
        
        interactor?.readyToUpdateResults(searchText)
    }
}

extension SearchResultsController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        NSObject.cancelPreviousPerformRequests(withTarget: self,
                                               selector: #selector(self.sendSearchRequest(_:)),
                                               object: searchController.searchBar)
        perform(#selector(self.sendSearchRequest(_:)),
                with: searchController.searchBar,
                afterDelay: 0.3)
    }
}

extension SearchResultsController {
    // DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _ = searchResultsViewModel else { return 0 }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SymbolCell.reuseIdentifier,
                                                       for: indexPath) as? SymbolCell else { fatalError() }
        if let currentResultViewModel = searchResultsViewModel {
            cell.setSymbolLabelText(currentResultViewModel.symbol)
            print(currentResultViewModel.symbol)
        }
//        else {
//            cell.setSymbolLabelText("PSFE")
//        }
        
        return cell
    }
    
    // Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let currentResultViewModel = searchResultsViewModel {
            interactor?.stockSymbolClicked(currentResultViewModel.symbol)
        }
    }
}

extension SearchResultsController: SearchResultsControllerProtocol {
    func updateTableWithSearchResults(_ searchResult: SearchResultViewModel) {
        searchResultsViewModel = searchResult
        tableView.reloadData()
    }
}

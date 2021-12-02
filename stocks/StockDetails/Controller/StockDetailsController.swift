//
//  StockDetailsController.swift
//  stocks
//
//  Created by Admin on 2.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation
import UIKit

struct StockDetailsViewModel {
    let title: String
    let quote: [String: Any]
}

protocol StockDetailsControllerProtocol: AnyObject {
    func setDetailsViewModel(_ viewModel: StockDetailsViewModel)
    func reloadData()
}

class StockDetailsController: UITableViewController {
    var interactor: StockDetailsInteractorProtocol?
    var detailsViewModel = StockDetailsViewModel(title: "", quote: ["Current Price: ": "",
                            "Today's Open: ": "",
                            "Today's High: ": "",
                            "Today's Low: ": "",
                            "Today's Volumne: ": "",
                            "Today's Change: ": "",
                            "Shares Outstanding: ": "",
                            "Market Capitalization: ": "",
                            "52-Week Change: ": "",
                            "52-Week Low: ": "",
                            "52-Week High: ": "",
                            "Company Name: ": "",
                            "Short Company Name: ": "",
                            "Exchange: ": ""])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        
        interactor?.viewLoaded()
        
        tableView.register(HeaderCell.self, forCellReuseIdentifier: HeaderCell.reuseIdentifier)
        tableView.register(DetailCell.self, forCellReuseIdentifier: DetailCell.reuseIdentifier)
    }
}

extension StockDetailsController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 14
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //guard let detailsViewModel = detailsViewModel else { return UITableViewCell() }
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HeaderCell.reuseIdentifier,
                                                           for: indexPath) as? HeaderCell else { fatalError() }
            cell.setTitleLabelText(detailsViewModel.title)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCell.reuseIdentifier,
                                                           for: indexPath) as? DetailCell else { fatalError() }
            //guard let detailsViewModel = detailsViewModel else { return UITableViewCell() }
            let key = Array(detailsViewModel.quote.keys)[indexPath.row]
            cell.setDesciptionLabelText(key)
            let content = detailsViewModel.quote[key]
            if let content = content {
                cell.setContentLabelText(String(describing: content))
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension StockDetailsController: StockDetailsControllerProtocol {
    func setDetailsViewModel(_ viewModel: StockDetailsViewModel) {
        detailsViewModel = viewModel
        //tableView.reloadData()
    }
    func reloadData() {
        tableView.reloadData()
    }
}

//
//  SymbolCell.swift
//  stocks
//
//  Created by Admin on 1.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation
import UIKit

class SymbolCell: UITableViewCell {
    static let reuseIdentifier = String(describing: SymbolCell.self)
    
    lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func setSymbolLabelText(_ text: String) {
        symbolLabel.text = text
    }
    
    private func configureView() {
        contentView.layoutMargins = UIEdgeInsets(top: 8.0, left: 16.0, bottom: 8.0, right: 16.0)
        contentView.addSubview(symbolLabel)
        
        let guide = contentView.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            symbolLabel.topAnchor.constraint(equalTo: guide.topAnchor),
            symbolLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            symbolLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            symbolLabel.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
    }
}

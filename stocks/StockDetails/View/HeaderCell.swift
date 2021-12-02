//
//  HeaderCell.swift
//  stocks
//
//  Created by Admin on 2.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation
import UIKit

class HeaderCell: UITableViewCell {
    static let reuseIdentifier = String(describing: HeaderCell.self)
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.textAlignment = .center
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
    
    func setTitleLabelText(_ text: String) {
        titleLabel.text = text
    }
    
    private func configureView() {
        contentView.layoutMargins = UIEdgeInsets(top: 8.0, left: 16.0, bottom: 8.0, right: 16.0)
        contentView.addSubview(titleLabel)
        
        let guide = contentView.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: guide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
            ])
    }
}


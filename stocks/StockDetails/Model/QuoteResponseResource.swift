//
//  QuoteResponseResource.swift
//  stocks
//
//  Created by Admin on 1.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

struct QuoteResponseResource: Codable, Hashable {
    let currentPrice: Float
    let todaysOpen: Float
    let todaysHigh: Float
    let todaysLow: Float
    let todaysVolume: Float
    let todaysChange: Float
    let shares: Int
    let marketCapitalization: Int
    let fiftyTwoWeekChange: Float
    let fiftyTwoWeekLow: Float
    let fiftyTwoWeekHigh: Float
    let companyName: String
    let shortCompanyName: String
    let exchange: String
    
    enum CodingKeys: String, CodingKey {
        case currentPrice = "Current Price"
        case todaysOpen = "Today's Open"
        case todaysHigh = "Today's High"
        case todaysLow = "Today's Low"
        case todaysVolume = "Today's Volume"
        case todaysChange = "Today's Change"
        case shares = "Shares Outstanding"
        case marketCapitalization = "Market Capitalization"
        case fiftyTwoWeekChange = "52-Week Change"
        case fiftyTwoWeekLow = "52-Week Low"
        case fiftyTwoWeekHigh = "52-Week High"
        case companyName = "Company Name"
        case shortCompanyName = "Short Company Name"
        case exchange = "Exchange"
    }
}

//
//  HTTPService.swift
//  stocks
//
//  Created by Admin on 1.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

protocol HTTPServiceProtocol: AnyObject {
    func getCompanySymbolByName()
}

class HTTPService {
    private let getCompanySymbolURL = "https://stock-market-data.p.rapidapi.com/search/company-name-to-ticker-symbol?company_name="
    
    
    func getCompanySymbolByName(_ companyName: String,
                                completion: @escaping ([SearchStockResponseResource]) -> Void) {
        guard let url = URL(string: getCompanySymbolURL) else { return }
        
        let request = createRequest(url, "GET")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
                let httpResponse = response as? HTTPURLResponse,
                (200..<300).contains(httpResponse.statusCode),
                error == nil {
                do {
                    let stocks = try JSONDecoder().decode([SearchStockResponseResource].self, from: data)
                    completion(stocks)
                } catch let error {
                    print(error.localizedDescription)
                    return
                }
            }
        }
    }
    
    private func createRequest(_ url: URL, _ method: String) -> URLRequest {
        let headers = [
            "x-rapidapi-host": "stock-market-data.p.rapidapi.com",
            "x-rapidapi-key": "beb546768amsh3e44423225e7191p1abdcajsn6acfa369c46c"
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        
        return request
    }
}

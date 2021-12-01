//
//  HTTPService.swift
//  stocks
//
//  Created by Admin on 1.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

protocol HTTPServiceProtocol: AnyObject {
    func getCompanySymbolByName(_ companyName: String,
                                completion: @escaping (SearchStockResponseResource) -> Void)
}

class HTTPService: HTTPServiceProtocol {
    private let getCompanySymbolURL = "https://stock-market-data.p.rapidapi.com/search/company-name-to-ticker-symbol?company_name="
    
    
    func getCompanySymbolByName(_ companyName: String,
                                completion: @escaping (SearchStockResponseResource) -> Void) {
        guard let url = URL(string: getCompanySymbolURL + companyName) else { return }
        
        let request = createRequest(url, "GET")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
                let httpResponse = response as? HTTPURLResponse,
                (200..<300).contains(httpResponse.statusCode),
                error == nil {
                do {
                    let stocks = try JSONDecoder().decode(SearchStockResponseResource.self, from: data)
                    DispatchQueue.main.async {
                        completion(stocks)
                    }
                } catch let error {
                    print(error.localizedDescription)
                    return
                }
            }
        }.resume()
    }
    
    private func createRequest(_ url: URL, _ method: String) -> URLRequest {
        let headers = [
            "x-rapidapi-host": "stock-market-data.p.rapidapi.com",
            "x-rapidapi-key": "828609b044msh172ee1c787b9618p133205jsn8eee13ad9b52"
        ]
        
        var request = URLRequest(url: url,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 20.0)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        
        return request
    }
}

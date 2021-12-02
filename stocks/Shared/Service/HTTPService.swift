//
//  HTTPService.swift
//  stocks
//
//  Created by Admin on 1.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

protocol URLSessionProtocol: AnyObject {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}

protocol HTTPServiceProtocol: AnyObject {
    func getCompanySymbolByName(_ companyName: String,
                                completion: @escaping (SearchStockResponseResource) -> Void)
    func getStockDetailsBySymbol(_ symbol: String,
    completion: @escaping (StockDetailsResponseResource) -> Void)
}

class HTTPService: HTTPServiceProtocol {
    private let session: URLSessionProtocol
    private let getCompanySymbolURL = "https://stock-market-data.p.rapidapi.com/search/company-name-to-ticker-symbol?company_name="
    private let getStockDetailsURL = "https://stock-market-data.p.rapidapi.com/stock/quote?ticker_symbol="
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func getCompanySymbolByName(_ companyName: String,
                                completion: @escaping (SearchStockResponseResource) -> Void) {
        guard let url = URL(string: getCompanySymbolURL + companyName) else { return }
        
        let request = createRequest(url, "GET")
        
        session.dataTask(with: request) { data, response, error in
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
    
    func getStockDetailsBySymbol(_ symbol: String,
                                 completion: @escaping (StockDetailsResponseResource) -> Void) {
        guard let url = URL(string: getStockDetailsURL + symbol) else { return }
        
        let request = createRequest(url, "GET")
        
        session.dataTask(with: request) { data, response, error in
            if let data = data,
                let httpResponse = response as? HTTPURLResponse,
                (200..<300).contains(httpResponse.statusCode),
                error == nil {
                do {
                    let details = try JSONDecoder().decode(StockDetailsResponseResource.self, from: data)
                    DispatchQueue.main.async {
                        completion(details)
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
            "x-rapidapi-key": "f57793f37emsh71620bb5e54abfap12ebcejsn3e4b5995c81f"
        ]
        
        var request = URLRequest(url: url,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 20.0)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        
        return request
    }
}

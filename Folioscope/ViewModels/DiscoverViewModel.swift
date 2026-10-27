//
//  DiscoverViewModel.swift
//  Folioscope
//
//  Created by Anas Muhsin on 26/10/2026.
//

import Observation

@Observable
class DiscoverViewModel {
    private(set) var stocks: [Stock] = []
    private let service: MockMarketDataService
    
    init(service: MockMarketDataService) {
        self.service = service
    }
    
    func loadStocks() {
        stocks = service.fetchStocks()
    }
    
    func testSampleDecoding() {
        do {
            let quotes = try getQuotes()

            if let quote = quotes.first {
                let stock = quote.toStock()
                
                print("Quote:", quote.symbol, quote.name, quote.price)
                
                print (
                    "Converted Stock",
                    stock.symbol,
                    stock.companyName,
                    stock.price,
                    stock.dailyChangePercent
                )
                
            }

            let results = try getSearchResults()

            for result in results {
                print("Search:", result.symbol, result.name)
            }
        } catch {
            print("Sample loading failed:", error)
        }
    }
}

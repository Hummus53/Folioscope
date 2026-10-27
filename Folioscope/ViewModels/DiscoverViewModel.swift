//
//  DiscoverViewModel.swift
//  Folioscope
//
//  Created by Anas Muhsin on 26/10/2026.
//

import Observation

@MainActor
@Observable
class DiscoverViewModel {
    private(set) var stocks: [Stock] = []
    private let service: any MarketDataService
    private(set) var isLoading = false
    private(set) var errorMessage: String?
    
    init(service: any MarketDataService) {
        self.service = service
    }
    
    func loadStocks() async {
        isLoading = true
        errorMessage = nil

        defer {
            isLoading = false
        }

        do {
            stocks = try await service.fetchStocks()
        } catch is CancellationError {
            return
        } catch {
            errorMessage = "Unable to load stocks. Please try again."
        }
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

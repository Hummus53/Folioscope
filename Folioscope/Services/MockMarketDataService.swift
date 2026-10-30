//
//  MockMarketDataService.swift
//  Folioscope
//
//  Created by Anas Muhsin on 26/10/2026.
//

import Foundation

struct MockMarketDataService: MarketDataService {

    func fetchStocks() async throws -> [Stock] {
        return Stock.samples
    }

    func searchStocks(query: String) async throws -> [StockSearchResponse] {
        let results = try getSearchResults()

        return results.filter { result in
            result.symbol.localizedCaseInsensitiveContains(query)
        }
    }
}

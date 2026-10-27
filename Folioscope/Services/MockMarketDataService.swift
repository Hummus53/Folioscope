//
//  MockMarketDataService.swift
//  Folioscope
//
//  Created by Anas Muhsin on 26/10/2026.
//

struct MockMarketDataService: MarketDataService {
    func fetchStocks() async throws -> [Stock] {
        return Stock.samples
    }
}

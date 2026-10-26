//
//  MockMarketDataService.swift
//  Folioscope
//
//  Created by Anas Muhsin on 26/10/2026.
//

struct MockMarketDataService {
    func fetchStocks() -> [Stock] {
        return Stock.samples
    }
}

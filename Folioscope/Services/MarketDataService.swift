//
//  MarketDataService.swift
//  Folioscope
//
//  Created by Anas Muhsin on 27/10/2026.
//

protocol MarketDataService {
    func fetchStocks() async throws -> [Stock]
}

//
//  StockSearchResponse.swift
//  Folioscope
//
//  Created by Anas Muhsin on 27/10/2026.
//

struct StockSearchResponse: Codable {
    let symbol: String
    let name: String
    let currency: String
    let exchangeFullName: String
    let exchange: String
}

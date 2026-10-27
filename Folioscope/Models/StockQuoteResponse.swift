//
//  StockQuoteResponse.swift
//  Folioscope
//
//  Created by Anas Muhsin on 27/10/2026.
//

struct StockQuoteResponse: Codable {
    let symbol: String
    let name: String
    let price: Double
    let change: Double
    let changePercentage: Double
    let timestamp: Double
    
}

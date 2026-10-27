//
//  Stock.swift
//  Folioscope
//
//  Created by Anas Muhsin on 25/10/2026.
//

import Foundation

struct Stock: Identifiable {
    let symbol: String
    let companyName: String
    let price: Double
    let dailyChangePercent: Double
    
    var id: String {
        symbol
    }
}

extension Stock {
    static let samples: [Stock] = [
        Stock(
            symbol: "AAPL",
            companyName: "Apple Inc.",
            price: 190.25,
            dailyChangePercent: 1.35
        ),
        Stock(
            symbol: "MSFT",
            companyName: "Microsoft Corporation",
            price: 420.50,
            dailyChangePercent: -0.82
        ),
        Stock(
            symbol: "GOOGL",
            companyName: "Alphabet Inc.",
            price: 175.30,
            dailyChangePercent: 0.65
        ),
        Stock(
            symbol: "AMZN",
            companyName: "Amazon.com Inc.",
            price: 185.10,
            dailyChangePercent: -1.24
        ),
        Stock(
            symbol: "NVDA",
            companyName: "NVIDIA Corporation",
            price: 125.75,
            dailyChangePercent: 0
        )
    ]
}

extension StockQuoteResponse {
    func toStock() -> Stock {
        return Stock (
            symbol: symbol,
            companyName: name,
            price: price,
            dailyChangePercent: changePercentage
        )
    }
}

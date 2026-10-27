//
//  FMPMarketDataService.swift
//  Folioscope
//
//  Created by Anas Muhsin on 27/10/2026.
//

import Foundation

struct FMPMarketDataService: MarketDataService {

    func fetchStocks() async throws -> [Stock] {
        guard var components = URLComponents(
            string: "https://financialmodelingprep.com/stable/quote"
        ) else {
            throw MarketDataError.invalidURL
        }

        components.queryItems = [
            URLQueryItem(name: "symbol", value: "AAPL"),
            URLQueryItem(name: "apikey", value: Secrets.fmpAPIKey)
        ]

        guard let url = components.url else {
            throw MarketDataError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse else {
            throw MarketDataError.invalidResponse
        }

        guard response.statusCode == 200 else {
            throw MarketDataError.httpError(response.statusCode)
        }

        let quotes: [StockQuoteResponse]

        do {
            let decoder = JSONDecoder()

            quotes = try decoder.decode (
                [StockQuoteResponse].self,
                from: data
            )
        } catch {
            throw MarketDataError.invalidData
        }

        guard !quotes.isEmpty else {
            throw MarketDataError.noResults
        }

        return quotes.map { quote in
            quote.toStock()
        }
    }
}

enum MarketDataError: Error {
    case invalidURL
    case invalidResponse
    case httpError(Int)
    case invalidData
    case noResults
}

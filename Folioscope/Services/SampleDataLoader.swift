//
//  SampleDataLoader.swift
//  Folioscope
//
//  Created by Anas Muhsin on 27/10/2026.
//

import Foundation

func getQuotes() throws -> [StockQuoteResponse] {
    guard let url = Bundle.main.url (
        forResource: "sample_quote",
        withExtension: "json"
    ) else {
        throw SampleDataError.fileNotFound
    }
    
    let data = try Data(contentsOf: url)
    
    do {
        let decoder = JSONDecoder()
        
        return try decoder.decode([StockQuoteResponse].self, from: data)
    } catch {
        throw SampleDataError.invalidData
    }
}

func getSearchResults() throws -> [StockSearchResponse] {
    guard let url = Bundle.main.url (
        forResource: "sample_search",
        withExtension: "json"
    ) else {
        throw SampleDataError.fileNotFound
    }
    
    let data = try Data(contentsOf: url)
    
    do {
        let decoder = JSONDecoder()
        
        return try decoder.decode([StockSearchResponse].self, from: data)
    } catch {
        throw SampleDataError.invalidData
    }
}


enum SampleDataError: Error {
    case fileNotFound
    case invalidData
}

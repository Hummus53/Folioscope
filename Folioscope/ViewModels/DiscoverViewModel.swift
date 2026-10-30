//
//  DiscoverViewModel.swift
//  Folioscope
//
//  Created by Anas Muhsin on 26/10/2026.
//

import Foundation
import Observation

@MainActor
@Observable
class DiscoverViewModel {

    private(set) var stocks: [Stock] = []
    private(set) var isLoading = false
    private(set) var errorMessage: String?

    var searchText = ""

    private(set) var searchResults: [StockSearchResponse] = []
    private(set) var isSearching = false
    private(set) var searchError: String?
    private(set) var hasSearched = false

    private let service: any MarketDataService

    init(service: any MarketDataService) {
        self.service = service
    }

    func loadStocks() async {
        guard !isLoading else { return }

        isLoading = true
        errorMessage = nil

        defer {
            isLoading = false
        }

        do {
            stocks = try await service.fetchStocks()
        } catch {
            if Task.isCancelled {
                return
            }

            errorMessage = "Unable to load stocks. Please try again."
        }
    }

    func searchStocks() async {
        let query = searchText.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !query.isEmpty else {
            clearSearch()
            return
        }

        guard !isSearching else { return }

        isSearching = true
        searchError = nil
        searchResults = []
        hasSearched = true

        defer {
            isSearching = false
        }

        do {
            let results = try await service.searchStocks(query: query)

            guard searchText.trimmingCharacters(
                in: .whitespacesAndNewlines
            ) == query else {
                return
            }

            searchResults = results
        } catch {
            if Task.isCancelled {
                return
            }

            guard searchText.trimmingCharacters(
                in: .whitespacesAndNewlines
            ) == query else {
                return
            }

            searchError = "Unable to search stocks. Please try again."
        }
    }

    func clearSearch() {
        searchResults = []
        searchError = nil
        hasSearched = false
    }
}

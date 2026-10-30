//
//  DiscoverView.swift
//  Folioscope
//
//  Created by Anas Muhsin on 25/10/2026.
//

import SwiftUI

struct DiscoverView: View {

    @State private var viewModel: DiscoverViewModel

    init(service: any MarketDataService = FMPMarketDataService()) {
        _viewModel = State(initialValue: DiscoverViewModel(service: service))
    }

    private var hasSearchText: Bool {
        !viewModel.searchText.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty
    }

    var body: some View {
        NavigationStack {
            Group {
                if hasSearchText {
                    searchContent
                } else {
                    stockContent
                }
            }
            .navigationTitle("Discover")
            .searchable(
                text: $viewModel.searchText,
                prompt: "Search a ticker, e.g. AAPL"
            )
            .onSubmit(of: .search) {
                Task {
                    await viewModel.searchStocks()
                }
            }
            .onChange(of: viewModel.searchText) {
                viewModel.clearSearch()
            }
            .task {
                await viewModel.loadStocks()
            }
        }
    }

    @ViewBuilder
    private var stockContent: some View {
        if viewModel.isLoading {
            ProgressView("Loading stocks...")
        } else if let message = viewModel.errorMessage {
            VStack(spacing: 16) {
                Text(message)
                    .multilineTextAlignment(.center)

                Button("Retry") {
                    Task {
                        await viewModel.loadStocks()
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        } else {
            List(viewModel.stocks) { stock in
                NavigationLink {
                    StockDetailView(stock: stock)
                } label: {
                    StockRowView(stock: stock)
                }
            }
        }
    }

    @ViewBuilder
    private var searchContent: some View {
        if viewModel.isSearching {
            ProgressView("Searching...")
        } else if let message = viewModel.searchError {
            VStack(spacing: 16) {
                Text(message)
                    .multilineTextAlignment(.center)

                Button("Retry") {
                    Task {
                        await viewModel.searchStocks()
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        } else if !viewModel.hasSearched {
            ContentUnavailableView(
                "Search stocks",
                systemImage: "magnifyingglass",
                description: Text(
                    "Enter a ticker and press Search on the keyboard."
                )
            )
        } else if viewModel.searchResults.isEmpty {
            ContentUnavailableView(
                "No results",
                systemImage: "magnifyingglass",
                description: Text("Try another stock ticker.")
            )
        } else {
            List(
                viewModel.searchResults,
                id: \.symbol
            ) { result in
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(result.symbol)
                            .font(.headline)

                        Text(result.name)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: 4) {
                        Text(result.exchange)
                        Text(result.currency)
                    }
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }
            }
        }
    }
}

#Preview {
    DiscoverView(service: MockMarketDataService())
}

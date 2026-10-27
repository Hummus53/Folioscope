//
//  DiscoverView.swift
//  Folioscope
//
//  Created by Anas Muhsin on 25/10/2026.
//

import SwiftUI

struct DiscoverView: View {
    @State private var viewModel = DiscoverViewModel(
        service: FMPMarketDataService()
    )

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading stocks...")
                } else if let message = viewModel.errorMessage {
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                            .foregroundStyle(.orange)

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
            .navigationTitle("Discover")
            .task {
                await viewModel.loadStocks()
            }
        }
    }
}

#Preview {
    DiscoverView()
}

//
//  PortfolioView.swift
//  Folioscope
//
//  Created by Anas Muhsin on 26/10/2026.
//

import SwiftUI

struct PortfolioView: View {
    @State private var viewModel = DiscoverViewModel(
        service: MockMarketDataService()
    )

    private let portfolioValue = 10_750.00
    private let totalInvested = 10_000.00

    private var gainLoss: Double {
        portfolioValue - totalInvested
    }

    private var gainLossPercent: Double {
        guard totalInvested > 0 else { return 0 }
        return (gainLoss / totalInvested) * 100
    }

    private var gainLossColor: Color {
        gainLoss >= 0 ? .green : .red
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    summaryCard
                }
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)

                Section("Sample Holdings") {
                    ForEach(viewModel.stocks) { stock in
                        NavigationLink {
                            StockDetailView(stock: stock)
                        } label: {
                            StockRowView(stock: stock)
                        }
                    }
                }
            }
            .navigationTitle("Portfolio")
            .task {
                await viewModel.loadStocks()
            }
        }
    }

    private var summaryCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Label("Mock portfolio", systemImage: "info.circle")
                .font(.caption)
                .foregroundStyle(.secondary)

            VStack(alignment: .leading, spacing: 6) {
                Text("Total Value")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text(
                    portfolioValue,
                    format: .currency(code: "USD")
                )
                .font(.largeTitle.bold())
                .lineLimit(1)
                .minimumScaleFactor(0.6)
            }

            Divider()

            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("Total Invested")
                        .foregroundStyle(.secondary)

                    Spacer()

                    Text(
                        totalInvested,
                        format: .currency(code: "USD")
                    )
                    .fontWeight(.medium)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text("Total Gain / Loss")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Text(
                        String(
                            format: "%@US$%.2f (%+.2f%%)",
                            gainLoss >= 0 ? "+" : "-",
                            abs(gainLoss),
                            gainLossPercent
                        )
                    )
                    .font(.headline)
                    .foregroundStyle(gainLossColor)
                }
            }

            Text("Sample totals are illustrative and are not calculated from the stocks below.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Color(.secondarySystemGroupedBackground),
            in: RoundedRectangle(cornerRadius: 20)
        )
    }
}

#Preview {
    PortfolioView()
}

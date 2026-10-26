import SwiftUI

struct StockDetailView: View {
    let stock: Stock

    private var changeColor: Color {
        stock.dailyChangePercent >= 0 ? .green : .red
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(stock.symbol)
                        .font(.largeTitle.bold())

                    Text(stock.companyName)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text(
                        stock.price,
                        format: .currency(code: "USD")
                    )
                    .font(.system(size: 40, weight: .bold))
                    .minimumScaleFactor(0.6)
                    .lineLimit(1)

                    HStack(spacing: 6) {
                        Image (
                            systemName: stock.dailyChangePercent >= 0 ? "arrow.up.right" : "arrow.down.right"
                        )

                        Text (
                            String (
                                format: "%+.2f%%",
                                stock.dailyChangePercent
                            )
                        )
                    }
                    .font(.headline)
                    .foregroundStyle(changeColor)
                }

                Label("Mock market data", systemImage: "info.circle")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .navigationTitle(stock.symbol)
        .navigationBarTitleDisplayMode(.inline)
    }
}

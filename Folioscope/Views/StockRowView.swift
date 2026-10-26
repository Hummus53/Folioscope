//
//  StockRowView.swift
//  Folioscope
//
//  Created by Anas Muhsin on 25/10/2026.
//

import SwiftUI

struct StockRowView: View {
    let stock: Stock

    private var changeColor: Color {
        if stock.dailyChangePercent > 0 {
            return .green
        } else if stock.dailyChangePercent < 0 {
            return .red
        } else {
            return .secondary
        }
    }

    private var formattedChange: String {
        let sign = stock.dailyChangePercent > 0 ? "+" : ""
        return "\(sign)\(stock.dailyChangePercent.formatted(.number.precision(.fractionLength(2))))%"
    }

    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text(stock.symbol)
                    .font(.headline)

                Text(stock.companyName)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }

            Spacer(minLength: 12)

            VStack(alignment: .trailing, spacing: 4) {
                Text(stock.price, format: .currency(code: "USD"))
                    .font(.headline)
                    .monospacedDigit()

                Text(formattedChange)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(changeColor)
                    .monospacedDigit()
            }
        }
        .padding(.vertical, 8)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(stock.companyName), \(stock.symbol)")
        .accessibilityValue(
            "\(stock.price.formatted(.currency(code: "USD"))), daily change \(formattedChange)"
        )
    }
}

#Preview("Stocks") {
    List(Stock.samples) { stock in
        StockRowView(stock: stock)
    }
}

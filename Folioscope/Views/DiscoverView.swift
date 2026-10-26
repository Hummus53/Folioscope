//
//  DiscoverView.swift
//  Folioscope
//
//  Created by Anas Muhsin on 25/10/2026.
//

import SwiftUI

struct DiscoverView: View {
    var body: some View {
        NavigationStack {
            List(Stock.samples) { stock in
                StockRowView(stock: stock)
            }
            .navigationTitle("Discover")
        }
    }
}

#Preview {
    DiscoverView()
}

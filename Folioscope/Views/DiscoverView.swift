//
//  DiscoverView.swift
//  Folioscope
//
//  Created by Anas Muhsin on 25/10/2026.
//

import SwiftUI

struct DiscoverView: View {
    
    @State private var viewModel = DiscoverViewModel (
        service: MockMarketDataService()
    )
    
    var body: some View {
        NavigationStack {
            List(viewModel.stocks) { stock in
                NavigationLink {
                    StockDetailView(stock: stock)
                } label: {
                    StockRowView(stock: stock)
                }
            }
            .navigationTitle("Discover")
            .onAppear {
                viewModel.loadStocks()
            }
        }
    }
}

#Preview {
    DiscoverView()
}

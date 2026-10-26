//
//  DiscoverViewModel.swift
//  Folioscope
//
//  Created by Anas Muhsin on 26/10/2026.
//

import Observation

@Observable
class DiscoverViewModel {
    private(set) var stocks: [Stock] = []
    private let service: MockMarketDataService
    
    init(service: MockMarketDataService) {
        self.service = service
    }
    
    func loadStocks() {
        stocks = service.fetchStocks()
    }
}

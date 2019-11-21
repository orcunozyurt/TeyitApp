//
//  NewsListViewModel.swift
//  TeyitApp
//
//  Created by Orcun Ozyurt on 11/21/19.
//  Copyright © 2019 Orcun Ozyurt. All rights reserved.
//

import SwiftUI
import Combine

class NewsListViewModel: ObservableObject, Identifiable {
    @Published var dataSource: [NewsItemViewModel] = []
    
    private let network: NetworkServiceProtocol
    private var disposables = Set<AnyCancellable>()
    
    init(network: NetworkServiceProtocol) {
      self.network = network
    }
    
    func fetchNews() {
        network.fetchNews()
            .map { response in
                response.map()
        }
    }
}

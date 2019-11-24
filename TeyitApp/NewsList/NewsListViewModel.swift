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
        fetchNews()
    }
    
    func fetchNews() {
        network.fetchNews()
            .map { response in
                response.map { item in
                    NewsItemViewModel(item: item, network: self.network)
                }
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                  self.dataSource = []
                case .finished:
                  break
                }
            }, receiveValue: { [weak self] data in
                guard let self = self else { return }
                self.dataSource = data
            })
            .store(in: &disposables)
    }
}

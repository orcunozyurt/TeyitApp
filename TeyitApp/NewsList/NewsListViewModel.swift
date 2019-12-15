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
    @Published var isLoading: Bool = false
    
    private let network: NetworkServiceProtocol
    private var disposables = Set<AnyCancellable>()
    
    
    init(network: NetworkServiceProtocol) {
        self.network = network
        fetchNews()
    }
    
    func isLoadingActive() -> Bool {
        return self.isLoading
    }
    
    func fetchNews() {
        isLoading = true
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
                  self.isLoading = false
                case .finished:
                    self.isLoading = false
                  break
                }
            }, receiveValue: { [weak self] data in
                guard let self = self else { return }
                self.isLoading = false
                self.dataSource = data
            })
            .store(in: &disposables)
    }
}

//
//  NewsDetailViewModel.swift
//  TeyitApp
//
//  Created by Orcun Ozyurt on 11/21/19.
//  Copyright © 2019 Orcun Ozyurt. All rights reserved.
//

import SwiftUI
import Combine

class NewsDetailViewModel: ObservableObject, Identifiable {
    @Published var dataSource: NewsDetail?

    let slug: String
    private let network: NetworkServiceProtocol
    private var disposables = Set<AnyCancellable>()
    
    init(url_slug: String, network: NetworkServiceProtocol) {
        self.slug = url_slug
        self.network = network
        fetchDetails()
    }
    
    func fetchDetails() {
        network.fetchDetails(from: self.slug)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                  self.dataSource = nil
                case .finished:
                  break
                }
            }, receiveValue: { [weak self] data in
                guard let self = self else { return }
                self.dataSource = data
            })
            .store(in: &disposables)
    }
    
    var title: String {
        guard let title = dataSource?.title else { return "" }
        return title
    }
    
    var author: String {
        guard let author = dataSource?.author else { return "" }
        return author
    }
    
    var content: String {
        guard let content = dataSource?.content else { return "" }
        return content
    }
    
    var claim: String {
        guard let claim = dataSource?.claim else { return "" }
        return claim
    }
    
    var proven: Bool {
        guard let proven = dataSource?.proven else { return false }
        return proven
    }
    
    var date: String {
        guard let date = dataSource?.date else { return "" }
        return date
    }
    
    var images: [String] {
        guard let images = dataSource?.images else { return [] }
        return images
    }
}

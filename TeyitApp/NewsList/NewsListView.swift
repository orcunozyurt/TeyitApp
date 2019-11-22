//
//  NewsListView.swift
//  TeyitApp
//
//  Created by Orcun Ozyurt on 11/21/19.
//  Copyright © 2019 Orcun Ozyurt. All rights reserved.
//

import SwiftUI

struct NewsListView: View {
    @ObservedObject var viewModel: NewsListViewModel

    init(viewModel: NewsListViewModel) {
      self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            List {
                if viewModel.dataSource.isEmpty {
                    emptySection
                } else {
                    newsListSection
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("News List")
        }
    }

}

private extension NewsListView {
    var newsListSection: some View {
        Section {
            ForEach(viewModel.dataSource, content: NewsItemView.init(viewModel:))
        }
    }
    
    var emptySection: some View {
      Section {
        Text("No results")
          .foregroundColor(.gray)
      }
    }
}

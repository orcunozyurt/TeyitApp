//
//  NewsListView.swift
//  TeyitApp
//
//  Created by Orcun Ozyurt on 11/21/19.
//  Copyright © 2019 Orcun Ozyurt. All rights reserved.
//

import SwiftUI
import SwiftUIPullToRefresh

struct NewsListView: View {
    @ObservedObject var viewModel: NewsListViewModel

    init(viewModel: NewsListViewModel) {
        self.viewModel = viewModel
        UITableView.appearance().separatorStyle = .none
    }

    var body: some View {
        
            RefreshableNavigationView(title: "Teyit", action:{
                self.viewModel.fetchNews()
            }){
                if self.viewModel.dataSource.isEmpty {
                    self.emptySection
                } else {
                    self.newsListSection
                }
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

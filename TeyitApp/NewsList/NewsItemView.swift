//
//  NewsItemView.swift
//  TeyitApp
//
//  Created by Orcun Ozyurt on 11/21/19.
//  Copyright © 2019 Orcun Ozyurt. All rights reserved.
//

import KingfisherSwiftUI
import SwiftUI

struct NewsItemView: View {
    private let viewModel: NewsItemViewModel
    
    init(viewModel: NewsItemViewModel) {
      self.viewModel = viewModel
    }
    
    var body: some View {
      VStack {
        KFImage(URL(string: viewModel.thumbnail))
        
        VStack {
            Text("\(viewModel.title)")
            Text("\(viewModel.author)")
        }
        
        VStack(alignment: .leading) {
          Text("\(viewModel.date)")
            .font(.body)
          Text("\(viewModel.sourceURL)")
            .font(.footnote)
        }
          .padding(.leading, 8)

        Spacer()

        Text("\(viewModel.slug)°")
          .font(.title)
      }
    }
}


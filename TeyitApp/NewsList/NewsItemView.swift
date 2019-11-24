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
        NavigationLink(destination: viewModel.detailsView) {
            VStack {
                       KFImage(URL(string: viewModel.thumbnail))
                       .resizable()
                       .aspectRatio(contentMode: .fit)
                       .shadow(radius: 5)
            
                       HStack {
                           VStack(alignment: .leading) {
                            Text(viewModel.date)
                                .font(.headline)
                                .foregroundColor(.secondary)
                                .padding(.bottom, 5)
                            
                            Text(viewModel.title)
                               .font(.body)
                               .fontWeight(.black)
                               .foregroundColor(.primary)
                               .lineLimit(5)
                                .padding(.bottom, 15)
                            
                            Text(viewModel.author.uppercased())
                               .font(.caption)
                               .foregroundColor(.secondary)
                           }
                           .layoutPriority(100)
            
                           Spacer()
                       }
                       .padding()
                   }
                   .cornerRadius(10)
                   .overlay(
                       RoundedRectangle(cornerRadius: 10)
                           .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                   )
                   .padding([.top, .horizontal])
        }
           
       }
}


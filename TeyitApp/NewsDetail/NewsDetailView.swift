//
//  NewsDetailView.swift
//  TeyitApp
//
//  Created by Orcun Ozyurt on 11/21/19.
//  Copyright © 2019 Orcun Ozyurt. All rights reserved.
//

import SwiftUI
import Combine
import KingfisherSwiftUI

struct NewsDetailView: View {
    @ObservedObject var viewModel: NewsDetailViewModel
    
    init(viewModel: NewsDetailViewModel) {
      self.viewModel = viewModel
    }
    
    var body: some View {
//        Text(viewModel.claim)
//            .onAppear(perform: viewModel.fetchDetails)
        ScrollView(content: content)
            .onAppear(perform: viewModel.fetchDetails)
            .padding()
        
    }
}

private extension NewsDetailView {
  func content() -> some View {
    if let _ = self.viewModel.dataSource {
        return AnyView(details(for: viewModel))
    } else {
        return AnyView(loading)
    }
  }

  func details(for viewModel: NewsDetailViewModel) -> some View {
    var details: some View {
        
        VStack {
            if viewModel.images.first != nil {
                KFImage(URL(string: viewModel.images.first!))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .shadow(radius: 5)
            }
            
            if !viewModel.claim.isEmpty {
                
                VStack {
                    Text(viewModel.claim)
                        .foregroundColor(.gray)
                        .padding()
                    if viewModel.proven {
                        HStack {
                            Image(systemName: "hand.thumbsup.fill")
                            Text("DOĞRU")
                            .fontWeight(.black)
                            .padding()
                            .font(.title)
                        }
                        .padding()
                    } else {
                        HStack {
                            Image(systemName: "hand.thumbsdown.fill")
                            Text("YANLIŞ")
                            .fontWeight(.black)
                            .padding()
                            .font(.title)
                        }
                        .padding()                    }
                }
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                )
                .padding([.top, .horizontal])
                
            }
            
            Text(viewModel.author.uppercased())
                .font(.caption)
                .foregroundColor(.secondary)
                .padding()
            
            Text(viewModel.content)
                .foregroundColor(.gray)
                .padding()
            
        }
    }
    return details
  }

  var loading: some View {
    Text("Yukleniyor..")
      .foregroundColor(.gray)
  }
}

//
//  NewsItemViewModel.swift
//  TeyitApp
//
//  Created by Orcun Ozyurt on 11/21/19.
//  Copyright © 2019 Orcun Ozyurt. All rights reserved.
//

import Foundation
import SwiftUI

class NewsItemViewModel: Identifiable {
    private let item: News

    init(item: News) {
      self.item = item
    }
    
    var title: String {
        guard let title = item.title else { return "" }
        return title
    }
    
    var author: String {
        guard let author = item.author else { return "" }
        return author
    }
    
    var slug: String {
        return item.url_slug!
    }
    
    var thumbnail: String {
        guard let thumbnail = item.thumbnail else { return "" }
        return thumbnail
    }
    
    var date: String {
        guard let date = item.date else { return "" }
        return date
    }
    
    var sourceURL: URL {
        return item.link!
    }
}

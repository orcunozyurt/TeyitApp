//
//  NewsDetail.swift
//  Teyit
//
//  Created by Orcun Ozyurt on 11/11/19.
//  Copyright © 2019 Orcun Ozyurt. All rights reserved.
//

import Foundation

struct NewsDetail: Decodable {
    var title: String?
    var author: String?
    var claim: String?
    var proven: Bool?
    var images: [String]?
    var date: String?
    var content: String?
}

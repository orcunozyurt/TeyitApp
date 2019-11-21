//
//  News.swift
//  Teyit
//
//  Created by Orcun Ozyurt on 11/11/19.
//  Copyright © 2019 Orcun Ozyurt. All rights reserved.
//

import Foundation

struct News: Codable {
    var title: String?
    var author: String?
    var url_slug: String?
    var link: URL?
    var thumbnail: String?
    var date: String?
}

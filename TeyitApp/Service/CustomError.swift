//
//  CustomError.swift
//  TeyitApp
//
//  Created by Orcun Ozyurt on 11/21/19.
//  Copyright © 2019 Orcun Ozyurt. All rights reserved.
//

import Foundation

enum CustomError: Error {
  case parsing(description: String)
  case network(description: String)
}

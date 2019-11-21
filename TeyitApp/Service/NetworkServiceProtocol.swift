//
//  NetworkServiceProtocol.swift
//  Teyit
//
//  Created by Orcun Ozyurt on 11/11/19.
//  Copyright © 2019 Orcun Ozyurt. All rights reserved.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    func fetchNews() -> AnyPublisher<[News], CustomError>
    
    func fetchDetails(
      from url: String
    ) -> AnyPublisher<NewsDetail, CustomError>
   
}

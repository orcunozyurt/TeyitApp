//
//  NetworkService.swift
//  Teyit
//
//  Created by Orcun Ozyurt on 11/11/19.
//  Copyright © 2019 Orcun Ozyurt. All rights reserved.
//

import Foundation
import Combine

class NetworkService: NetworkServiceProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
      self.session = session
    }
    
    struct TeyitAPI {
      static let scheme = "https"
      static let host = "teyit-scrapper-api.herokuapp.com"
      static let all_path = "/all"
      static let fact_path = "/fact/"
    }
    
    func fetchNews() -> AnyPublisher<[News], CustomError> {
        return request(with: allPathUrlComponents())
    }
    
    func fetchDetails(from url: String) -> AnyPublisher<NewsDetail, CustomError> {
        return request(with: factPathUrlComponents(withUrl: url))
    }
    
    private func request<T>(
      with components: URLComponents
    ) -> AnyPublisher<T, CustomError> where T: Decodable {
      guard let url = components.url else {
        let error = CustomError.network(description: "Couldn't create URL")
        return Fail(error: error).eraseToAnyPublisher()
      }
      return session.dataTaskPublisher(for: URLRequest(url: url))
        .mapError { error in
          .network(description: error.localizedDescription)
        }
        .flatMap(maxPublishers: .max(1)) { pair in
          decode(pair.data)
        }
        .eraseToAnyPublisher()
    }
    
    func allPathUrlComponents() -> URLComponents {
      var components = URLComponents()
      components.scheme = TeyitAPI.scheme
      components.host = TeyitAPI.host
      components.path = TeyitAPI.all_path
      
      return components
    }
    
    func factPathUrlComponents(withUrl url: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = TeyitAPI.scheme
        components.host = TeyitAPI.host
        components.path = TeyitAPI.fact_path + url
            
        return components
    }
//    func fetchNews(completion: @escaping ([News]?, Error?) -> ()) {
//        let task = URLSession.shared.dataTask(with: URL(string: base_url + all_endpoint)!) {(data, response, error) in
//            guard let data = data else { return }
//            print(String(data: data, encoding: .utf8)!)
//            do {
//                //here dataResponse received from a network request
//                let decoder = JSONDecoder()
//                let model = try decoder.decode([News].self, from: data) //Decode JSON
//                completion(model, nil)
//            } catch let parsingError {
//                completion(nil, parsingError)
//            }
//        }
//
//        task.resume()
//    }
//
//    func fetchDetails(from: String?, completion: @escaping (NewsDetail?, Error?) -> ()) {
//        let task = URLSession.shared.dataTask(with: URL(string: base_url + all_endpoint + from!)!) {(data, response, error) in
//            guard let data = data else { return }
//            print(String(data: data, encoding: .utf8)!)
//            do {
//                //here dataResponse received from a network request
//                let decoder = JSONDecoder()
//                let model = try decoder.decode(NewsDetail.self, from: data) //Decode JSON
//                completion(model, nil)
//            } catch let parsingError {
//                completion(nil, parsingError)
//            }
//        }
//
//        task.resume()
//    }
    
}

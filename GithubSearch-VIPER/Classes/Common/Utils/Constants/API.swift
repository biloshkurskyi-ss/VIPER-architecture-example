//
//  API.swift
//  GithubSearch-VIPER
//
//  Created by Sergey Biloshkurskyi on 2/11/18.
//  Copyright © 2018 Sergey Biloshkurskyi. All rights reserved.
//

import Foundation

struct API {
    static let baseAPI = "https://api.github.com/"
}

protocol RequestType {
    var path: String { get }
    var url: String { get }
}

enum Requests {
    enum Repository: RequestType {
        struct ParametersData {
            
            // MARK: -
            var query: String
            var pageNumber: Int
            var perPage: Int
            var sortDescryptor = "stars"
            

            // MARK: - Instance Methods
            func queryString() -> String {
                return dictionary()
                    .flatMap({ (key, value) -> String in return "\(key)=\(value)" })
                    .joined(separator: "&")
                    .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            }
            
            // MARK: - Constructors
            init(query: String, pageNumber: Int = 1, perPage: Int = 15) {
                self.query = query
                self.pageNumber = pageNumber
                self.perPage = perPage
            }
            
            // MARK: - Private Methods
            fileprivate func dictionary() -> Dictionary<String, String> {
                return ["q" : query, "page" : "\(pageNumber)" , "per_page" : "\(perPage)", "sort" : sortDescryptor]
            }
        }
        
        case fetch
        
        var path: String {
            switch self {
            case .fetch:
                return "search/repositories"
            }
        }
        
        var url: String {
            switch self {
            case .fetch:
                return API.baseAPI + path
            }
        }
        
    }
}

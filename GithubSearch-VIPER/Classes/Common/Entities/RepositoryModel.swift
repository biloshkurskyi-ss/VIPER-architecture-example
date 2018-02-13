//
//  RepositoryModel.swift
//  GithubSearch-VIPER
//
//  Created by Sergey Biloshkurskyi on 2/11/18.
//  Copyright © 2018 Sergey Biloshkurskyi. All rights reserved.
//

import Foundation
import ObjectMapper

struct RepositoryModel  {
    var id: Int
    var name: String
    var url: String
    var stars: Int
}

extension RepositoryModel: Mappable {
    init?(map: Map) {
        id = 0
        name = ""
        url = ""
        stars = 0
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        url <- map["html_url"]
        stars <- map["watchers_count"]
    }
}

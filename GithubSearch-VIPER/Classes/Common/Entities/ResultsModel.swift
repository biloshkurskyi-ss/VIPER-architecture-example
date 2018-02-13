//
//  ResultsModel.swift
//  GithubSearch-VIPER
//
//  Created by Sergey Biloshkurskyi on 2/11/18.
//  Copyright © 2018 Sergey Biloshkurskyi. All rights reserved.
//

import Foundation
import ObjectMapper

struct ResultModel {
    var items: [RepositoryModel]?
}

extension ResultModel: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        items <- map["items"]
    }
}

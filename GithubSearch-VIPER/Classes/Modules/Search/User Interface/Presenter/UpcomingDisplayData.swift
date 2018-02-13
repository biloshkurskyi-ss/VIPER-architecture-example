//
//  UpcomingDisplayData.swift
//  GithubSearch-VIPER
//
//  Created by Sergey Biloshkurskyi on 2/11/18.
//  Copyright © 2018 Sergey Biloshkurskyi. All rights reserved.
//

import Foundation

struct UpcomingDisplayData {
    let rows : [UpcomingDisplayItem]
}

struct UpcomingDisplayItem {
    let title : String
    let url : String
}

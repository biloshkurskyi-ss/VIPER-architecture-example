//
//  String+.swift
//  GithubSearch-VIPER
//
//  Created by Sergey Biloshkurskyi on 2/12/18.
//  Copyright © 2018 Sergey Biloshkurskyi. All rights reserved.
//

import Foundation

extension String {
    func trunc(length: Int, trailing: String = "") -> String {
        return (self.count > length) ? self.prefix(length) + trailing : self
    }
}

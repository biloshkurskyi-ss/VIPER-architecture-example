//
//  NoContentView.swift
//  GithubSearch-VIPER
//
//  Created by Sergey Biloshkurskyi on 2/11/18.
//  Copyright © 2018 Sergey Biloshkurskyi. All rights reserved.
//

import UIKit

class NoContentView: UIView {
    
    // MARK: - Outlets
    @IBOutlet weak var label: UILabel!
    
    // MARK: - Instance Methods
    func setText(_ text: String) {
        label.text = text
    }
}

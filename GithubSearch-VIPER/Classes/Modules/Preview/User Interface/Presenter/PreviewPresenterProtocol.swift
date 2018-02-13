//
//  PreviewPresenterProtocol.swift
//  GithubSearch-VIPER
//
//  Created by Sergey Biloshkurskyi on 2/12/18.
//  Copyright © 2018 Sergey Biloshkurskyi. All rights reserved.
//

import Foundation

protocol PreviewPresenterProtocol {
    var previewWareframe: PreviewWareframe? { get set }
    var userInterface: PreviewViewInterface? { get set }
    
    func configureUserInterfaceForPresentation(_ url: String)
    func cancelPreviewAction()
}

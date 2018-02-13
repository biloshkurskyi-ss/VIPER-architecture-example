//
//  PreviewPresenter.swift
//  GithubSearch-VIPER
//
//  Created by Sergey Biloshkurskyi on 2/12/18.
//  Copyright © 2018 Sergey Biloshkurskyi. All rights reserved.
//

import Foundation

class PreviewPresenter: PreviewPresenterProtocol {
    
    // MARK: - Instance Variable
    var previewWareframe: PreviewWareframe?
    weak var userInterface: PreviewViewInterface?
    
    // MARK: - Instance Methods
    func configureUserInterfaceForPresentation(_ url: String) {
        userInterface?.openRepositoryPage(url)
    }
    
    func cancelPreviewAction() {
        previewWareframe?.dismissPreviewInterface()
    }
}

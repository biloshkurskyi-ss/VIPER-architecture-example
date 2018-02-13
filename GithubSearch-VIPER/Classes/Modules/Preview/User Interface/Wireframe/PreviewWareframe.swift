//
//  PreviewWareframe.swift
//  GithubSearch-VIPER
//
//  Created by Sergey Biloshkurskyi on 2/11/18.
//  Copyright © 2018 Sergey Biloshkurskyi. All rights reserved.
//

import Foundation
import UIKit

let previewControllerIdentifier = "previewControllerIdentifier"

class PreviewWareframe: NSObject {
    
    // MARK: - Instance Variables
    var previewPresenter: PreviewPresenterProtocol?
    var previewViewController: UIViewController?
    
    // MARK: - Instance Methods
    func presentPreviewInterfaceFromViewController(_ vc: UIViewController, with url: String) {
        let presenter = PreviewPresenter()
        
        previewPresenter = presenter
    
        let previewvc = previewViewControllerFromStoryboard()
        previewvc.presenter = previewPresenter
        previewvc.modalPresentationStyle = .custom
        previewvc.transitioningDelegate = self
        
        previewPresenter?.userInterface = previewvc
        previewPresenter?.configureUserInterfaceForPresentation(url)
        previewPresenter?.previewWareframe = self
        
        vc.present(previewvc, animated: true, completion: nil)
        previewViewController = previewvc
    }
    
    func dismissPreviewInterface() {
        previewViewController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Private
    fileprivate func previewViewControllerFromStoryboard() -> PreviewViewController {
        let storyboard = mainStoryboard()
        return storyboard.instantiateViewController(withIdentifier: previewControllerIdentifier) as! PreviewViewController
    }
    
    fileprivate func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}

// MARK: - UIViewControllerTransitioningDelegate
extension PreviewWareframe: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PreviewPresentationTransition()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PreviewDismissalTransition()
    }
}

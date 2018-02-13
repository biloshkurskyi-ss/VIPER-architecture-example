//
//  PreviewDismissalTransition.swift
//  GithubSearch-VIPER
//
//  Created by Sergey Biloshkurskyi on 2/12/18.
//  Copyright © 2018 Sergey Biloshkurskyi. All rights reserved.
//

import Foundation
import UIKit

class PreviewDismissalTransition: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! PreviewViewController
        
        let finalCenter = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: fromVC.view.bounds.size.height)
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext),
                       animations: {
                        fromVC.view.center = finalCenter
                        fromVC.transitioningBackgroundView.alpha = 0.0
        }, completion: { finished in
                        fromVC.view.removeFromSuperview()
                        transitionContext.completeTransition(true)
        })
    }
}

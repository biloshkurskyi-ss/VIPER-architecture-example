//
//  PreviewPresentationTransition.swift
//  GithubSearch-VIPER
//
//  Created by Sergey Biloshkurskyi on 2/12/18.
//  Copyright © 2018 Sergey Biloshkurskyi. All rights reserved.
//

import Foundation
import UIKit

class PreviewPresentationTransition: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! PreviewViewController
        
        toVC.transitioningBackgroundView.backgroundColor = .darkGray
        toVC.transitioningBackgroundView.alpha = 0.0
        toVC.transitioningBackgroundView.frame = UIScreen.main.bounds
        
        let containerView = transitionContext.containerView
        
        containerView.addSubview(toVC.transitioningBackgroundView)
        containerView.addSubview(toVC.view)
        
        let toViewFrame = CGRect(x: 25, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width - 50, height: UIScreen.main.bounds.size.height - 200)
        toVC.view.frame = toViewFrame
        
        let finalCenter = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2)
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext),
                       animations: {
                        toVC.view.center = finalCenter
                        toVC.transitioningBackgroundView.alpha = 0.7
        }, completion: { finished in
            transitionContext.completeTransition(true)
        })
    }
}

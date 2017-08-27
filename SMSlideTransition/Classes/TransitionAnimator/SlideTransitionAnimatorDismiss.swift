//
//  BottomTransitionAnimatorDismiss.swift
//  BottomSheetVC
//
//  Created by S.M.Moinuddin on 8/25/17.
//  Copyright © 2017 S.M.Moinuddin. All rights reserved.
//

import UIKit

public class SlideTransitionAnimatorDismiss: BaseAnimator, UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let containerView = transitionContext.containerView
        
        let animationDuration = transitionDuration(using: transitionContext)
        let transform: CGAffineTransform
        
        switch slideStyle {
        case .top:
            transform = CGAffineTransform(translationX: 0, y: -containerView.bounds.height)
            
        case .bottom:
            transform = CGAffineTransform(translationX: 0, y: containerView.bounds.height)
            
        case .left:
            transform = CGAffineTransform(translationX: -containerView.bounds.width, y: 0)
            
        case .right:
            transform = CGAffineTransform(translationX: containerView.bounds.width, y: 0)
        }
        
        UIView.animate(withDuration: animationDuration, animations: {
            fromViewController.view.transform = transform
        }) { finished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
}

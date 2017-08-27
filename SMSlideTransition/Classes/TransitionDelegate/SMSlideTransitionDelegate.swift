//
//  BottomTransitionDelegate.swift
//  BottomSheetVC
//
//  Created by S.M.Moinuddin on 8/25/17.
//  Copyright © 2017 S.M.Moinuddin. All rights reserved.
//

import UIKit

public class SMSlideTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    
    /// duration of the transition. Default is 0.35
    public var duration: TimeInterval = 0.35
    
    /// Slide transition's sliding direction. Default is .bottom
    public var slideStyle: SlideStyle = .bottom
    
    /// alpha of dim view. Default is 0.5
    public var dimScale: CGFloat = 0.5
    
    /// height of the viewController that will be presented. 
    /// Default is 350
    public var heightOfPresentedViewController: CGFloat = 350
    
    public var allowInteractionOnDismissal = true
    
    /// set UIRectCorner and radius of the presented view.
    ///
    /// - Parameters:
    ///   - corners: array of UIRectCorner
    ///   - radius: CGFloat value, sets the corner radius
    public func roundCorners(corners: UIRectCorner?, radius: CGFloat?) {
        self.cornerRadius = radius
        self.corners = corners
    }
    
    //MARK:- Private variables
    private var corners: UIRectCorner?
    private var cornerRadius: CGFloat?
    private var presentationController: SMSlidePresentationController! = nil
    
    
    //MARK:- Custom Presentation Handler
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        presentationController = SMSlidePresentationController(presentedViewController: presented, presenting: presenting)
        presentationController.slideStyle = slideStyle
        presentationController.dimScale = dimScale
        presentationController.sheetHeight = heightOfPresentedViewController
        presentationController.roundCorners(corners: corners, radius: cornerRadius)
        presentationController.allowDismissalInteraction = allowInteractionOnDismissal
        presentationController.removeFromStack = { [weak self] in
            self?.presentationController = nil // to remove strong reference
        }
        return presentationController
    }
    
    //MARK:- Dismiss Interaction Handler
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        let flag = presentationController.interactiveDismissal
        let interactor = flag ? presentationController.dismissInteractionController : nil
        
        if presentationController.didCompleteTransition {
            presentationController = nil // to remove strong reference
        }
        
        return allowInteractionOnDismissal ? interactor : nil
    }
    
    //MARK:- Present and Dismiss Animation Handler
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = SlideTransitionAnimator()
        animator.duration = duration
        animator.slideStyle = slideStyle
        return animator
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let dismissAnimator = SlideTransitionAnimatorDismiss()
        dismissAnimator.duration = duration
        dismissAnimator.slideStyle = slideStyle
        return dismissAnimator
    }
    
}

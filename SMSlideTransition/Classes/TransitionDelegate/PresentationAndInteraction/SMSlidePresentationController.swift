//
//  SheetPresentationController.swift
//  BottomSheetVC
//
//  Created by S.M.Moinuddin on 8/25/17.
//  Copyright © 2017 S.M.Moinuddin. All rights reserved.
//

import UIKit

extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

class SMSlidePresentationController: UIPresentationController {
    
    private var dimmingView: UIView?
    private var presentationWrappingView: UIView?
    private var cornerRadius: CGFloat?
    private var corners: UIRectCorner?
    
    //MARK:- Public Variable
    var slideStyle = SlideStyle.bottom
    var dimScale: CGFloat       = 0
    var sheetHeight: CGFloat    = 0
    
    var allowDismissalInteraction = true
    var interactiveDismissal    = false
    var didCompleteTransition   = true
    var dismissInteractionController: SMSlideDismissInteractionController? = nil
    var removeFromStack: (() -> Void)?
    
    func roundCorners(corners: UIRectCorner?, radius: CGFloat?) {
        self.cornerRadius = radius
        self.corners = corners
    }
    
    //MARK:- Layout
    
    override var frameOfPresentedViewInContainerView: CGRect {
        
        if slideStyle == SlideStyle.top {
            return CGRect(x: 0, y: 0, width: containerView!.bounds.width, height: sheetHeight)
        } else {
            return CGRect(x: 0, y: containerView!.bounds.height - sheetHeight, width: containerView!.bounds.width, height: sheetHeight)
        }
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        self.dimmingView?.frame = self.containerView?.bounds ?? CGRect()
        presentedView?.frame = frameOfPresentedViewInContainerView
        setupCornerRadius()
    }
    
    private func setupCornerRadius() {
        if let corners = self.corners, let radius = self.cornerRadius {
            presentedView?.roundCorners(corners: corners, radius: radius)
        }
    }
    
    
    //MARK:- Presentation
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        setupCornerRadius()
        
        let dimmingView = UIView(frame: self.containerView?.bounds ?? CGRect())
        dimmingView.backgroundColor = UIColor.black
        dimmingView.isOpaque = false
        dimmingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        dimmingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SMSlidePresentationController.dimmingViewTapped(_:))))
        self.dimmingView = dimmingView
        self.containerView?.addSubview(dimmingView)
        
        
        // Get the transition coordinator for the presentation so we can
        // fade in the dimmingView alongside the presentation animation.
        let transitionCoordinator = self.presentingViewController.transitionCoordinator
        
        self.dimmingView?.alpha = 0.0
        transitionCoordinator?.animate(alongsideTransition: { [unowned self] context in
            self.dimmingView?.alpha = self.dimScale
            }, completion: nil)
        
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        // The value of the 'completed' argument is the same value passed to the
        // -completeTransition: method by the animator.  It may
        // be NO in the case of a cancelled interactive transition.
        if !completed {
            // The system removes the presented view controller's view from its
            // superview and disposes of the containerView.  This implicitly
            // removes the views created in -presentationTransitionWillBegin: from
            // the view hierarchy.  However, we still need to relinquish our strong
            // references to those view.
            self.dimmingView = nil
        }
        
        if allowDismissalInteraction {
            dismissInteractionController = SMSlideDismissInteractionController()
            dismissInteractionController?.slideStyle = slideStyle
            dismissInteractionController?.wireToView(containerView!)
            dismissInteractionController?.didBeginPanning = { [weak self] in
                self?.interactiveDismissal = true
                self?.didCompleteTransition = false
                self?.presentingViewController.dismiss(animated: true, completion: nil)
            }
            
            dismissInteractionController?.didCancelTransition = {
                [weak self] in
                self?.didCompleteTransition = true
            }
            dismissInteractionController?.didCompleteTransiton = {
                [weak self] in
                self?.didCompleteTransition = true
                self?.removeFromStack?()
            }
        }
        
    }
    
    //MARK:- Tap Gesture Recognizer
    
    //  function for the tap gesture recognizer added to the dimmingView.
    //  Dismisses the presented view controller.
    //
    func dimmingViewTapped(_ sender: UITapGestureRecognizer) {
        self.presentingViewController.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- Dismissal
    
    override func dismissalTransitionWillBegin() {
        // Get the transition coordinator for the dismissal so we can
        // fade out the dimmingView alongside the dismissal animation.
        let transitionCoordinator = self.presentingViewController.transitionCoordinator
        
        transitionCoordinator?.animate(alongsideTransition: {context in
            self.dimmingView?.alpha = 0.0
        }, completion: nil)
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        // The value of the 'completed' argument is the same value passed to the
        // -completeTransition: method by the animator.  It may
        // be NO in the case of a cancelled interactive transition.
        
        interactiveDismissal = false
        
        if completed {
            // The system removes the presented view controller's view from its
            // superview and disposes of the containerView.  This implicitly
            // removes the views created in -presentationTransitionWillBegin: from
            // the view hierarchy.  However, we still need to relinquish our strong
            // references to those view.
            self.dimmingView = nil
        }
    }
    
}

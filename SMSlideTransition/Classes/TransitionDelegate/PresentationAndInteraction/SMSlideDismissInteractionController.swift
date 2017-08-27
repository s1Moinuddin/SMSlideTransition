//
//  SMSlideInteractionController.swift
//  BottomSheetVC
//
//  Created by S.M.Moinuddin on 8/26/17.
//  Copyright © 2017 S.M.Moinuddin. All rights reserved.
//

import UIKit


/// This class is responsible to handle the interation of top, bottom, left
/// and right dismissal animation of SMSlideTransition.
class SMSlideDismissInteractionController: UIPercentDrivenInteractiveTransition {
    
    var slideStyle: SlideStyle = .bottom
    var didBeginPanning: (() -> Void)?
    var didCompleteTransiton: (() -> Void)?
    var didCancelTransition: (() -> Void)?
    
    private var shouldCompleteTransition = false
    private let verticalProgressThreshold: CGFloat = 0.3
    private let horizontalProgressThreshold: CGFloat = 0.6
    
    /* Stores the percentage of progress while panning.
     * when panning is hold for a bit longer, pan gets cancelled,
     * doesn't confirm to any direction and local progress turns to 0.
     * Thus it causes flickering in animation. To prevent this flickering
     * we assign this stored value to local progress, so that it can behave
     * normally. In the ended state of pan gesture if pan gets cancelled
     * we turn it to 0, to prevent animation
     * while panning (in wrong direction).
     */
    private var lastMovementPercent: Float = 0
    
    func wireToView(_ containerView: UIView!) {
        prepareGestureRecognizerInView(containerView)
    }
    
    private func prepareGestureRecognizerInView(_ view: UIView) {
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        gesture.delegate = self
        view.addGestureRecognizer(gesture)
    }
    
    func handleGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        let percentThreshold: CGFloat
        switch slideStyle {
        case .top, .bottom:
            percentThreshold = verticalProgressThreshold
        case .left, .right:
            percentThreshold = horizontalProgressThreshold
        }
        
        guard let progress = calculatePreogressFrom(gestureRecognizer) else {return}
        
        
        switch gestureRecognizer.state {
            
        case .began:
            didBeginPanning?()
            
        case .changed:
            shouldCompleteTransition = progress > percentThreshold
            update(progress)
            
        case .cancelled:
            cancel()
            
        case .ended:
            if !shouldCompleteTransition {
                didCancelTransition?()
                cancel()
                lastMovementPercent = 0
            } else {
                didCompleteTransiton?()
                finish()
            }
            
        default:
            print("Unsupported Pan state")
        }
    }
    
    private func calculatePreogressFrom(_ gestureRecognizer: UIPanGestureRecognizer) -> CGFloat? {
        
        guard let view = gestureRecognizer.view?.superview! else {return nil}
        let direction = gestureRecognizer.direction(in: view)
        let translation = gestureRecognizer.translation(in: view)
        let horizontalMovement: CGFloat
        let verticalMovement: CGFloat
        let movementPercent: Float
        
        if direction.contains(.Left) && slideStyle == .left {
            horizontalMovement = translation.x / view.bounds.width
            let leftMovement = fminf(Float(horizontalMovement), 0.0)
            movementPercent = fminf(abs(leftMovement), 1.0)
            lastMovementPercent = movementPercent
            
        } else if direction.contains(.Right) && slideStyle == .right {
            horizontalMovement = translation.x / view.bounds.width
            let rightMovement = fmaxf(Float(horizontalMovement), 0.0)
            movementPercent = fminf(rightMovement, 1.0)
            lastMovementPercent = movementPercent
            
        } else if direction.contains(.Up) && slideStyle == .top {
            verticalMovement = translation.y / view.bounds.height
            let upwardMovement = fminf(Float(verticalMovement), 0.0)
            movementPercent = fminf(abs(upwardMovement), 1.0)
            lastMovementPercent = movementPercent
            
        } else if direction.contains(.Down) && slideStyle == .bottom {
            verticalMovement = translation.y / view.bounds.height
            let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
            movementPercent = fminf(downwardMovement, 1.0)
            lastMovementPercent = movementPercent
            
        } else {
            movementPercent = lastMovementPercent
        }
        //print("MMovementPercent = \(movementPercent)")
        return CGFloat(movementPercent)
    }
    
}

extension SMSlideDismissInteractionController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

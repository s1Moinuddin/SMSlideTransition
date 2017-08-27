//
//  HomeVC.swift
//  BottomSheetVC
//
//  Created by S.M.Moinuddin on 8/23/17.
//  Copyright © 2017 S.M.Moinuddin. All rights reserved.
//

import UIKit
import SMSlideTransition

class HomeVC: UIViewController {
    
    @IBOutlet private weak var topBttn: UIButton!
    @IBOutlet private weak var bottomBttn: UIButton!
    @IBOutlet private weak var leftBttn: UIButton!
    @IBOutlet private weak var rightBttn: UIButton!
    
    let topSlideDelegate    = SMSlideTransitionDelegate()
    let bottomSlideDelegate = SMSlideTransitionDelegate()
    let leftSlideDelegate   = SMSlideTransitionDelegate()
    let rightSlideDelegate  = SMSlideTransitionDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupButton()
    }
    
    deinit {
        let className = ((#file as NSString).lastPathComponent as NSString).deletingPathExtension
        print("\(className).\(#function) called")
    }
    
    private func setupButton() {
        let borderWidth: CGFloat = 2
        let borderColor = UIColor.black.cgColor
        
        topBttn.layer.borderWidth = borderWidth
        topBttn.layer.borderColor = borderColor
        
        bottomBttn.layer.borderWidth = borderWidth
        bottomBttn.layer.borderColor = borderColor
        
        leftBttn.layer.borderWidth = borderWidth
        leftBttn.layer.borderColor = borderColor
        
        rightBttn.layer.borderWidth = borderWidth
        rightBttn.layer.borderColor = borderColor
    }
    
    @IBAction func topSlideAction(_ sender: UIButton) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        
        topSlideDelegate.slideStyle = .top
        topSlideDelegate.allowInteractionOnDismissal = false
        topSlideDelegate.heightOfPresentedViewController = 450
        vc.transitioningDelegate = topSlideDelegate
        vc.modalPresentationStyle = .custom
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func bottomSlideAction(_ sender: UIButton) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        
        bottomSlideDelegate.slideStyle = .bottom
        bottomSlideDelegate.heightOfPresentedViewController = 400
        vc.transitioningDelegate = bottomSlideDelegate
        vc.modalPresentationStyle = .custom
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func leftSlideAction(_ sender: UIButton) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        
        leftSlideDelegate.slideStyle = .left
        leftSlideDelegate.heightOfPresentedViewController = 400
        leftSlideDelegate.roundCorners(corners: [.topLeft, .topRight], radius: 20)
        vc.transitioningDelegate = leftSlideDelegate
        vc.modalPresentationStyle = .custom
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func rightSlideAction(_ sender: UIButton) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SecondaryVC") as! SecondaryVC
        
        rightSlideDelegate.slideStyle = .right
        rightSlideDelegate.dimScale = 0.7
        rightSlideDelegate.heightOfPresentedViewController = 400
        vc.transitioningDelegate = rightSlideDelegate
        vc.modalPresentationStyle = .custom
        present(vc, animated: true, completion: nil)
    }


}

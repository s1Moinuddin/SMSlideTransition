//
//  SecondaryVC.swift
//  BottomSheetVC
//
//  Created by S.M.Moinuddin on 8/25/17.
//  Copyright © 2017 S.M.Moinuddin. All rights reserved.
//

import UIKit

class SecondaryVC: UIViewController {
    
    @IBOutlet private var contentView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .clear

        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
    }
    
    deinit {
        let className = ((#file as NSString).lastPathComponent as NSString).deletingPathExtension
        print("\(className).\(#function) called")
    }

}

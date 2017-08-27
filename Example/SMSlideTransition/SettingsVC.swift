//
//  SettingsVC.swift
//  BottomSheetVC
//
//  Created by S.M.Moinuddin on 8/23/17.
//  Copyright © 2017 S.M.Moinuddin. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    deinit {
        let className = ((#file as NSString).lastPathComponent as NSString).deletingPathExtension
        print("\(className).\(#function) called")
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }


}

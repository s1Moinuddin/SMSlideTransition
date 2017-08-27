//
//  PrimaryViewController.swift
//  BottomSheetVC
//
//  Created by S.M.Moinuddin on 8/25/17.
//  Copyright © 2017 S.M.Moinuddin. All rights reserved.
//

import UIKit

class PrimaryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    deinit {
        let className = ((#file as NSString).lastPathComponent as NSString).deletingPathExtension
        print("\(className).\(#function) called")
    }

    @IBAction func homeBttnAction(_ sender: UIButton) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}

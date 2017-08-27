//
//  BaseAnimator.swift
//  BottomSheetVC
//
//  Created by S.M.Moinuddin on 8/25/17.
//  Copyright © 2017 S.M.Moinuddin. All rights reserved.
//

import UIKit

public enum SlideStyle {
    case top, bottom, left, right
}

public class BaseAnimator: NSObject {
    
    var duration: TimeInterval = 0
    var slideStyle: SlideStyle = .bottom
    
}

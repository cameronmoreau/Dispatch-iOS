//
//  UIButtonExtension.swift
//  Dispatch
//
//  Created by Cameron Moreau on 4/17/16.
//  Copyright © 2016 Mobi. All rights reserved.
//

import UIKit

extension UIButton {
    
    func setBackgroundGradient(gradient: CAGradientLayer) {
        gradient.frame = self.bounds
        self.layer.addSublayer(gradient)
    }
    
}
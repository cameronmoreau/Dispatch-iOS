//
//  ToggleButton.swift
//  Dispatch
//
//  Created by Cameron Moreau on 4/17/16.
//  Copyright © 2016 Mobi. All rights reserved.
//

import UIKit

class ToggleButton: UIButton {
    
    var active = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        doStuff()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        doStuff()
    }
    
    func toggleActive() {
        self.active = !active
        
        if active {
            self.borderColor = UIColor.mainColor()
        } else {
            self.borderColor = UIColor.whiteColor()
        }
    }
    
    func doStuff() {
        self.borderWidth = 3
        self.borderColor = UIColor.whiteColor()
        self.setTitleColor(UIColor.blackColor(), forState: .Normal)
        
        let spacing: CGFloat = 6.0
        let imageSize: CGSize = self.imageView!.image!.size
        self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, -(imageSize.height + spacing), 0.0);
        let labelString = NSString(string: self.titleLabel!.text!)
        let titleSize = labelString.sizeWithAttributes([NSFontAttributeName: self.titleLabel!.font])
        self.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), 0.0, 0.0, -titleSize.width);
    }

}

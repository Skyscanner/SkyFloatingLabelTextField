//
//  IconView.swift
//  Demo
//
//  Created by Daniel Langh on 21/12/15.
//  Copyright © 2015 Skyscanner. All rights reserved.
//

import UIKit

class IconView: UIView, HighlightableView {

    var highlighted:Bool = false {
        didSet {
            self.update()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.update()
    }
    
    func update() {
        self.backgroundColor = self.highlighted ? UIColor.redColor() : UIColor.grayColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

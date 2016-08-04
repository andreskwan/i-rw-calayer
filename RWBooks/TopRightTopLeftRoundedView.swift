//
//  TopRightTopLeftRoundedView.swift
//  RWBooks
//
//  Created by Andres Kwan on 8/4/16.
//  Copyright © 2016 Ray Wenderlich. All rights reserved.
//

import UIKit

@IBDesignable
class TopRightTopLeftRoundedView: UIView {
    @IBInspectable var corner : CGFloat = 10.0 {
        didSet {
//            setNeedsDisplay()
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let cashapeLayer = CAShapeLayer()
        let maskPath = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: [.TopLeft, .TopRight],
                                    cornerRadii: CGSize(width: corner, height: corner))
        cashapeLayer.path = maskPath.CGPath
        layer.mask = cashapeLayer

    }
}

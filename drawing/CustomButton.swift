//
//  CustomButton.swift
//  drawing
//
//  Created by Sacha BECOURT on 3/26/15.
//  Copyright (c) 2015 CSUSM. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {

    override func drawRect(rect: CGRect) {
        
        let newRect = CGRectMake(1, 1, rect.width - 2, rect.height - 2)
        let path = UIBezierPath(roundedRect: newRect, byRoundingCorners: UIRectCorner.AllCorners, cornerRadii: CGSize(width: 50, height: 50))
        let lineWith:Float = 2

        path.closePath()
        
        UIColor.whiteColor().setStroke()
        if (self.tag == 0) {
            getRedWithAlpha().setFill()
            getRedWithAlpha().setStroke()
        }
        else if (self.tag == 1) {
            getGreenWithAlpha().setFill()
            getGreenWithAlpha().setStroke()
        }
        else {
            getPurpleWithAlpha().setFill()
            getPurpleWithAlpha().setStroke()
        }
        path.lineWidth = CGFloat(lineWith)
        path.stroke()
        path.fill()
    }
    
    func getRedWithAlpha() -> UIColor{
        return UIColor(red: 150, green: 0, blue: 0, alpha: 0.5)
    }
    func getGreenWithAlpha() -> UIColor{
        return UIColor(red: 0, green: 150, blue: 0, alpha: 0.5)
    }
    func getPurpleWithAlpha() -> UIColor{
        return UIColor(red: 150, green: 0, blue: 150, alpha: 0.5)
    }
}

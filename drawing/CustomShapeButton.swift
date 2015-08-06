//
//  CustomShapeButton.swift
//  drawing
//
//  Created by Sacha BECOURT on 3/27/15.
//  Copyright (c) 2015 CSUSM. All rights reserved.
//

import UIKit

@IBDesignable
class CustomShapeButton: UIButton {

    var ton:Int = 0
    override func drawRect(rect: CGRect) {
        if (self.tag == 0)
        {
            self.drawCircleButton(rect)
        }
        else if (self.tag == 1)
        {
            self.drawTriangleButton(rect)
        }
        else
        {
            var path:UIBezierPath = self.drawStarBezier(rect.width / 2 - 1, y: 30, radius: 15, sides: 5, pointyness: 2)
            if (ton == 0) {
                UIColor.redColor().setStroke()
            }
            else if (ton == 1) {
                UIColor.greenColor().setStroke()
            }
            else {
                UIColor.purpleColor().setStroke()
            }
            self.getAlphaBlack(0.5).setFill()
            path.lineWidth = 2
            path.stroke()
            path.fill()
        }
        // Drawing code
    }
    func drawCircleButton(rect: CGRect) {
        let newRect = CGRectMake(4, 1, rect.width - 8, rect.height - 8)
        let path = UIBezierPath(roundedRect: newRect, byRoundingCorners: UIRectCorner.AllCorners, cornerRadii: CGSize(width: 50, height: 50))
        var lineWith:Float = 2
        path.closePath()
        if (ton == 0) {
            UIColor.redColor().setStroke()
        }
        else if (ton == 1) {
            UIColor.greenColor().setStroke()
        }
        else {
            UIColor.purpleColor().setStroke()
        }
        self.getAlphaBlack(0.5).setFill()
        path.lineWidth = CGFloat(lineWith)
        path.stroke()
        path.fill()
    }
    
    func drawTriangleButton(rect: CGRect) {
        let newRect = CGRectMake(1, 1, rect.width - 8, rect.height - 8)
        let path = UIBezierPath()
        let firstPoint:CGPoint = CGPointMake(CGFloat(rect.width - 1) / 2, CGFloat(10))
        let secondPoint:CGPoint = CGPointMake(CGFloat(newRect.width - 1), CGFloat(newRect.height - 1))
        let thirdPoint:CGPoint = CGPointMake(8, CGFloat(newRect.height - 1))
        path.moveToPoint(firstPoint)
        path.addLineToPoint(firstPoint)
        path.addLineToPoint(secondPoint)
        path.addLineToPoint(thirdPoint)
        path.closePath()
        if (ton == 0) {
            UIColor.redColor().setStroke()
        }
        else if (ton == 1) {
            UIColor.greenColor().setStroke()
        }
        else {
            UIColor.purpleColor().setStroke()
        }
        self.getAlphaBlack(0.5).setFill()
        path.lineWidth = 2
        path.stroke()
        path.fill()
    }
    
    func getAlphaBlack(alpha: CGFloat) ->UIColor {
        return UIColor(red: 0, green: 0, blue: 0, alpha: alpha)
    }
    
    func degree2radian(a:CGFloat)->CGFloat {
        let b = CGFloat(M_PI) * a/180
        return b
    }
    
    func polygonPointArray(sides:Int,x:CGFloat,y:CGFloat,radius:CGFloat,adjustment:CGFloat=0)->[CGPoint] {
        let angle = degree2radian(360/CGFloat(sides))
        let cx = x // x origin
        let cy = y // y origin
        let r  = radius // radius of circle
        var i = sides
        var points = [CGPoint]()
        while points.count <= sides {
            let xpo = cx - r * cos(angle * CGFloat(i)+degree2radian(adjustment))
            let ypo = cy - r * sin(angle * CGFloat(i)+degree2radian(adjustment))
            points.append(CGPoint(x: xpo, y: ypo))
            i--;
        }
        return points
    }
    
    func starPath(x:CGFloat, y:CGFloat, radius:CGFloat, sides:Int,pointyness:CGFloat) -> CGPathRef {
        let adjustment = 360/sides/2
        let path = CGPathCreateMutable()
        let points = polygonPointArray(sides,x: x,y: y,radius: radius)
        var cpg = points[0]
        let points2 = polygonPointArray(sides,x: x,y: y,radius: radius*pointyness,adjustment:CGFloat(adjustment))
        var i = 0
        CGPathMoveToPoint(path, nil, cpg.x, cpg.y)
        for p in points {
            CGPathAddLineToPoint(path, nil, points2[i].x, points2[i].y)
            CGPathAddLineToPoint(path, nil, p.x, p.y)
            i++
        }
        CGPathCloseSubpath(path)
        return path
    }
    
    func drawStarBezier(x:CGFloat, y:CGFloat, radius:CGFloat, sides:Int, pointyness:CGFloat)->UIBezierPath {
        let path = starPath(x, y: y, radius: radius, sides: sides,pointyness: pointyness)
        let bez = UIBezierPath(CGPath: path)
        return bez
    }
}

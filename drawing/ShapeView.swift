//
//  ShapeView.swift
//  drawing
//
//  Created by Sacha BECOURT on 3/25/15.
//  Copyright (c) 2015 CSUSM. All rights reserved.
//

import UIKit

protocol mvc {
    func hideCameraButton()
    func showCameraButton()
}

extension UIView {
    
    func pb_takeSnapshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.mainScreen().scale)
        drawViewHierarchyInRect(self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        return image
    }
}
extension UIBezierPath {
    convenience init(equilateralSide: CGFloat, center: CGPoint) {
        self.init()
        let altitude = CGFloat(sqrt(3.0) / 2.0 * equilateralSide)
        let heightToCenter = altitude / 3
        moveToPoint(CGPoint(x:center.x, y:center.y - heightToCenter*2))
        addLineToPoint(CGPoint(x:center.x + equilateralSide/2, y:center.y + heightToCenter))
        addLineToPoint(CGPoint(x:center.x - equilateralSide/2, y:center.y + heightToCenter))
        closePath()
    }
}

@IBDesignable
class ShapeView: UIView {
    @IBInspectable var radiusRange: CGFloat = 10
    var ton:Int = 0
    var circleTouched:Bool = false
    var triangleTouched:Bool = false
    var starTouched:Bool = false
    @IBOutlet var slider:UISlider!
    @IBOutlet var redButton:UIButton!
    @IBOutlet var greenButton:UIButton!
    @IBOutlet var purpleButton:UIButton!
    @IBOutlet var circleButton:UIButton!
    @IBOutlet var triangleButton:UIButton!
    @IBOutlet var starButton:UIButton!
    
    var delegate:mvc?
    
    override func drawRect(rect: CGRect) {

        if (circleTouched) {
            var i:Int = 0
            while (i <= 30)
            {
                let radius:CGFloat = CGFloat(arc4random()) % radiusRange
                self.drawRandomArc(radius)
                i = i + 1
            }
            triangleTouched = false
            starTouched = false
        }
        else if (triangleTouched) {
            var i:Int = 0
            while (i <= 40)
            {
                let radius:CGFloat = CGFloat(arc4random()) % radiusRange
                self.drawTriangle(radius)
                i = i + 1
            }
            circleTouched = false
            starTouched = false
        }
        else if (starTouched) {
            var i:Int = 0
            while (i <= 60)
            {
                let x = UInt32(self.frame.size.width)
                let a:UInt32 = arc4random() % x
                let y = UInt32(self.frame.size.height)
                let b:UInt32 = arc4random() % y
                let radius:CGFloat = CGFloat(arc4random()) % radiusRange / 10
                let lineWith:Float = Float(arc4random()) % Float(5.0)
                let path:UIBezierPath = self.drawStarBezier(CGFloat(a), y: CGFloat(b), radius: radius, sides: 5, pointyness: 2)
                if (ton == 0) {
                    getRandomColorWithRed().setStroke()
                    getRandomColorWithRed().setFill()
                }
                else if (ton == 1) {
                    getRandomColorWithGreen().setStroke()
                    getRandomColorWithGreen().setFill()
                }
                else {
                    getRandomColorWithPurple().setStroke()
                    getRandomColorWithPurple().setFill()
                }
                path.lineWidth = CGFloat(lineWith)
                path.stroke()
                path.fill()

                i = i + 1
            }
            triangleTouched = false
            circleTouched = false
        }
    }
    
    func showAlert() {
        let alert: UIAlertView = UIAlertView()
        alert.delegate = self
        alert.title = "Screenshot"
        alert.message = "Do you want to save this image to your camera roll ?"
        alert.addButtonWithTitle("No")
        alert.addButtonWithTitle("Yes !")
        alert.show()
    }
    
    func showConfirmation() {
        let alert: UIAlertView = UIAlertView()
        alert.delegate = self
        alert.title = "Success !"
        alert.message = "Your screenshot has been successfully saved into your camera roll !"
        alert.addButtonWithTitle("OK")
        alert.show()
    }
    
    func alertView(View: UIAlertView!, clickedButtonAtIndex buttonIndex: Int) {
        switch buttonIndex {
        case 1:
            self.showConfirmation()
            self.hideSubviewsForScreenshot()
            self.pb_takeSnapshot()
            self.showSubviewsAfterScreenshot()
            break;
        case 0:
            NSLog("User refused to save screen");
            break;
        default:
            NSLog("Default");
            break;
        }
    }
    
    func hideSubviewsForScreenshot() {
        slider.hidden = true
        redButton.hidden = true
        greenButton.hidden = true
        purpleButton.hidden = true
        circleButton.hidden = true
        triangleButton.hidden = true
        starButton.hidden = true
        self.delegate?.hideCameraButton()
    }
    
    func showSubviewsAfterScreenshot() {
        slider.hidden = false
        redButton.hidden = false
        greenButton.hidden = false
        purpleButton.hidden = false
        circleButton.hidden = false
        triangleButton.hidden = false
        starButton.hidden = false
        self.delegate?.showCameraButton()
    }
    
    func drawTriangle(width: CGFloat) {
        let x = UInt32(self.frame.size.width)
        let a:UInt32 = arc4random() % x
        let y = UInt32(self.frame.size.height)
        let b:UInt32 = arc4random() % y
        let lineWith:Float = Float(arc4random()) % Float(5.0)
        let path = UIBezierPath(equilateralSide: width, center: CGPoint(x: CGFloat(a), y: CGFloat(b)))        
        if (ton == 0) {
            getRandomColorWithRed().setStroke()
            getRandomColorWithRed().setFill()
        }
        else if (ton == 1) {
            getRandomColorWithGreen().setStroke()
            getRandomColorWithGreen().setFill()
        }
        else {
            getRandomColorWithPurple().setStroke()
            getRandomColorWithPurple().setFill()
        }
        path.lineWidth = CGFloat(lineWith)
        path.fill()
        path.stroke()

    }
    
    func drawRandomArc(radius: CGFloat) {
        let x = UInt32(self.frame.size.width)
        let a:UInt32 = arc4random() % x
        let y = UInt32(self.frame.size.height)
        let b:UInt32 = arc4random() % y
        let path = UIBezierPath()
        let lineWith:Float = Float(arc4random()) % Float(5.0)
        let startPoint = CGPointMake(CGFloat(a), CGFloat(b))
        path.addArcWithCenter(startPoint, radius: radius, startAngle: 0, endAngle: 2*CGFloat(M_PI), clockwise: true)
        path.closePath()
        
        if (ton == 0) {
            getRandomColorWithRed().setStroke()
            getRandomColorWithRed().setFill()
        }
        else if (ton == 1) {
            getRandomColorWithGreen().setStroke()
            getRandomColorWithGreen().setFill()
        }
        else {
            getRandomColorWithPurple().setStroke()
            getRandomColorWithPurple().setFill()
        }
        path.lineWidth = CGFloat(lineWith)
        path.stroke()
        path.fill()
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
        let cpg = points[0]
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

    
    func getRandomColorWithGreen() -> UIColor{
        let randomGreen:CGFloat = CGFloat(drand48())
        let alpha:CGFloat = CGFloat(arc4random()) % CGFloat(1.01)
        return UIColor(red: 0, green: randomGreen, blue: 0, alpha: alpha)
    }
    func getRandomColorWithPurple() -> UIColor{
        let randomRed:CGFloat = CGFloat(drand48())
        let alpha:CGFloat = CGFloat(arc4random()) % CGFloat(1.01)
        return UIColor(red: randomRed, green: 0, blue: randomRed, alpha: alpha)
    }
    
    func getRandomColorWithRed() -> UIColor{
        let randomRed:CGFloat = CGFloat(drand48())
        let alpha:CGFloat = CGFloat(arc4random()) % CGFloat(1.01)
        return UIColor(red: randomRed, green: 0, blue: 0, alpha: alpha)
    }
}

//
//  ViewController.swift
//  drawing
//
//  Created by Sacha BECOURT on 3/25/15.
//  Copyright (c) 2015 CSUSM. All rights reserved.
//

import UIKit

class ViewController: UIViewController, mvc {
    
    @IBOutlet var blurrView: UIVisualEffectView!
    
    @IBOutlet var cameraButton: UIButton!
    @IBOutlet var circleButton: CustomShapeButton!
    @IBOutlet var triangleButton: CustomShapeButton!
    @IBOutlet var starButton: CustomShapeButton!
    @IBOutlet var purpleButton: CustomButton!
    @IBOutlet var greenButton: CustomButton!
    @IBOutlet var redButton: CustomButton!
    @IBOutlet var slider: UISlider!
    @IBOutlet var drawView: ShapeView!
    var alphaValue:Float = 0.5
    var previousValue:Float = 0
    var isFirstValue:Bool = true
    let BLUR_PADDING:CGFloat = 0.02
        override func viewDidLoad() {
            super.viewDidLoad()
            self.showAlert()
            self.drawView.slider = slider
            self.drawView.redButton = redButton
            self.drawView.greenButton = greenButton
            self.drawView.purpleButton = purpleButton
            self.drawView.circleButton = circleButton
            self.drawView.triangleButton = triangleButton
            self.drawView.starButton = starButton
            self.drawView.delegate = self
            slider.minimumTrackTintColor = UIColor.redColor()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func cameraButtonTouched(sender: AnyObject) {
        drawView.showAlert()
    }
    
    @IBAction func pinchDetected(sender: UIPinchGestureRecognizer) {
        let scale = sender.scale
        if (isFirstValue) {
            previousValue = Float(scale)
            blurrView.alpha = CGFloat(alphaValue)
            isFirstValue = false
        }
        else {
            if (previousValue <= Float(scale)) {
                if (blurrView.alpha - BLUR_PADDING < 0 + BLUR_PADDING) {
                    blurrView.alpha = 0.02
                    alphaValue = 0.02
                }
                else {
                    if (sender.state != UIGestureRecognizerState.Ended) {
                        blurrView.alpha -= BLUR_PADDING
                        alphaValue = Float(blurrView.alpha) - Float(BLUR_PADDING)
                    }
                }
                previousValue = Float(scale)
            }
            else if (previousValue >= Float(scale)) {
                if (blurrView.alpha + BLUR_PADDING > 1 - BLUR_PADDING) {
                    blurrView.alpha = 1.0
                    alphaValue = 1.0
                }
                else {
                    blurrView.alpha += BLUR_PADDING
                    alphaValue = Float(blurrView.alpha) + Float(BLUR_PADDING)
                }
                previousValue = Float(scale)
            }
        }
    }
    
    func hideCameraButton() {
        cameraButton.hidden = true
    }
    
    func showCameraButton() {
        cameraButton.hidden = false
    }
    
    func showAlert() {
        let alert: UIAlertView = UIAlertView()
        alert.delegate = self
        alert.title = "Welcome !"
        alert.message = "First, choose a shape, then change the color and adjust the size ! You can also add or remove the blur effect by pinching the screen. Touch the camera to save the image on your device."
        alert.addButtonWithTitle("OK !")
        alert.show()
    }

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.currentDevice().orientation.isLandscape.boolValue {
            self.drawView.setNeedsDisplay()
        } else {
            self.drawView.setNeedsDisplay()
        }
    }
    
    @IBAction func redButtonTouched(sender: AnyObject) {
        self.drawView.ton = 0
        self.circleButton.ton = 0
        self.drawView.setNeedsDisplay()
        self.circleButton.setNeedsDisplay()
        self.triangleButton.ton = 0
        self.triangleButton.setNeedsDisplay()
        self.starButton.ton = 0
        self.starButton.setNeedsDisplay()
        slider.minimumTrackTintColor = UIColor.redColor()
    }
    @IBAction func greenButtonTouched(sender: AnyObject) {
        self.drawView.ton = 1
        self.circleButton.ton = 1
        self.drawView.setNeedsDisplay()
        self.circleButton.setNeedsDisplay()
        self.triangleButton.ton = 1
        self.triangleButton.setNeedsDisplay()
        self.starButton.ton = 1
        self.starButton.setNeedsDisplay()
        slider.minimumTrackTintColor = UIColor.greenColor()
    }
    @IBAction func purpleButtonTouched(sender: AnyObject) {
        self.drawView.ton = 2
        self.circleButton.ton = 2
        self.circleButton.setNeedsDisplay()
        self.drawView.setNeedsDisplay()
        self.triangleButton.ton = 2
        self.triangleButton.setNeedsDisplay()
        self.starButton.ton = 2
        self.starButton.setNeedsDisplay()
        slider.minimumTrackTintColor = UIColor.purpleColor()
    }
    @IBAction func sliderValueChanged(sender: UISlider) {
        let currentValue = sender.value * 2
        self.drawView.radiusRange = CGFloat(currentValue)
        self.drawView.setNeedsDisplay()
    }
    
    @IBAction func circleButtonTouched(sender: AnyObject) {
        self.drawView.circleTouched = true
        self.drawView.triangleTouched = false
        self.drawView.starTouched = false
        self.drawView.setNeedsDisplay()
    }
    @IBAction func triangleButtonTouched(sender: AnyObject) {
        self.drawView.triangleTouched = true
        self.drawView.starTouched = false
        self.drawView.circleTouched = false
        self.drawView.setNeedsDisplay()
    }
    @IBAction func starButtonTouched(sender: AnyObject) {
        self.drawView.starTouched = true
        self.drawView.triangleTouched = false
        self.drawView.circleTouched = false
        self.drawView.setNeedsDisplay()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


//
//  TrayVC.swift
//  CraveApp
//
//  Created by Jenn Leung on 3/10/16.
//  Copyright © 2016 Jenn Leung. All rights reserved.
//

import UIKit

class TrayVC: UIViewController {
    
    @IBOutlet var foodItem1Button: UIButton!
    @IBOutlet var foodItem2Button: UIButton!
    @IBOutlet var foodItem3Button: UIButton!
    @IBOutlet var foodItem4Button: UIButton!
    @IBOutlet var foodItem5Button: UIButton!
    @IBOutlet var foodItem6Button: UIButton!
    @IBOutlet var foodItem7Button: UIButton!
    @IBOutlet var foodItem8Button: UIButton!
    
    @IBOutlet var trayView: UIView!
    var trayOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayDown: CGPoint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onCustomPan:")
        
        // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
        trayView.userInteractionEnabled = true
        trayView.addGestureRecognizer(panGestureRecognizer)
        trayOriginalCenter = CGPoint(x: trayView.center.x, y: trayView.center.y)
        trayDownOffset = 60
        
    }
    
    func onCustomPan(sender: UIPanGestureRecognizer) {
        let point = sender.locationInView(view)
        //let velocity = sender.velocityInView(view)
        //let translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            
            //print("Gesture began at: \(point)")
            
            trayOriginalCenter = trayView.center
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y)
        } else if sender.state == UIGestureRecognizerState.Changed {
            //print("Gesture changed at: \(point)")
        } else if sender.state == UIGestureRecognizerState.Ended {
            //print("Gesture ended at: \(point)")

            if point.y > 0 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    // moving tray back down
                    self.trayDown = CGPoint(x: self.trayView.center.x, y: self.trayView.center.y + self.trayDownOffset)
                    
                    self.trayView.center = self.trayDown
                })
            }
            if point.y < 0 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    //moving tray back Up
                    self.trayView.center = CGPoint(x: self.trayOriginalCenter.x, y: self.trayView.center.y - self.trayDownOffset)
                })
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

//
//  ContainerViewController.swift
//  CraveApp
//
//  Created by Jenn Leung on 3/9/16.
//  Copyright © 2016 Jenn Leung. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController, TrayVCDelegate {
    
    @IBOutlet var trayView: UIView!
    @IBOutlet var homeView: UIView!
    @IBOutlet var cardView: UIView!

    @IBOutlet var panGestureRecognizer: UIView!

    var trayViewController: TrayVC!
    var homeViewController: HomeViewController!
    var cardViewController: CardViewController!
    var cardViewOriginalCenter: CGPoint!
    var trayViewOriginalCenter: CGPoint!
    var trayDown: CGPoint!
    var trayUp: CGPoint!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //instantiate VCs
        trayViewController = storyboard.instantiateViewControllerWithIdentifier("TrayVC") as! TrayVC
        homeViewController = storyboard.instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
        cardViewController = storyboard.instantiateViewControllerWithIdentifier("CardViewController") as! CardViewController
        
        //setting up delegate
        trayViewController.delegate = self
        
        //setting up tray view pan gesture
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onCustomPan:")
        trayView.userInteractionEnabled = true
        trayView.addGestureRecognizer(panGestureRecognizer)
        trayViewOriginalCenter = CGPoint(x: trayView.center.x, y: trayView.center.y)
        
        //setting tray up and down positions
        trayDown = CGPoint(x: 160.0, y: 568.0)
        trayUp = CGPoint(x: 160, y: 488)
        
        trayView.addSubview(trayViewController.view)
        homeView.addSubview(homeViewController.view)
        cardView.addSubview(cardViewController.view)
        cardView.alpha = 0
        cardViewOriginalCenter = CGPoint(x: cardView.center.x, y: cardView.center.y)
        trayViewController.didMoveToParentViewController(self)
        homeViewController.didMoveToParentViewController(self)
        
        self.cardView.center.y += 300
        trayViewOriginalCenter = CGPoint(x:trayView.center.x, y: trayView.center.y)
    }
    
    func foodPicker(vc: TrayVC, foodType: String) {
        print("foodPicker is being called")
        cardView.alpha = 1
        //set up card attributes here
        cardViewController.resultName.text = foodType
        self.cardView.center.y += self.cardView.frame.height
        //self.trayView.center = trayViewOriginalCenter
        cardViewController.handleLabels("Ajisen Ramen")
        UIView.animateWithDuration(0.4) { () -> Void in
            self.cardView.center = self.cardViewOriginalCenter
            //animated tray down upon click
            if self.trayView.center.y != self.trayDown.y {
                self.trayView.center.y = self.trayDown.y
            }
        }
        
    }
    
    func onCustomPan(sender: UIPanGestureRecognizer) {
        //let point = sender.locationInView(view)
        let velocity = sender.velocityInView(view)
        //let translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            
            //print("Gesture began at: \(point)")
            
            //trayViewOriginalCenter = trayView.center
            //trayView.center = CGPoint(x: trayViewOriginalCenter.x, y: trayViewOriginalCenter.y)
        } else if sender.state == UIGestureRecognizerState.Changed {
            //print("Gesture changed at: \(point)")
        } else if sender.state == UIGestureRecognizerState.Ended {
            //print("Gesture ended at: \(point)")
            
            if velocity.y < 0 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    //if panning up, then set tray to up position
                    self.trayView.center.y = self.trayUp.y
                })
            }
            if velocity.y > 0 && self.trayView.frame.height != 568 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    //if panning down, then set tray to down position
                    self.trayView.center = self.trayDown
                })
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

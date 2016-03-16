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
        
        trayViewController.delegate = self
       
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onCustomPan:")
        
        trayView.userInteractionEnabled = true
        
        trayView.addGestureRecognizer(panGestureRecognizer)
        trayViewOriginalCenter = CGPoint(x: trayView.center.x, y: trayView.center.y)
        
        //setting tray up and down positions
        trayDown = CGPoint(x: 160.0, y: 568.0)
        trayUp = CGPoint(x: 160, y: 488)
        print(trayView.center)
        print("trayup \(self.trayView.frame.height)")

        
        //setting up the frame, idk if i need this??
        //        let homeFrame = CGRect(x: 0, y: 0, width: homeView.frame.size.width, height: homeView.frame.size.height)
        //        homeViewController.view.frame = homeFrame
        //        homeViewController.view.frame = homeView.bounds
        //
        //        let trayFrame = CGRect(x: 0, y: 0, width: trayView.frame.size.width, height: 154)
        //        trayViewController.view.frame = trayFrame
        //        trayViewController.view.frame = trayView.bounds
        //
        //        let cardFrame = CGRect(x: 0, y: 0, width: cardView.frame.size.width, height: cardView.frame.size.height)
        //
        //        cardViewController.view.frame = cardFrame
        //        cardViewController.view.frame = cardView.bounds
        
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
        print("WE'RE IN HERE")
        cardView.alpha = 1
        //set up card attributes here
        cardViewController.resultName.text = foodType
        self.cardView.center.y += self.cardView.frame.height
        print("in foodpicker load \(self.trayView.center.y)")
        //self.trayView.center = trayViewOriginalCenter
        
        UIView.animateWithDuration(0.4) { () -> Void in
            self.cardView.center = self.cardViewOriginalCenter
            //animated tray down upon click
            if self.trayView.center.y != 568 {
                self.trayView.center.y = self.trayDown.y
                print("in foodpicker \(self.trayView.frame.height)")
            }
            //print(self.cardView.center)
        }
        
        print(foodType)
        
    }
    
    func onCustomPan(sender: UIPanGestureRecognizer) {
        let point = sender.locationInView(view)
        let velocity = sender.velocityInView(view)
        //let translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            
            print("Gesture began at: \(point)")
            
            //trayViewOriginalCenter = trayView.center
            //trayView.center = CGPoint(x: trayViewOriginalCenter.x, y: trayViewOriginalCenter.y)
        } else if sender.state == UIGestureRecognizerState.Changed {
            print("Gesture changed at: \(point)")
        } else if sender.state == UIGestureRecognizerState.Ended {
            //print("Gesture ended at: \(point)")
            
            if velocity.y < 0 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    //if panning up, then set tray to up position
                    self.trayView.center.y = self.trayUp.y
                    //print(self.trayUp)
                    print("trayup \(self.trayView.center)")
                    print("trayup \(self.trayUp)")
                    //print("trayup \(self.trayView.frame.height)")
                })
            }
            if velocity.y > 0 && self.trayView.frame.height != 568 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    //if panning down, then set tray to down position
                    self.trayView.center = self.trayDown
                    print("traydown \(self.trayView.frame.height)")
                })
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

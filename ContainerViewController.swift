//
//  ContainerViewController.swift
//  CraveApp
//
//  Created by Jenn Leung on 3/9/16.
//  Copyright © 2016 Jenn Leung. All rights reserved.
//

import UIKit

let screenSize: CGRect = UIScreen.mainScreen().bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height

class ContainerViewController: UIViewController, TrayVCDelegate {
    
    @IBOutlet var trayView: UIView!
    @IBOutlet var homeView: UIView!
    @IBOutlet var cardView: UIView!
    
    var trayViewController: TrayVC!
    var homeViewController: HomeViewController!
    var cardViewController: CardViewController!
    
    var cardViewOriginalCenter: CGPoint!
    var trayViewOriginalCenter: CGPoint!
    var trayDown: CGPoint!
    var trayUp: CGPoint!
    
    
    
    func foodPicker(vc: TrayVC, searchQuery: String) {
        self.cardViewController.view.alpha = 1
        self.cardViewController.resetCardView()
        
        cardViewController.resultName.text = searchQuery
        
        //Step 1: Initiate search
        //searchQuery(foodType, homeViewController.resultLocation, radius)
        
        UIView.animateWithDuration(0.4, delay: 0, options: [], animations: {
            
            //Step 2: Slide-down current card
            self.cardView.center.y = self.cardViewOriginalCenter.y + screenHeight
            
            }, completion: { (Bool) -> Void in
                
                //Step 3: Show a loader (to do later)
                //showLoader()
                
                //Step 4: Check if we should display error or result
                //if result {
                
                //Step 5A: Populate New Result
                self.cardViewController.handleLabels(searchQuery)
                //dismissLoader()
                
                //} else {
                
                //Step 5B: Show No Result
                
                //}
                
                UIView.animateWithDuration(0.4) { () -> Void in
                    
                    //Step 6: Slide-up new card
                    self.cardView.center = self.cardViewOriginalCenter
                    
                    //Step 7: Slide-down food tray
                    if self.trayView.center.y != self.trayDown.y {
                        self.trayView.center.y = self.trayDown.y
                    }
                }
        })
        
    }
    
    func prepareContainerForCardEntry() {
        
    }
    
    func prepareContainerForCardSwap() {
        
    }
    
    func prepareContainerForCardExit() {
        
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //homeViewController
        homeViewController = storyboard.instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
        homeView.addSubview(homeViewController.view)
        homeViewController.didMoveToParentViewController(self)
        
        
        //trayViewController
        trayViewController = storyboard.instantiateViewControllerWithIdentifier("TrayVC") as! TrayVC
        trayView.addSubview(trayViewController.view)
        trayViewController.didMoveToParentViewController(self)
        
        //set up delegate
        trayViewController.delegate = self
        
        //add pan gesture
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onCustomPan:")
        trayView.userInteractionEnabled = true
        trayView.addGestureRecognizer(panGestureRecognizer)
        
        //position settings
        let trayHeight = trayView.frame.height
        trayViewOriginalCenter = trayView.center
        trayDown = CGPoint(x: screenWidth/2, y: screenHeight)
        trayUp = CGPoint(x: screenWidth/2, y: screenHeight - trayHeight/2)
        
        
        //cardViewController
        cardViewController = storyboard.instantiateViewControllerWithIdentifier("CardViewController") as! CardViewController
        cardView.addSubview(cardViewController.view)
        cardViewController.didMoveToParentViewController(self)
        
        //cardView Settings
        cardViewOriginalCenter = cardView.center
        //move cardView outside the container
        cardView.center.y = cardViewOriginalCenter.y + screenHeight
        
    }
    
    
    func onCustomPan(sender: UIPanGestureRecognizer) {
        let velocity = sender.velocityInView(view)
        let translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            //tray
            if velocity.y > 0 && trayView.frame.origin.y < trayUp.y {
                trayView.center = CGPoint (x: trayViewOriginalCenter.x, y: trayViewOriginalCenter.y + translation.y)
            } else if velocity.y < 0 && trayView.frame.origin.y > screenHeight - trayView.frame.height {
                trayView.center = CGPoint (x: trayViewOriginalCenter.x, y: trayViewOriginalCenter.y + translation.y)
            }
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            
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
    }
    
    
}

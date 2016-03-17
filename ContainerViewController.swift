//
//  ContainerViewController.swift
//  CraveApp
//
//  Created by Jenn Leung on 3/9/16.
//  Copyright © 2016 Jenn Leung. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

var trayViewController: TrayVC!
var homeViewController: HomeViewController!
var cardViewController: CardViewController!

let screenSize: CGRect = UIScreen.mainScreen().bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height
var cardInView = 0

class ContainerViewController: UIViewController, TrayVCDelegate, CardVCDelegate {
    
    @IBOutlet var trayView: UIView!
    @IBOutlet var homeView: UIView!
    @IBOutlet var cardView: UIView!
    @IBOutlet var loaderView: UIView!
    
    var cardViewOriginalCenter: CGPoint!
    var trayViewOriginalCenter: CGPoint!
    var trayDown: CGPoint!
    var trayUp: CGPoint!
    
    
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
        
        //cardViewController
        cardViewController = storyboard.instantiateViewControllerWithIdentifier("CardViewController") as! CardViewController
        cardView.addSubview(cardViewController.view)
        cardViewController.didMoveToParentViewController(self)
        
        //add pan gesture
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onCustomPan:")
        trayView.userInteractionEnabled = true
        trayView.addGestureRecognizer(panGestureRecognizer)
        
        //position settings
        let trayHeight = trayView.frame.height
        trayViewOriginalCenter = trayView.center
        trayDown = CGPoint(x: screenWidth/2, y: screenHeight)
        trayUp = CGPoint(x: screenWidth/2, y: screenHeight - trayHeight/2)
        
        //set up delegates
        trayViewController.delegate = self
        cardViewController.delegate = self
        
        //cardView Settings
        cardViewOriginalCenter = cardView.center
        //move cardView outside the container
        cardView.center.y = cardViewOriginalCenter.y + screenHeight
        
    }
    
    //Called on each button tap
    func foodPicker(vc: TrayVC, searchQuery: String) {
        //cardViewController.view.alpha = 1
        //cardViewController.resetCardView()
        
        //1: Update location
        //2: Initiate search (foodtype, location, radius)
        //3: Call card entry or card swap function
        if cardInView == 0 {
            prepareContainerForCardEntry(searchQuery)
        } else if cardInView == 1 {
            prepareContainerForCardSwap(searchQuery)
        }
        //4: Update app state
        cardInView = 1
    }
    
    
    func prepareContainerForCardEntry(searchQuery: String) {
        let activityIndicatorView = NVActivityIndicatorView(frame: self.loaderView.frame,
            type: .LineScalePulseOut, color: UIColor(red:0.55, green:0.88, blue:0.44, alpha:1.0)
        )
        
        self.view.addSubview(activityIndicatorView)
        
        //1: Hide settingsView & Show maskView
        UIView.animateWithDuration(0.4, animations: {
            homeViewController.settingsView.alpha = 0
            homeViewController.maskView.alpha = 1
            homeViewController.currentLocation.textColor = UIColor.whiteColor()
            homeViewController.currentLocation.font = homeViewController.currentLocation.font.fontWithSize(12)
            homeViewController.closeButton.alpha = 1
            }, completion: { (Bool) -> Void in
        })
        //2: Check if we are ready to show result?
        //3: Show a loader
        
        activityIndicatorView.startAnimation()
        
        let delay = 1 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) {
            activityIndicatorView.stopAnimation()
        }

        
        //4: Check if we have result, dismiss loader
        //5A: Slide-up No Result Found
        
        //5B: Slide-up Result Card
        cardViewController.handleLabels(searchQuery)
        UIView.animateWithDuration(0.4) { () -> Void in
            self.cardView.center = self.cardViewOriginalCenter
            
            //6: Slide-down food tray
            if self.trayView.center.y != self.trayDown.y {
                self.trayView.center.y = self.trayDown.y
            }
            //7: Show selected button
        }
    }
    
    
    
    
    func prepareContainerForCardSwap(searchQuery: String) {
        let activityIndicatorView = NVActivityIndicatorView(frame: self.loaderView.frame,
            type: .LineScalePulseOut, color: UIColor(red:0.55, green:0.88, blue:0.44, alpha:1.0)
        )
        
        self.view.addSubview(activityIndicatorView)
        
        //0: Update location
        //1: Slide-down current card
        UIView.animateWithDuration(0.4, delay: 0, options: [], animations: {
            self.cardView.center.y = self.cardViewOriginalCenter.y + screenHeight
            }, completion: { (Bool) -> Void in
                //2: Check if we are ready to show result?
                
                //3: Show a loader
                
                activityIndicatorView.startAnimation()
                
                //temporary delay to dismiss loader
                let delay = 1.5 * Double(NSEC_PER_SEC)
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                dispatch_after(time, dispatch_get_main_queue()) {
                    activityIndicatorView.stopAnimation()
                }
                
                //4: Check if we have result, dismiss loader
                //5A: Slide-up No Result Found
                
                //5B: Slide-up New Result Card
                cardViewController.handleLabels(searchQuery)
                UIView.animateWithDuration(0.4) { () -> Void in
                    self.cardView.center = self.cardViewOriginalCenter
                    
                    //6: Slide-down food tray
                    if self.trayView.center.y != self.trayDown.y {
                        self.trayView.center.y = self.trayDown.y
                    }
                    //7: Show selected button
                }
                
        })
    }
    
    func finishedDragCard(vc: CardViewController, finished: Bool) {
        prepareContainerForCardExit()
    }
    
    
    func prepareContainerForCardExit() {
        //1: Update location
        //2: Hide maskView, show settingsView
        UIView.animateWithDuration(0.2, animations: {
            homeViewController.maskView.alpha = 0
            homeViewController.settingsView.alpha = 1
            }, completion: { (Bool) -> Void in
        })
        
        //3: Slide-down card
        self.cardView.center.y = self.cardViewOriginalCenter.y + screenHeight
        
        //4: Slide-up food tray
        //5: Deselect all buttons
        //6: Change app state
        cardInView = 0
        
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
    
    lazy private var tempActivityIndicator : CustomActivityIndicatorView = {
        let image : UIImage = UIImage(named: "fooditem1")!
        return CustomActivityIndicatorView(image: image)
    }()
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

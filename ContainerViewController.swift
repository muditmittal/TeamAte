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
var menuViewController: MenuViewController!
var homeViewController: HomeViewController!
var cardViewController: CardViewController!

let screenSize: CGRect = UIScreen.mainScreen().bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height
var cardInView = 0

var searchString = ""

class ContainerViewController: UIViewController, TrayVCDelegate, MenuVCDelegate, CardVCDelegate, HomeVCDelegate {
    
    @IBOutlet var trayView: UIView!
    @IBOutlet var homeView: UIView!
    @IBOutlet var cardView: UIView!
    @IBOutlet var loaderView: UIView!
    @IBOutlet weak var menuView: UIView!
    
    
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
        menuViewController = storyboard.instantiateViewControllerWithIdentifier("MenuViewController") as! MenuViewController
        menuView.addSubview(menuViewController.view)
        menuViewController.didMoveToParentViewController(self)

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
        homeViewController.delegate = self
        menuViewController.delegate = self
        
        //cardView Settings
        cardViewOriginalCenter = cardView.center
        //move cardView outside the container
        cardView.center.y = cardViewOriginalCenter.y + screenHeight
        
    }

    func searchFor(vc: MenuViewController, searchQuery: String) {
        print("hi")
        
        //Protocol:
        //1: Update location
        //2: Initiate search (foodtype, location, radius)
        //3: Call card entry or card swap function
        //4: Update app state

        if cardInView == 0 {
            prepareContainerForCardEntry(searchQuery)
        } else if cardInView == 1 {
            prepareContainerForCardSwap(searchQuery)
        }
        cardInView = 1
        cardViewController.fetchVenues(searchQuery)
        
    }

    
    //Called on each button tap
    func foodPicker(vc: TrayVC, searchQuery: String) {
        
        //Protocol:
        //1: Update location
        //2: Initiate search (foodtype, location, radius)
        //3: Call card entry or card swap function
        //4: Update app state


        
        //3: Call card entry or card swap function
        if cardInView == 0 {
            prepareContainerForCardEntry(searchQuery)
        } else if cardInView == 1 {
            prepareContainerForCardSwap(searchQuery)
        }
        //4: Update app state
        cardInView = 1
        
        //searchString = searchQuery
        cardViewController.fetchVenues(searchQuery)
        //trayViewController.fetchVenues(searchQuery)
        
    }
    
    func prepareContainerForCardEntry(searchQuery: String) {
        
        //Protocol:
        //1: Toggle settingsView & maskView
        //2: Check if we have results to show already
        //3: If not, show a loader
        //4: Check if we have result, if yes, dismiss loader
        //5: If NO results, Slide-up noresultView
        //6: Slide-up result cardView
        //7: Slide-down food tray
        //8: Show selected button

        
        
        //1: Toggle settingsView & maskView
        UIView.animateWithDuration(0.4, animations: {
            homeViewController.settingsView.alpha = 0
            homeViewController.maskView.alpha = 1
            homeViewController.currentLocation.textColor = UIColor.whiteColor()
            homeViewController.currentLocation.font = homeViewController.currentLocation.font.fontWithSize(12)
            homeViewController.closeButton.alpha = 1
            }, completion: { (Bool) -> Void in
        })

        //3: If not, show a loader
        let activityIndicatorView = NVActivityIndicatorView(frame: self.loaderView.frame,
            type: .LineScalePulseOut, color: UIColor(red:0.55, green:0.88, blue:0.44, alpha:1.0)
        )
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimation()
        let delay = 1 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) {
            activityIndicatorView.stopAnimation()
        }
        
        //cardViewController.handleLabels(searchQuery)
        UIView.animateWithDuration(0.4) { () -> Void in
            self.cardView.center = self.cardViewOriginalCenter
            
            //6: Slide-down food tray
            if self.trayView.center.y != self.trayDown.y {
                self.trayView.center.y = self.trayDown.y
            }
        }
    }
    
    
    
    
    func prepareContainerForCardSwap(searchQuery: String) {

        //Protocol:
        //1: Update location
        //2: Slide-down current cardView
        //3: Check if we have results to show already, if no, show loader
        //4: Check if we have result, if yes, dismiss loader
        //5: If NO results, Slide-up noresultView
        //6: Slide-up new cardView
        //7: Slide-down food tray
        //8: Show selected button
        
        
        //2: Slide-down current cardView
        UIView.animateWithDuration(0.4, delay: 0, options: [], animations: {
            self.cardView.center.y = self.cardViewOriginalCenter.y + screenHeight
            }, completion: { (Bool) -> Void in
                
                //3: Check if we have results to show already, if no, show loader
                let activityIndicatorView = NVActivityIndicatorView(frame: self.loaderView.frame,
                    type: .LineScalePulseOut, color: UIColor(red:0.55, green:0.88, blue:0.44, alpha:1.0)
                )
                self.view.addSubview(activityIndicatorView)
                activityIndicatorView.startAnimation()
                //temporary delay to dismiss loader
                let delay = 1.5 * Double(NSEC_PER_SEC)
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                dispatch_after(time, dispatch_get_main_queue()) {
                    activityIndicatorView.stopAnimation()
                }
                
                //cardViewController.handleLabels(searchQuery)
                UIView.animateWithDuration(0.4) { () -> Void in

                    //6: Slide-up new cardView
                    self.cardView.center = self.cardViewOriginalCenter
                    
                    //7: Slide-down food tray
                    if self.trayView.center.y != self.trayDown.y {
                        self.trayView.center.y = self.trayDown.y
                    }
                }
                
        })
    }
    
    func finishedDragCard(vc: CardViewController, finished: Bool) {
        prepareContainerForCardExit()
    }
    
    func clickedCloseButton(vc: HomeViewController, clicked: Bool) {
        prepareContainerForCardExit()
    }
    
    
    func prepareContainerForCardExit() {

        //Protocol:
        //1: Update location
        //2: Hide maskView, show settingsView
        //3: Slide-down cardView
        //4: Slide-up food tray
        //5: Deselect all buttons
        //6: Change app state

        
        //2: Hide maskView, show settingsView
        UIView.animateWithDuration(0.2, animations: {
            homeViewController.maskView.alpha = 0
            homeViewController.settingsView.alpha = 1
            }, completion: { (Bool) -> Void in
        })

        //3: Slide-down cardView
        self.cardView.center.y = self.cardViewOriginalCenter.y + screenHeight

        //6: Change app state
        cardInView = 0
        
    }
    
    
    
//    func onCustomPan(sender: UIPanGestureRecognizer) {
//        let velocity = sender.velocityInView(view)
//        let translation = sender.translationInView(view)
//        
//        if sender.state == UIGestureRecognizerState.Began {
//            
//        } else if sender.state == UIGestureRecognizerState.Changed {
//            
//            //tray
//            if velocity.y > 0 && trayView.frame.origin.y < trayUp.y {
//                trayView.center = CGPoint (x: trayViewOriginalCenter.x, y: trayViewOriginalCenter.y + translation.y)
//            } else if velocity.y < 0 && trayView.frame.origin.y > screenHeight - trayView.frame.height {
//                trayView.center = CGPoint (x: trayViewOriginalCenter.x, y: trayViewOriginalCenter.y + translation.y)
//            }
//            
//        } else if sender.state == UIGestureRecognizerState.Ended {
//            
//            if velocity.y < 0 {
//                UIView.animateWithDuration(0.3, animations: { () -> Void in
//                    //if panning up, then set tray to up position
//                    self.trayView.center.y = self.trayUp.y
//                })
//            }
//            if velocity.y > 0 && self.trayView.frame.height != 568 {
//                UIView.animateWithDuration(0.3, animations: { () -> Void in
//                    //if panning down, then set tray to down position
//                    self.trayView.center = self.trayDown
//                })
//            }
//            
//        }
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

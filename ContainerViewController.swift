//
//  ContainerViewController.swift
//  CraveApp
//
//  Created by Jenn Leung on 3/9/16.
//  Copyright © 2016 Jenn Leung. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

var menuViewController: MenuViewController!
var homeViewController: HomeViewController!
var cardViewController: CardViewController!

let screenSize: CGRect = UIScreen.mainScreen().bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height
var duration = 0.4
var cardInView = 0

class ContainerViewController: UIViewController, MenuVCDelegate, CardVCDelegate, HomeVCDelegate {
    
    @IBOutlet var homeView: UIView!
    @IBOutlet var cardView: UIView!
    @IBOutlet var loaderView: UIView!
    @IBOutlet weak var menuView: UIView!
        
    var cardViewOriginalCenter: CGPoint!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        homeViewController = storyboard.instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
        cardViewController = storyboard.instantiateViewControllerWithIdentifier("CardViewController") as! CardViewController
        menuViewController = storyboard.instantiateViewControllerWithIdentifier("MenuViewController") as! MenuViewController
        homeView.addSubview(homeViewController.view)
        cardView.addSubview(cardViewController.view)
        menuView.addSubview(menuViewController.view)
        homeViewController.didMoveToParentViewController(self)
        cardViewController.didMoveToParentViewController(self)
        menuViewController.didMoveToParentViewController(self)
        homeViewController.delegate = self
        cardViewController.delegate = self
        menuViewController.delegate = self
        
        cardViewOriginalCenter = cardView.center
        cardView.center.y = cardViewOriginalCenter.y + screenHeight
        
//        let activityIndicatorView = NVActivityIndicatorView(frame: self.loaderView.frame,
//            type: .LineScalePulseOut, color: UIColor(red:0.55, green:0.88, blue:0.44, alpha:1.0)
//        )
//        loaderView.addSubview(activityIndicatorView)
    }

    func searchFor(vc: MenuViewController, searchQuery: String) {
        
        //Protocol For: *** Everytime a new menu item is selected ***
        
        //1: Update location
        //2: Initiate search
        //3: Call card entry or swap function
        //4: Update app state
        //---------------------------------------------------

        //1:Update location
        updateLocation()
        
        //2: Initiate search
        cardViewController.fetchVenues(searchQuery)

        //3: Call card entry or swap function
        if cardInView == 0 {

            prepareContainerForCardEntry(searchQuery)
        } else if cardInView == 1 {

            prepareContainerForCardSwap(searchQuery)
        }
        //4: Update app state
        cardInView = 1
        
    }

    
    
    
    
    func updateLocation() {
        // ******************************************
        // Add code for updating user location here
        // ******************************************
    }

    
    func prepareContainerForCardEntry(searchQuery: String) {
        
        //Protocol For: *** When pulling first result ***
        
        //1: Toggle settingsView & maskView
        //2: Check if we have results to show already
        //3: If not, show a loader
        //4: Check if we have result, if yes, dismiss loader
        //5: If NO results, Slide-up noresultView
        //6: Slide-up result cardView
        //---------------------------------------------------
        
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.5, options: [.CurveEaseInOut, .AllowUserInteraction], animations: {
                
            //1: Toggle settingsView & maskView
            homeViewController.settingsView.alpha = 0
            homeViewController.maskView.alpha = 1
            homeViewController.currentLocation.textColor = UIColor.whiteColor()
            homeViewController.currentLocation.font = homeViewController.currentLocation.font.fontWithSize(12)
            homeViewController.closeButton.alpha = 1

            //3: Show loader
            let activityIndicatorView = NVActivityIndicatorView(frame: self.loaderView.frame,
                type: .BallScaleRippleMultiple, color: UIColor(red:1, green:1, blue:1, alpha:1.0)
            )
            self.view.addSubview(activityIndicatorView)
            activityIndicatorView.startAnimation()
                
            //4: Dismiss loader
            let delay = 1.2 * duration * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue()) {
                activityIndicatorView.stopAnimation()
            }
                
            }, completion: { (Bool) -> Void in
                UIView.animateWithDuration(duration, delay: duration, options: [], animations: {
                    
                    //6: Slide-up result cardView
                    self.cardView.center = self.cardViewOriginalCenter
                    }, completion: { (Bool) -> Void in
                        
            })
        })
    }
    
    
    func prepareContainerForCardSwap(searchQuery: String) {

        //Protocol For: *** When pulling subsequent results ***

        //1: Slide-down current cardView
        //2: Check if we have results to show already, if no, show loader
        //3: Check if we have result, if yes, dismiss loader
        //4: If NO results, Slide-up noresultView
        //5: Slide-up new cardView
        //---------------------------------------------------

        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.5, options: [.CurveEaseInOut, .AllowUserInteraction], animations: {

            //1: Slide-down current cardView
            self.cardView.center.y = self.cardViewOriginalCenter.y + screenHeight
            
            //2: Show loader
            let activityIndicatorView = NVActivityIndicatorView(frame: self.loaderView.frame,
                type: .BallScaleRippleMultiple, color: UIColor(red:1, green:1, blue:1, alpha:1.0)
            )
            self.view.addSubview(activityIndicatorView)
            activityIndicatorView.startAnimation()

            //3: Dismiss loader
            let delay = 1.2 * duration * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue()) {
                activityIndicatorView.stopAnimation()
            }

        }, completion: { (Bool) -> Void in
            UIView.animateWithDuration(duration, delay: duration, options: [], animations: {

                //5: Slide-up new cardView
                self.cardView.center = self.cardViewOriginalCenter
                }, completion: { (Bool) -> Void in
                    
            })
        })
    }
    
    
    func prepareContainerForCardExit() {

        //Protocol For: *** When user taps close or swipes-down a card ***
        
        //1: Toggle maskView & settingsView
        //2: Slide-down cardView
        //3: Change app state
        //---------------------------------------------------
        
        //1: Hide maskView, show settingsView
        UIView.animateWithDuration(duration/2, animations: {
            homeViewController.maskView.alpha = 0
            homeViewController.settingsView.alpha = 1
            }, completion: { (Bool) -> Void in
        })

        //2: Slide-down cardView
        self.cardView.center.y = self.cardViewOriginalCenter.y + screenHeight

        //3: Change app state
        cardInView = 0
    }
    
    func finishedDragCard(vc: CardViewController, finished: Bool) {
        
        prepareContainerForCardExit()
    }
    
    func clickedCloseButton(vc: HomeViewController, clicked: Bool) {
        
        prepareContainerForCardExit()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

//
//  ContainerViewController.swift
//  CraveApp
//
//  Created by Jenn Leung on 3/9/16.
//  Copyright © 2016 Jenn Leung. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

var cardViewController: CardViewController!

let screenSize: CGRect = UIScreen.mainScreen().bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height
var duration = 0.4
var cardInView = 0

class ContainerViewController: UIViewController, CardVCDelegate {
    
    @IBOutlet weak var currentLocation: UILabel!
    @IBOutlet var homeView: UIView!
    @IBOutlet var cardView: UIView!
    @IBOutlet var loaderView: UIView!
    @IBOutlet weak var menuButton: UIButton!
    
    var menuTransition: MenuTransition!
    var cardViewOriginalCenter: CGPoint!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        cardViewController = storyboard.instantiateViewControllerWithIdentifier("CardViewController") as! CardViewController
        cardView.addSubview(cardViewController.view)
        cardViewController.didMoveToParentViewController(self)
        cardViewController.delegate = self
        
        cardViewOriginalCenter = cardView.center
        cardView.center.y = cardViewOriginalCenter.y + screenHeight
        
        menuTransition = MenuTransition()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        performSegueWithIdentifier("unanimatedMenuSegue", sender: nil)
    }


    func initiateSearch(searchQuery: String) {

        //Protocol For: *** Everytime a new menu item is selected ***
        
        //1: Update location
        //2: Initiate search
        //3: Call card entry or swap function
        //4: Update app state
        //---------------------------------------------------

        updateLocation()
        cardViewController.fetchVenues(searchQuery)
        if cardInView == 0 {
            
            prepareContainerForCardEntry(searchQuery)
        } else if cardInView == 1 {
            
            prepareContainerForCardSwap(searchQuery)
        }
        cardInView = 1
        
    }
    
    
    func updateLocation() {
        // ******************************************
        // Add code for updating user location here
        // ******************************************
    }



    func prepareContainerForCardEntry(searchQuery: String) {
        
        //Protocol For: *** When pulling first result ***
        
        //1: Check if we have results to show already
        //2: If not, show loader
        //3: If yes, dismiss loader
        //4: If NO results, show noresultView
        //5: Show result cardView
        //---------------------------------------------------
        
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.5, options: [.CurveEaseInOut, .AllowUserInteraction], animations: {
                
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
                    
                    //5: Show result cardView
                    self.cardView.center = self.cardViewOriginalCenter
                    }, completion: { (Bool) -> Void in
                        
                })
        })
    }
    
    
    func prepareContainerForCardSwap(searchQuery: String) {
        
        //Protocol For: *** When pulling subsequent results ***
        
        //1: Slide-down current cardView
        //2: Check if we have results to show already,
        //3: If no, show loader
        //4: If yes, dismiss loader
        //5: If NO results, show noresultView
        //6: Show new cardView
        //---------------------------------------------------
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.5, options: [.CurveEaseInOut, .AllowUserInteraction], animations: {
                
                //1: Slide-down current cardView
                self.cardView.center.y = self.cardViewOriginalCenter.y + screenHeight
                
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
                    
                    //6: Slide-up new cardView
                    self.cardView.center = self.cardViewOriginalCenter
                    }, completion: { (Bool) -> Void in
                        
                })
        })
    }
    
    
    func prepareContainerForCardExit() {
        
        //Protocol For: *** When user taps close or swipes-down a card ***
        
        //1: Slide-down cardView
        //2: Change app state
        //3: Open menuView
        //---------------------------------------------------
        
        //1: Slide-down cardView
        self.cardView.center.y = self.cardViewOriginalCenter.y + screenHeight
        
        //2: Change app state
        cardInView = 0
        
        //3: Open menuView
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    

    @IBAction func onMenuButtonTap(sender: AnyObject) {

    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let menuViewController = segue.destinationViewController as! MenuViewController
        menuViewController.containerViewController = self
        menuViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        
        menuViewController.view.layoutIfNeeded()
        menuViewController.transitioningDelegate = menuTransition
    }
    
    
    func finishedDragCard(vc: CardViewController, finished: Bool) {
        
        prepareContainerForCardExit()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

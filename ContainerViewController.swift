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

var duration = 0.4      //animation duration

class ContainerViewController: UIViewController, CardVCDelegate {
    
    @IBOutlet weak var currentLocation: UILabel!
    @IBOutlet var homeView: UIView!
    @IBOutlet var cardView: UIView!
    @IBOutlet var loaderView: UIView!
    @IBOutlet weak var menuButton: UIButton!
    
    var menuTransition: MenuTransition!
    var cardViewOriginalCenter: CGPoint!
    
    var activityIndicatorView: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        var delegate: ContainerVCDelegate?
        
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
        
        self.prepareContainerForCardExit(searchQuery)
        startLoader()
        updateLocation()
        cardViewController.fetchVenues(searchQuery, success: { () -> () in
            self.stopLoader()
            self.prepareContainerForCardEntry(searchQuery)
        })
        
        
    }
    
    
    func updateLocation() {
    }
    
    
    
    func prepareContainerForCardEntry(searchQuery: String) {
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.5, options: [.CurveEaseInOut, .AllowUserInteraction], animations: {
                
            }, completion: { (Bool) -> Void in
                UIView.animateWithDuration(duration, delay: duration, options: [], animations: {
                    
                    //5: Show result cardView
                    self.cardView.center = self.cardViewOriginalCenter
                    }, completion: { (Bool) -> Void in
                        
                })
        })
    }
    
    func startLoader() {
        activityIndicatorView = NVActivityIndicatorView(frame: self.loaderView.frame,
            type: .BallScaleRippleMultiple, color: UIColor(red:1, green:1, blue:1, alpha:1.0)
        )
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimation()
    }
    
    func stopLoader() {
        self.activityIndicatorView.stopAnimation()
    }
    
    func prepareContainerForCardExit(searchQuery: String) {
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.5, options: [.CurveEaseInOut, .AllowUserInteraction], animations: {
                //1: Slide-down current cardView
                self.cardView.center.y = self.cardViewOriginalCenter.y + screenHeight
            }, completion: { (Bool) -> Void in
        })
    }
    
    
    func finishedDragCard(vc: CardViewController, finished: Bool) {
        
        //1: Slide-down cardView
        self.cardView.center.y = self.cardViewOriginalCenter.y + screenHeight
        
        //3: Open menuView
        performSegueWithIdentifier("unanimatedMenuSegue", sender: nil)
    }
    
    
    
    
    @IBAction func onMenuButtonTap(sender: AnyObject) {
        //Don't delete this, the empty function calls menuTransition segue
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let menuViewController = segue.destinationViewController as! MenuViewController
        menuViewController.containerViewController = self
        menuViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        menuViewController.view.layoutIfNeeded()
        menuViewController.transitioningDelegate = menuTransition
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}



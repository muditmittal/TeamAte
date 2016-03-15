//
//  ContainerViewController.swift
//  CraveApp
//
//  Created by Jenn Leung on 3/9/16.
//  Copyright © 2016 Jenn Leung. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController, TrayVCDelegate {
    
    var trayViewController: TrayVC!
    var homeViewController: HomeViewController!
    var cardViewController: CardViewController!
    @IBOutlet var trayView: UIView!
    @IBOutlet var homeView: UIView!
    @IBOutlet var cardView: UIView!
    var cardViewOriginalCenter: CGPoint!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //instantiate VCs
        trayViewController = storyboard.instantiateViewControllerWithIdentifier("TrayVC") as! TrayVC
        homeViewController = storyboard.instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
        cardViewController = storyboard.instantiateViewControllerWithIdentifier("CardViewController") as! CardViewController
        
        trayViewController.delegate = self
        
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
    }
    
    func foodPicker(vc: TrayVC, foodType: String) {
        print("WE'RE IN HERE")
        cardView.alpha = 1
        //set up card attributes here
        cardViewController.resultName.text = foodType
        self.cardView.center.y += self.cardView.frame.height
        
        UIView.animateWithDuration(0.75) { () -> Void in
            self.cardView.center = self.cardViewOriginalCenter
            print(self.cardView.center)
        }
        
        print(foodType)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

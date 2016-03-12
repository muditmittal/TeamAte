//
//  ContainerViewController.swift
//  CraveApp
//
//  Created by Jenn Leung on 3/9/16.
//  Copyright © 2016 Jenn Leung. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    var trayViewController: UIViewController!
    var homeViewController: UIViewController!
    var cardViewController: UIViewController!
    @IBOutlet var trayView: UIView!
    @IBOutlet var homeView: UIView!
    @IBOutlet var cardView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //instantiate VCs
        trayViewController = storyboard.instantiateViewControllerWithIdentifier("TrayVC") as! TrayVC
        homeViewController = storyboard.instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
        cardViewController = storyboard.instantiateViewControllerWithIdentifier("CardViewController") as! CardViewController
        
        //setting up the frame
        let homeFrame = CGRect(x: 0, y: 0, width: homeView.frame.size.width, height: homeView.frame.size.height)
        homeViewController.view.frame = homeFrame
        homeViewController.view.frame = homeView.bounds
        
        let trayFrame = CGRect(x: 0, y: 0, width: trayView.frame.size.width, height: 154)
        trayViewController.view.frame = trayFrame
        trayViewController.view.frame = trayView.bounds
        
        let cardFrame = CGRect(x: 0, y: 0, width: cardView.frame.size.width, height: cardView.frame.size.height)
        
        cardViewController.view.frame = cardFrame
        cardViewController.view.frame = cardView.bounds
        
        homeView.addSubview(homeViewController.view)
        trayView.addSubview(trayViewController.view)
        cardView.addSubview(cardViewController.view)
        
        //trayViewController.didMoveToParentViewController(self)
        //homeViewController.didMoveToParentViewController(self)
        
        
        
        // this is from a pull request – Alvin
        // this is pull/push from Mudit
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

//
//  ContainerViewController.swift
//  CraveApp
//
//  Created by Jenn Leung on 3/9/16.
//  Copyright © 2016 Jenn Leung. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController, TrayVCDelegate {
    
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
        let trayViewController = storyboard.instantiateViewControllerWithIdentifier("TrayVC") as! TrayVC
        let homeViewController = storyboard.instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
        let cardViewController = storyboard.instantiateViewControllerWithIdentifier("CardViewController") as! CardViewController
        
        trayViewController.delegate = self
        
        presentViewController(trayViewController, animated: true, completion: nil)
        
        //setting up the frame
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
        

//        view.addSubview(cardViewController.view)
//        view.bringSubviewToFront(cardViewController.view)
        
//        trayViewController.didMoveToParentViewController(self)
//        homeViewController.didMoveToParentViewController(self)
        
        //print(trayViewController.setupHandlers())
       
        
        // this is from a pull request – Alvin
        // this is pull/push from Mudit
        
    }

    func foodPicker(vc: TrayVC, foodType: String) {
        print("WE'RE IN HERE")
        print(foodType)
        cardView.addSubview(cardViewController.view)
        presentViewController(cardViewController, animated: true, completion: nil)
    }
    func sample (){
        print(TrayVC().handleButtonClicked("Burger"))
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

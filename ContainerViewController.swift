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
    @IBOutlet var trayView: UIView!
    @IBOutlet var homeView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        trayViewController = storyboard.instantiateViewControllerWithIdentifier("TrayVC") as! TrayVC
        homeViewController = storyboard.instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
        
        let homeFrame = CGRect(x: 0, y: 0, width: homeView.frame.size.width, height: homeView.frame.size.height)
        
        homeViewController.view.frame = homeFrame
        homeViewController.view.frame = homeView.bounds
        
        let trayFrame = CGRect(x: 0, y: 0, width: trayView.frame.size.width, height: 154)
      
        trayViewController.view.frame = trayFrame
        trayViewController.view.frame = trayView.bounds
        
        
        homeView.addSubview(homeViewController.view)
        trayView.addSubview(trayViewController.view)
        print("tray VC \(trayViewController.view.frame)")
        print("trayView \(trayView.frame)")
        //trayViewController.didMoveToParentViewController(self)
//        homeViewController.didMoveToParentViewController(self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

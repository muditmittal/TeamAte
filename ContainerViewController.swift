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
        
        trayViewController = storyboard.instantiateViewControllerWithIdentifier("TrayViewController") as! TrayViewController
        homeViewController = storyboard.instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
        trayView.addSubview(trayViewController.view)
        homeView.addSubview(homeViewController.view)
        trayViewController.didMoveToParentViewController(self)
        homeViewController.didMoveToParentViewController(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

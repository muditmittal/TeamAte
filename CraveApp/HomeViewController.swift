//
//  HomeViewController.swift
//  CraveApp
//
//  Created by Jenn Leung on 3/2/16.
//  Copyright © 2016 Jenn Leung. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var settingsView: UIView!
    @IBOutlet weak var maskView: UIView!
    @IBOutlet weak var locationBar: UIView!
    @IBOutlet weak var backBar: UIView!
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var resultLocation: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        maskView.alpha = 0

        //setting of original trayView coordinates
        //var currentLocation = {{Phone Location}}
    }


//    @IBAction func onTapFood(sender: AnyObject) {
//        print("on tap")
//        self.trayView.alpha = 1
//        
//        UIView.animateWithDuration(0.4, delay: 0, options: [], animations: { () -> Void in
//            self.trayView.center.y = self.trayViewOriginalCenter.y
//            print("on animate")
//            }, completion: nil)
//    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

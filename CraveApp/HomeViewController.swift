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
    
    //var currentLocation = we can update this very frequently
    //var displayLocation = we can update this based on app logic

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeHomeView()

    }

    func initializeHomeView() {
        UIView.animateWithDuration(0.4, delay: 0, options: [], animations: { () -> Void in
            
            self.maskView.alpha = 0
            //self.displayLocation = currentLocation
            //self.userLocation = currentLocation

            }, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

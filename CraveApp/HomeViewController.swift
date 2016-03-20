//
//  HomeViewController.swift
//  CraveApp
//
//  Created by Jenn Leung on 3/2/16.
//  Copyright © 2016 Jenn Leung. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    weak var delegate: HomeVCDelegate?
    
    @IBOutlet weak var settingsView: UIView!
    @IBOutlet weak var maskView: UIView!
    @IBOutlet weak var backBar: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var currentLocation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.maskView.alpha = 0
        self.closeButton.alpha = 0
        self.currentLocation.textColor = UIColor.blackColor()
        self.currentLocation.font = self.currentLocation.font.fontWithSize(14)
    }

    @IBAction func onCloseButton(sender: AnyObject) {
        //prepareContainerforCardExit()
        print("onCLoseButton")
        delegate?.clickedCloseButton(self, clicked: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

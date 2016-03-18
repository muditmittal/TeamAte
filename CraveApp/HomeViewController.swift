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
        initializeHomeView()
    }

    @IBAction func onCloseButton(sender: AnyObject) {
        //prepareContainerforCardExit()
        print("onCLoseButton")
        delegate?.clickedCloseButton(self, clicked: true)
    }
    

    func initializeHomeView() {
        UIView.animateWithDuration(0.4, delay: 0, options: [], animations: { () -> Void in
            self.maskView.alpha = 0
            self.closeButton.alpha = 0
            self.currentLocation.textColor = UIColor.blackColor()
            self.currentLocation.font = self.currentLocation.font.fontWithSize(14)
            }, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

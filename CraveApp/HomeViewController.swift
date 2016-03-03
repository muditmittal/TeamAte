//
//  HomeViewController.swift
//  CraveApp
//
//  Created by Jenn Leung on 3/2/16.
//  Copyright © 2016 Jenn Leung. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var trayView: UIView!
    @IBOutlet var foodTextBox: UITextField!
    var trayViewOriginalCenter: CGPoint!
    var trayViewController: UIViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setting of original trayView coordinates
        trayViewOriginalCenter = CGPoint(x: trayView.center.x, y: trayView.center.y)
        
        //hiding until activated
        trayView.alpha = 0
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
//        trayViewController = storyboard.instantiateViewControllerWithIdentifier("TrayViewController") as!TrayViewController
//        trayView.addSubview(trayViewController.view)
//        trayViewController.didMoveToParentViewController(self)
        
        
    }

    @IBAction func onTapFood(sender: AnyObject) {
        print("on tap")
        self.trayView.alpha = 1
        
        UIView.animateWithDuration(0.4, delay: 0, options: [], animations: { () -> Void in
            self.trayView.center.y = self.trayViewOriginalCenter.y
            print("on animate")
            }, completion: nil)
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

//
//  ResultViewController.swift
//  CraveApp
//
//  Created by Mudit Mittal on 3/13/16.
//  Copyright © 2016 Jenn Leung. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var listingScrollView: UIScrollView!
    @IBOutlet weak var listingPhoto: UIImageView!
    @IBOutlet weak var listingInfo: UIView!
    @IBOutlet weak var listingName: UILabel!
    @IBOutlet weak var listingRating: UIView!
    @IBOutlet weak var listingPrice: UILabel!
    @IBOutlet weak var listingDistance: UILabel!
    @IBOutlet weak var listingDescription: UILabel!
    @IBOutlet weak var menuItem1: UILabel!
    @IBOutlet weak var menuItem2: UILabel!
    @IBOutlet weak var menuItem3: UILabel!
    
    var coverImageOffset = 180
    
    override func viewDidLoad() {

        super.viewDidLoad()
        listingScrollView.contentSize = CGSizeMake(300, 700)
        
    }

    @IBAction func onMenuButtonPress(sender: AnyObject) {

        
    }
    
    @IBAction func onDirectionButtonPress(sender: AnyObject) {

        
    }
    
    @IBAction func onDeliveryButtonPress(sender: AnyObject) {

        
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
 
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

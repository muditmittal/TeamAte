//
//  CardViewController.swift
//  CraveApp
//
//  Created by Jenn Leung on 3/10/16.
//  Copyright © 2016 Jenn Leung. All rights reserved.
//

import UIKit
//import NVActivityIndicatorView

class CardViewController: UIViewController, UIScrollViewDelegate {
    
    weak var delegate: CardVCDelegate?
    @IBOutlet var fullCardView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var resultPhoto: UIImageView!
    @IBOutlet weak var resultName: UILabel!
    @IBOutlet weak var resultRating: UIView!
    @IBOutlet weak var resultPrice: UILabel!
    @IBOutlet weak var resultDistance: UILabel!
    @IBOutlet weak var resultDescription: UILabel!
    
    @IBOutlet weak var resultMenu: UIView!
    @IBOutlet weak var menuItem1: UILabel!
    @IBOutlet weak var menuItem2: UILabel!
    @IBOutlet weak var menuItem3: UILabel!

    
    var trayViewController: UIViewController!
    var trayViewOriginalCenter: CGPoint!
    var viewOriginalCenter:CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.contentSize = CGSizeMake(300, 770)
        viewOriginalCenter = CGPoint(x: self.fullCardView.center.x, y: self.fullCardView.center.y)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // This method is called as the user scrolls
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
            }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView,
        willDecelerate decelerate: Bool) {
            // This method is called right as the user lifts their finger
            if scrollView.contentOffset.y <= -100 {
                delegate?.finishedDragCard(self, finished: true)
                print ("finished dragging")
                
            }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        // This method is called when the scrollview finally stops scrolling.
        
    }
    
    func handleLabels(restaurantName: String){
        resultName.text = restaurantName
    }
    func resetCardView(){
        fullCardView.center = viewOriginalCenter
        print ("reset")
    }
}

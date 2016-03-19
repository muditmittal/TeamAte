//
//  CardViewController.swift
//  CraveApp
//
//  Created by Jenn Leung on 3/10/16.
//  Copyright © 2016 Jenn Leung. All rights reserved.
//

import UIKit
import MapKit
//import NVActivityIndicatorView

class CardViewController: UIViewController, UIScrollViewDelegate, CLLocationManagerDelegate {
    
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
    
    // location variables
    var locationManager: CLLocationManager!
    let distanceSpan:Double = 500
    var locations: [CLLocation]!
    var lat: Double!
    var long: Double!
    
    // query string
    var query: String!
    
    // data array
    var data: [NSDictionary]!
    
    // implement location delegate
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var location = locations[0] as! CLLocation
        
//        lat = location.coordinate.latitude
//        long = location.coordinate.longitude
        lat = 37.763284
        long = -122.467662

        
        print("lat:", location.coordinate.latitude)
        print("long:", location.coordinate.longitude)
        
        //fetchVenues(searchQuery)
        
        locationManager.stopUpdatingLocation()
    }
    
    
    func handleLabels(searchQuery: String){
        resultName.text = searchQuery
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.contentSize = CGSizeMake(300, 770)
        viewOriginalCenter = CGPoint(x: self.fullCardView.center.x, y: self.fullCardView.center.y)
        
        data = []
        
        //SOMETHING HERE
        
        //query = searchString
        
        //print ("query:", searchString)
        
        // use location data
        
        if self.locationManager == nil {
            self.locationManager = CLLocationManager()
            
            self.locationManager!.delegate = self
            self.locationManager!.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager!.requestAlwaysAuthorization()
            // Don't send location updates with a distance smaller than 50 meters between them
            self.locationManager!.distanceFilter = 50
            self.locationManager!.startUpdatingLocation()
        }
    }
    
    func fetchVenues(searchQuery: String) {
        // venue information
        lat = 37.763284
        long = -122.467662
        let venueUrl = NSURL(string:"https://api.foursquare.com/v2/venues/search?ll=\(lat),\(long)&query=\(searchQuery)&client_id=XX13QSMNHNNKUAIXH2U5KUNNQ3AT1JY2AX5OCT4Q34ZXXUZM&client_secret=2UFHBTTZNFTGLE5DRBJ0MUXRWKLSPSI3TX3X4AVQKL4KPSF5&v=20160313")
        
        
        let venueRequest = NSURLRequest(URL: venueUrl!)
        
        print (venueUrl)
        
        NSURLConnection.sendAsynchronousRequest(venueRequest, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
            
            let venueJson = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
            
                            print(venueJson)
            
            
            // store the venueIds, venueLocations, and venueNames from the search API request
            
            self.data = venueJson.valueForKeyPath("response.venues") as! [NSDictionary]
            let venueIds = venueJson.valueForKeyPath("response.venues.id") as! [String]
            let venueNames = venueJson.valueForKeyPath("response.venues.name") as! [String]
            let venueLocations = venueJson.valueForKeyPath("response.venues.location") as! [NSDictionary]
            
            // store venueIds
            let venueId0 = venueIds[0]
            let venueId1 = venueIds[1]
            let venueId2 = venueIds[2]
            let venueId3 = venueIds[3]
            let venueId4 = venueIds[4]
            let venueId5 = venueIds[5]
            
            // store venueNames
            let venueName0 = venueNames[0]
            let venueName1 = venueNames[1]
            let venueName2 = venueNames[2]
            let venueName3 = venueNames[3]
            let venueName4 = venueNames[4]
            let venueName5 = venueNames[5]
            
            // fetch 6 menus, if count > 0, then store data
            // parse through menu items in menu; for menuItem in [menuItems] by string match
            
            // get menu information
            
            // menu information 0
            let menuUrl0 = NSURL(string:"https://api.foursquare.com/v2/venues/\(venueId0)/menu?client_id=XX13QSMNHNNKUAIXH2U5KUNNQ3AT1JY2AX5OCT4Q34ZXXUZM&client_secret=2UFHBTTZNFTGLE5DRBJ0MUXRWKLSPSI3TX3X4AVQKL4KPSF5&v=20160313")
            let menuRequest0 = NSURLRequest(URL: menuUrl0!)
            
            //                print (menuUrl0)
            
            NSURLConnection.sendAsynchronousRequest(menuRequest0, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                
                let menuJson0 = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                
                //                    print (menuJson0)
                
                // check if there is a menu object in JSON response
                
                let menuCount0 = menuJson0.valueForKeyPath("response.menu.menus.count") as! Int
                
                if menuCount0 > 0 {
                    
                    // if there is a menu, store the items in an array
                    
                    let menuItems = menuJson0.valueForKeyPath("response.menu.menus.items.entries.items.entries.items") as! NSArray
                    
                    // the outer array is [0] for some reason
                    
                    for var j = 0; j < menuItems[0].count; ++j {
                        
                        for var i = 0; i < menuItems[0][j].count; ++i {
                            
                            let itemDictionary = menuItems[0][j][i] as! NSDictionary
                            let itemName = itemDictionary.valueForKeyPath("name") as! String
                            var itemDescription = ""
                            
                            var itemString = ""
                            
                            // concatenate item name and item description stirng
                            if itemDictionary.valueForKeyPath("description") != nil {
                                itemDescription = itemDictionary.valueForKeyPath("description") as! String
                                itemString = itemName + itemDescription
                            }
                                
                            else {
                                itemString = itemName
                            }
                            
                            //                                print (itemName)
                            
                            // string match itemString for the query string
                            if itemString.lowercaseString.rangeOfString(searchQuery) != nil {
                                print ("menu0 query item: ", itemName, itemDescription)
                            }
                        }
                    }
                }
            }
            

        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // This method is called as the user scrolls
        
        print ("query:", searchString)
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
    
    
    
}

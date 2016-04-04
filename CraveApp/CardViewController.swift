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

var menuURL = ""
var venueLatitude: Double!
var venueLongitude: Double!
var matchedMenuItems: [String]!
class CardViewController: UIViewController, UIScrollViewDelegate, CLLocationManagerDelegate, ContainerVCDelegate {
    
    weak var delegate: CardVCDelegate?
    @IBOutlet var fullCardView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var resultPhoto: UIImageView!
    @IBOutlet weak var resultName: UILabel!
    @IBOutlet weak var resultRating: UIView!
    @IBOutlet weak var resultPrice: UILabel!
    @IBOutlet weak var resultDistance: UILabel!
    @IBOutlet weak var resultDescription: UILabel!
    @IBOutlet var resultPhone: UILabel!
    
    @IBOutlet weak var resultMenu: UIView!
    @IBOutlet weak var menuItem1: UILabel!
    @IBOutlet weak var menuItem2: UILabel!
    @IBOutlet weak var menuItem3: UILabel!
    @IBOutlet var menuItemHeader: UILabel!
    @IBOutlet var buttonView: UIView!
    var buttonView3objects: CGPoint!
    var buttonView2objects: CGPoint!
    var buttonView1object: CGPoint!
    var buttonView0objects: CGPoint!
    @IBOutlet var menuButton: UIButton!
    
    @IBOutlet var mapButton: UIButton!
    var viewOriginalCenter:CGPoint!
    
    // location variables
    var locationManager: CLLocationManager!
    let distanceSpan:Double = 500
    var locations: [CLLocation]!
    var lat: Double!
    var long: Double!
    
    //menu array
    //var matchedMenuItems: [String]!
    var matchedMenuDescriptions: [String]!
    
    // query string
    var query: String!
    
    // data array
    var data: [NSDictionary]!
    
    // implement location delegate
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var location = locations[0] as! CLLocation
        
//        lat = location.coordinate.latitude
//        long = location.coordinate.longitude
        lat = 37.7767902
        long = -122.4164055
        
        //print("lat:", location.coordinate.latitude)
        //print("long:", location.coordinate.longitude)
        print(lat,long)
        locationManager.stopUpdatingLocation()
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //adding action to See Menu Button
        menuButton.addTarget(self, action: "onFullMenuButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        scrollView.delegate = self
        scrollView.contentSize = CGSizeMake(320, 800)
        viewOriginalCenter = CGPoint(x: self.fullCardView.center.x, y: self.fullCardView.center.y)
        
        data = []
        
        //setting button view offsets
        /*buttonView3objects = CGPoint(x: buttonView.center.x, y: 400)
        buttonView2objects = CGPoint(x: buttonView.center.x, y: 325)
        buttonView1object = CGPoint(x: buttonView.center.x, y: 300)
        buttonView0objects = CGPoint(x: buttonView.center.x, y: 220)
        self.buttonView.center = self.buttonView3objects*/
        
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
    
    func setSearchString(searchQuery: String) {
        
    }
    
    
    func fetchVenues(searchQuery: String, success: () -> ()) {
        
        // venue information
        lat = 37.7767902
        long = -122.4164055

        
        //reset menu items
//        self.menuItem1.text = ""
//        self.menuItem2.text = ""
//        self.menuItem3.text = ""
        
        matchedMenuItems = []
        matchedMenuDescriptions = []
        let venueUrl = NSURL(string:"https://api.foursquare.com/v2/venues/search?ll=\(lat),\(long)&query=\(searchQuery)&client_id=XX13QSMNHNNKUAIXH2U5KUNNQ3AT1JY2AX5OCT4Q34ZXXUZM&client_secret=2UFHBTTZNFTGLE5DRBJ0MUXRWKLSPSI3TX3X4AVQKL4KPSF5&v=20160313")
        
        
        let venueRequest = NSURLRequest(URL: venueUrl!)
        
        NSURLConnection.sendAsynchronousRequest(venueRequest, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
            
            let venueJson = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
            
            // store the venueIds, venueLocations, and venueNames from the search API request
            
            self.data = venueJson.valueForKeyPath("response.venues") as! [NSDictionary]
            let venueIds = venueJson.valueForKeyPath("response.venues.id") as! [String]
            let venueNames = venueJson.valueForKeyPath("response.venues.name") as! [String]
            let venueLocations = venueJson.valueForKeyPath("response.venues.location") as! [NSDictionary]
            let venueDistances = venueJson.valueForKeyPath("response.venues.location.distance") as! NSArray
            let venueMobileUrl = venueJson.valueForKeyPath("response.venues.menu.mobileUrl") as! NSArray
            let venuePhoneNumber = venueJson.valueForKeyPath("response.venues.contact.formattedPhone") as! NSArray
            let venueLat = venueJson.valueForKeyPath("response.venues.location.lat") as! NSArray
            let venueLong = venueJson.valueForKeyPath("response.venues.location.lng") as! NSArray
            
            
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
            
            //store venueMobile URL
            //print(venueMobileUrl[0])
            
            self.resultName.text = venueNames[0]
            //trimming whitespace of venue to pass it in as hashtag
            var charSet = NSCharacterSet(charactersInString: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ").invertedSet
            var takeoutnonalpha = venueName0.componentsSeparatedByCharactersInSet(charSet).joinWithSeparator("")
            var trimmedVenueName = takeoutnonalpha.stringByReplacingOccurrencesOfString(" ", withString: "")
            print (trimmedVenueName)
            if (trimmedVenueName == "BurgerKing"){
                trimmedVenueName = "nomnomburger"
            } else if (trimmedVenueName.rangeOfString("TacoBell") != nil) {
                trimmedVenueName = "tacolicious"
            }
            print (trimmedVenueName)
            venueLatitude = Double(venueLat[0].description)
            venueLongitude = Double(venueLong[0].description)
            
            //calling instagram api
            
            print (venueDistances[0])
            
            
            
            if venueMobileUrl.count != 0 {
                menuURL = venueMobileUrl[0].description
            } else {
                
            }
            
            //setting phone number
//            if (venuePhoneNumber[0].description != "<null>"){
//                self.resultPhone.text = venuePhoneNumber[0].description
//                print (venuePhoneNumber[0].description)
//            } else {
//                self.resultPhone.alpha = 0
//            }
            
            
            let distanceInMeters = venueDistances[0] as! Double
            var distanceInMiles = (distanceInMeters / 1609.34)
            distanceInMiles = Double(round(10*distanceInMiles)/10)
            let distanceString = String(distanceInMiles)
            self.resultDistance.text = distanceString + " mi"
            // fetch 6 menus, if count > 0, then store data
            // parse through menu items in menu; for menuItem in [menuItems] by string match
            
            // get menu information
            
            
            // menu information 0
            let menuUrl0 = NSURL(string:"https://api.foursquare.com/v2/venues/\(venueId0)/menu?client_id=XX13QSMNHNNKUAIXH2U5KUNNQ3AT1JY2AX5OCT4Q34ZXXUZM&client_secret=2UFHBTTZNFTGLE5DRBJ0MUXRWKLSPSI3TX3X4AVQKL4KPSF5&v=20160313")
            let menuRequest0 = NSURLRequest(URL: menuUrl0!)
            
            
            NSURLConnection.sendAsynchronousRequest(menuRequest0, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                
                let menuJson0 = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                
                
                // check if there is a menu object in JSON response
                
                let menuCount0 = menuJson0.valueForKeyPath("response.menu.menus.count") as! Int
                //print(menuJson0)
                
                if menuCount0 > 0 {
                    // if there is a menu, store the items in an array
                    
                    let menuItems = menuJson0.valueForKeyPath("response.menu.menus.items.entries.items.entries.items") as! NSArray
                    
                    // the outer array is [0] for some reason
                    
                    for var j = 0; j < menuItems[0].count; ++j {
                        
                        for var i = 0; i < menuItems[0][j].count; ++i {
                            
                            let x = menuItems[0] as! [AnyObject]
                            let y = x[j] as! [NSDictionary]
                            let itemDictionary = y[i]
                            
                            //let itemDictionary = menuItems[0][j][i] as! NSDictionary
                            let itemName = itemDictionary.valueForKeyPath("name") as! String
                            var itemDescription = ""
                            
                            var itemString = ""
                            
                            // concatenate item name and item description stirng
                            if itemDictionary.valueForKeyPath("description") != nil {
                                itemDescription = itemDictionary.valueForKeyPath("description") as! String
                                //itemString = itemName + " " + itemDescription
                                itemString = itemName
                            }
                            
                            // string match itemString for the query string
//                            if itemString.lowercaseString.rangeOfString(searchQuery) != nil {
//                                matchedMenuItems.append(itemName)
//                                print("append \(matchedMenuItems)")
//                                
//                            }
                        }
                    }
                    
                }
                
            }
            
            // menu information 1
            let menuUrl1 = NSURL(string:"https://api.foursquare.com/v2/venues/\(venueId1)/menu?client_id=XX13QSMNHNNKUAIXH2U5KUNNQ3AT1JY2AX5OCT4Q34ZXXUZM&client_secret=2UFHBTTZNFTGLE5DRBJ0MUXRWKLSPSI3TX3X4AVQKL4KPSF5&v=20160313")
            let menuRequest1 = NSURLRequest(URL: menuUrl1!)
            
            NSURLConnection.sendAsynchronousRequest(menuRequest1, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                
                let menuJson1 = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                
                // check if there is a menu object in JSON response
                
                let menuCount1 = menuJson1.valueForKeyPath("response.menu.menus.count") as! Int
                //print(menuJson0)
                if menuCount1 > 0 {
                 
                    // if there is a menu, store the items in an array
                    
                    let menuItems = menuJson1.valueForKeyPath("response.menu.menus.items.entries.items.entries.items") as! NSArray
                    
                    // the outer array is [0] for some reason
                    
                    for var j = 0; j < menuItems[0].count; ++j {
                        
                        for var i = 0; i < menuItems[0][j].count; ++i {
                            
                            let x = menuItems[0] as! [AnyObject]
                            let y = x[j] as! [NSDictionary]
                            let itemDictionary = y[i]
                            
                            let itemName = itemDictionary.valueForKeyPath("name") as! String
                            var itemDescription = ""
                            var itemString = ""
                            
                            // concatenate item name and item description stirng
                            if itemDictionary.valueForKeyPath("description") != nil {
                                itemDescription = itemDictionary.valueForKeyPath("description") as! String
                                //itemString = itemName + " " + itemDescription
                                itemString = itemName
                            }
                            
                            
                            // print (itemName)
                            
                            // string match itemString for the query string
//                            if itemString.lowercaseString.rangeOfString(searchQuery) != nil {
//                                print ("menu1 query item: ", itemName)
//                                matchedMenuItems.append(itemName)
//                                print("append \(matchedMenuItems)")
//                                
//                            }
                        }
                    }
                    
                }
//                if matchedMenuItems.count == 3 {
//                    self.getAllMenuItems()
//                }
//                print(matchedMenuItems.count)
                
            }
            
            // menu information 2
            let menuUrl2 = NSURL(string:"https://api.foursquare.com/v2/venues/\(venueId2)/menu?client_id=XX13QSMNHNNKUAIXH2U5KUNNQ3AT1JY2AX5OCT4Q34ZXXUZM&client_secret=2UFHBTTZNFTGLE5DRBJ0MUXRWKLSPSI3TX3X4AVQKL4KPSF5&v=20160313")
            let menuRequest2 = NSURLRequest(URL: menuUrl2!)
            
            //print (menuUrl2)
            
            NSURLConnection.sendAsynchronousRequest(menuRequest2, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                
                let menuJson2 = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                
                //                    print (menuJson2)
                
                // check if there is a menu object in JSON response
                
                let menuCount2 = menuJson2.valueForKeyPath("response.menu.menus.count") as! Int
                //print(menuJson0)
                if menuCount2 > 0 {
                    //print("IN MENUCOUNT2")
                    // if there is a menu, store the items in an array
                    
                    let menuItems = menuJson2.valueForKeyPath("response.menu.menus.items.entries.items.entries.items") as! NSArray
                    
                    // the outer array is [0] for some reason
                    
                    for var j = 0; j < menuItems[0].count; ++j {
                        
                        for var i = 0; i < menuItems[0][j].count; ++i {
                            
                            let x = menuItems[0] as! [AnyObject]
                            let y = x[j] as! [NSDictionary]
                            let itemDictionary = y[i]
                            
                            let itemName = itemDictionary.valueForKeyPath("name") as! String
                            var itemDescription = ""
                            var itemString = ""
                            
                            // concatenate item name and item description stirng
                            if itemDictionary.valueForKeyPath("description") != nil {
                                itemDescription = itemDictionary.valueForKeyPath("description") as! String
                                //itemString = itemName + " " + itemDescription
                                itemString = itemName
                            }
                            
                            // print (itemName)
                            // string match itemString for the query string
//                            if itemString.lowercaseString.rangeOfString(searchQuery) != nil {
//                                print ("menu2 query item: ", itemName)
//                                matchedMenuItems.append(itemName)
//                                print("append \(matchedMenuItems)")
//                            }
//                            print(matchedMenuItems)
                        }
                    }
                    
                }
                
                //self.getAllMenuItems()
                self.getImage(trimmedVenueName, success: success)
                
            }
            
        }
    }
    
//    func getAllMenuItems(){
//        print("what \(matchedMenuItems.count)")
//        if matchedMenuItems.count != 0 {
//            
//            if matchedMenuItems.count > 2 {
//                self.menuItemHeader.alpha = 1
//                self.menuItem1.text = matchedMenuItems[0]
//                self.menuItem2.text = matchedMenuItems[1]
//                self.menuItem3.text = matchedMenuItems[2]
//                self.buttonView.center = self.buttonView3objects
//            } else if matchedMenuItems.count == 2 {
//                self.menuItem1.text = matchedMenuItems[0]
//                self.menuItem2.text = matchedMenuItems[1]
//                self.menuItemHeader.alpha = 1
//                self.buttonView.center = self.buttonView2objects
//                
//            } else if matchedMenuItems.count == 1 {
//                self.menuItem1.text = matchedMenuItems[0]
//                self.menuItemHeader.alpha = 1
//                self.buttonView.center = self.buttonView1object
//                //self.scrollView.contentSize = CGSizeMake(300, 658)
//            }
//        }
//        else if matchedMenuItems.count == 0 {
//            // if there is no menu
//            self.menuItemHeader.alpha = 0
//            //offsetting when favorites aren't available
//            self.buttonView.center = self.buttonView0objects
//            //self.scrollView.contentSize = CGSizeMake(300, 628)
//        }
//        
//    }
    @IBAction func onFullMenuButtonClick(sender: UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string: menuURL)!)
        print("in full menu")
    }
    
    
    
    @IBAction func onGetDirections(sender: UIButton) {
        var fallbackURL = "http://maps.google.com/maps?f=d&daddr=\(venueLatitude),\(venueLongitude)"
        if (UIApplication.sharedApplication().canOpenURL(NSURL(string:"comgooglemaps://")!)) {
            UIApplication.sharedApplication().openURL(NSURL(string:
                "comgooglemaps://?saddr=&daddr=\(venueLatitude),\(venueLongitude)&directionsmode=driving")!)
            
        } else {
            NSLog("Can't use comgooglemaps://");
            UIApplication.sharedApplication().openURL(NSURL(string:"\(fallbackURL)")!)
        }
        print("comgooglemaps://?saddr=&daddr=\(venueLatitude),\(venueLongitude)&directionsmode=driving")
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView,
        willDecelerate decelerate: Bool) {
            if scrollView.contentOffset.y <= -100 {
                
                delegate?.finishedDragCard(self, finished: true)
            }
    }
    func getImage(hashtag: String, success: () -> () ) {
        var access_token = "184004514.1677ed0.04d3543160674f6b87a47393cfe270da"
        let instaUrl = NSURL(string: "https://api.instagram.com/v1/tags/\(hashtag)/media/recent?access_token=\(access_token)")
        let request = NSURLRequest(URL: instaUrl!)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()){ (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
            let imageJson = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
            
            // let results = responseData["results"] as [String:AnyObject]
            // let imageURL = results["unescapedUrl"] as String
            let imageURL = imageJson.valueForKeyPath("data.images.standard_resolution.url") as! NSArray
            
            //if no image url, show default image
            if imageURL.count != 0 {
                //print (imageURL[0].description)
                let url = NSURL(string: imageURL[0].description)
                let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
                self.resultPhoto.image = UIImage(data: data!)
                //self.resultPhoto.contentMode = .ScaleAspectFill
            }
            success()
        }
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
    }
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


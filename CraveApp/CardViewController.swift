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
    @IBOutlet var menuButton: UIButton!
    @IBOutlet var buttonView: UIView!
    var buttonView3objects: CGPoint!
    var buttonView2objects: CGPoint!
    var buttonView1object: CGPoint!
    var buttonView0objects: CGPoint!
    
    
    var viewOriginalCenter:CGPoint!
    
    // location variables
    var locationManager: CLLocationManager!
    let distanceSpan:Double = 500
    var locations: [CLLocation]!
    var lat: Double!
    var long: Double!
    
    //menu array
    var venueName: String!
    var venues: [NSDictionary]!
    var venueIndex: Int = 0
    var venueLocations: [NSDictionary]!
    var venueDistances: NSArray!
    var venueMobileUrl: NSArray!
    var venuePhoneNumber: NSArray!
    var venueLat: NSArray!
    var venueLong: NSArray!
    var matchedMenuItems: [String]!
    var matchedMenuDescriptions: [String]!
    
    // query string
    var query: String!
    
    // data array
    var data: [NSDictionary]!
    
    // implement location delegate
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var location = locations[0] as! CLLocation
        
        lat = location.coordinate.latitude
        long = location.coordinate.longitude
        print("lat:", location.coordinate.latitude)
        print("long:", location.coordinate.longitude)
        
        locationManager.stopUpdatingLocation()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //adding action to See Menu Button
        menuButton.addTarget(self, action: "onFullMenuButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        scrollView.delegate = self
        scrollView.contentSize = CGSizeMake(300, 800)
        viewOriginalCenter = CGPoint(x: self.fullCardView.center.x, y: self.fullCardView.center.y)
        
        data = []
        
        //setting button view offsets
        buttonView3objects = CGPoint(x: buttonView.center.x, y: 365)
        buttonView2objects = CGPoint(x: buttonView.center.x, y: 325)
        buttonView1object = CGPoint(x: buttonView.center.x, y: 300)
        buttonView0objects = CGPoint(x: buttonView.center.x, y: 220)
        self.buttonView.center = self.buttonView3objects
        
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
    
//    func requestMenu(url: String) {
//        
//        
//        NSURLConnection.sendAsynchronousRequest(menuRequest0, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
//        
//    }
    
    func enumerateJSONToFindMenuItems(object:AnyObject, forKeyNamed named:String?, foodName: String) {
        if let dict = object as? NSDictionary {
            for (key, value) in dict {
                self.enumerateJSONToFindMenuItems(value, forKeyNamed: key as? String, foodName: foodName)
            }
        }
        else if let array = object as? NSArray {
            for value in array {
                self.enumerateJSONToFindMenuItems(value, forKeyNamed: nil, foodName: foodName)
            }
        }
        else {
            if named == "name" && object.lowercaseString.rangeOfString(foodName) != nil {
                self.matchedMenuItems.append(object as! String)
            }
            
        }
    }
    
    func requestMenu(menuRequest: NSURLRequest, searchQuery: String, success: () -> ()) {
        
        NSURLConnection.sendAsynchronousRequest(menuRequest, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
            
            let menuJson = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
            let menus = menuJson.valueForKeyPath("response.menu.menus") as! NSDictionary
            
            self.enumerateJSONToFindMenuItems(menus, forKeyNamed: "description", foodName: searchQuery)
            let venue = self.venues[self.venueIndex]
        
            print(self.matchedMenuItems)
            if self.matchedMenuItems.count < 3 {
                self.matchedMenuItems = []
                self.venueIndex = self.venueIndex + 1
                let currentVenueId = venue.valueForKey("id")
                self.requestMenu(self.buildMenuRequest(currentVenueId as! String), searchQuery: searchQuery, success: success)
            }
            else {
                self.venueName = venue.valueForKey("name") as! String
                self.matchedMenuItems = Array(self.matchedMenuItems[0..<3])
                self.finishVenue(success)
            }
        }
        
    }
    
    func buildMenuRequest(venueId: String) -> NSURLRequest {
        let menuUrl = NSURL(string:"https://api.foursquare.com/v2/venues/\(venueId)/menu?client_id=XX13QSMNHNNKUAIXH2U5KUNNQ3AT1JY2AX5OCT4Q34ZXXUZM&client_secret=2UFHBTTZNFTGLE5DRBJ0MUXRWKLSPSI3TX3X4AVQKL4KPSF5&v=20160313")
        return NSURLRequest(URL: menuUrl!)
    }
    
    func finishVenue(success: () -> ()) {
        
        self.resultName.text = self.venueName
        //trimming whitespace of venue to pass it in as hashtag
        var charSet = NSCharacterSet(charactersInString: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ").invertedSet
        var takeoutnonalpha = self.venueName.componentsSeparatedByCharactersInSet(charSet).joinWithSeparator("")
        let trimmedVenueName = takeoutnonalpha.stringByReplacingOccurrencesOfString(" ", withString: "")
        
        venueLatitude = Double(self.venueLat[0].description)
        venueLongitude = Double(self.venueLong[0].description)
        
        //calling instagram api
        
        print (self.venueDistances[0])
        
        //setting phone number
        self.resultPhone.text = self.venuePhoneNumber[0].description
        
        let distanceInMeters = self.venueDistances[0] as! Double
        var distanceInMiles = (distanceInMeters / 1609.34)
        distanceInMiles = Double(round(10*distanceInMiles)/10)
        let distanceString = String(distanceInMiles)
        self.resultDistance.text = distanceString + " mi"
        // fetch 6 menus, if count > 0, then store data
        // parse through menu items in menu; for menuItem in [menuItems] by string match
        
        // get menu information
        
        self.getImage(trimmedVenueName, success: success)
    }
    
    func fetchVenues(searchQuery: String, success: () -> ()) {
        
        // venue information
//        lat = 37.755308
//        long = -122.420972
        
        
        let venueUrl = NSURL(string:"https://api.foursquare.com/v2/venues/search?ll=\(lat),\(long)&query=\(searchQuery)&client_id=XX13QSMNHNNKUAIXH2U5KUNNQ3AT1JY2AX5OCT4Q34ZXXUZM&client_secret=2UFHBTTZNFTGLE5DRBJ0MUXRWKLSPSI3TX3X4AVQKL4KPSF5&v=20160313")
        
        //print(venueUrl)
        
        let venueRequest = NSURLRequest(URL: venueUrl!)
        
        NSURLConnection.sendAsynchronousRequest(venueRequest, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
            
            let venueJson = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
            
            //print("RESPONSE \(venueJson.valueForKeyPath("response.venues") as! [NSDictionary])")
            
            // store the venueIds, venueLocations, and venueNames from the search API request
            
            self.venues = venueJson.valueForKeyPath("response.venues") as! [NSDictionary]
            self.venueLocations = venueJson.valueForKeyPath("response.venues.location") as! [NSDictionary]
            self.venueDistances = venueJson.valueForKeyPath("response.venues.location.distance") as! NSArray
            self.venueMobileUrl = venueJson.valueForKeyPath("response.venues.menu.mobileUrl") as! NSArray
            self.venuePhoneNumber = venueJson.valueForKeyPath("response.venues.contact.formattedPhone") as! NSArray
            self.venueLat = venueJson.valueForKeyPath("response.venues.location.lat") as! NSArray
            self.venueLong = venueJson.valueForKeyPath("response.venues.location.lng") as! NSArray
            
            
            self.matchedMenuItems = []
            let venue = self.venues[self.venueIndex]
            
            self.venueName = venue.valueForKey("name") as! String
            
//            if venue.valueForKey("hasMenu") == nil {
//                print("skipping venue because no menu")
//                continue
//            }
            
            let venueId = self.venues[self.venueIndex].valueForKey("id")!
            let menuRequest = self.buildMenuRequest(venueId as! String)
            self.requestMenu(menuRequest, searchQuery: searchQuery, success: success)
            
            
            
        }
        
    }
    
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
    func getImage(trimmedVenueName: String, success: () -> () ) {
        var access_token = "184004514.1677ed0.04d3543160674f6b87a47393cfe270da"
        let instaUrl = NSURL(string: "https://api.instagram.com/v1/tags/\(trimmedVenueName)/media/recent?access_token=\(access_token)")
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
                self.resultPhoto.contentMode = .ScaleAspectFill
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

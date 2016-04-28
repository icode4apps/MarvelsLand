//
//  MarvelsListTableViewController.swift
//  MarvelsLand
//
//  Created by Joao Batista Rocha Jr. on 21/04/16.
//  Copyright © 2016 Joao Batista Rocha Jr. All rights reserved.
//
//  Project using third party cocoapods library SwiftyJSON to treat parsing data and MD5 hash 
//  for authentication into Marvels API


import UIKit
import Foundation
import SwiftyJSON

class MarvelsListTableViewController: UITableViewController, UISearchBarDelegate {
    
    var cell = UITableViewCell()
    var marvelsNames = [String]()
    var marvelsIds = [String]()
    var marvelsImagePath = [String]()
    var marvelsImageExt = [String]()
    var marvelsComics = [String]()
    var marvelsSeries = [String]()
    var marvelsStories = [String]()
    var marvelsEvents = [String]()
    var marvelsImageURL = [String]()
    var marvelsDescription = [String]()
    var marvelsLinksURLs = [[String]]()
    var detailLink = [String]()
    var wikiLink = [String]()
    var comicLink = [String]()
    
    var nameStartsWith = String()
    var imagesArray = [UIImage]()
    var imageView = UIImageView()
    var image = UIImage()
    var image2 = UIImage()
    
    var offset = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageTitle = UIImage(named: "marveltitle.png")
        navigationItem.titleView = UIImageView(image: imageTitle)
        
       
        //Checking Internet connection.
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
                
        isInternetOn()
        
    }
    
    //Going to the next page of results.
    @IBAction func nextPageButton(sender: AnyObject) {
        
        offset = offset + 30
        clearTableViewAndArrays()
        isInternetOn()
        self.imagesArray.removeAll()
        
    }

    @IBAction func goSearch(sender: AnyObject) {
        
        createSearchBar()
        
    }
    
    //Function to check Internet availability + going into searching.
    func isInternetOn() {
        
        if Reachability.isConnectedToNetwork() == true {
            
            getHeroes()
            
        } else {
          
            let uiAlert = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: UIAlertControllerStyle.Alert)
            self.presentViewController(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        }
        
    }
    
    //Connecting and authenticating into the API through credentials which includes a MD5 hash 
    //algorithm to combine the full authentication and then making the JSON parsing of data.
    func getHeroes() {
        
        let scriptUrl = "http://gateway.marvel.com:80/v1/public/characters?"
        let ts = NSDate().timeIntervalSince1970.description
        let privateKey = "MARVEL API PRIVATE KEY"
        let publicKey = "MARVEL API PUBLIC KEY"
        let hash = "\(ts)\(privateKey)\(publicKey)".md5()
        

        var urlWithParams = scriptUrl + "&orderBy=name" + "&limit=30" + "&offset=\(offset)" + "&ts=\(ts)" + "&apikey=\(publicKey)" + "&hash=\(hash)"

        if nameStartsWith != "" {
           
           urlWithParams = scriptUrl + "&nameStartsWith=\(nameStartsWith)" + "&orderBy=name" + "&limit=30" + "&offset=\(offset)" + "&ts=\(ts)" + "&apikey=\(publicKey)" + "&hash=\(hash)"
      }
        
        //Preparing parsing data from web server through 'GET' Method.
        let myUrl = NSURL(string: urlWithParams)
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: myUrl!)
        request.HTTPMethod = "GET"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        let task = session.dataTaskWithRequest(request) {
                                (
                                let data, let response, let error) in
                                guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                                    print("error")
                                    return
                                }
            
            self.clearTableViewAndArrays()
            let jsonData = JSON(data: data!)
            let Name = jsonData["data"]["results"]
           
            //Guarantee when there are NO results it is pushed an alert, and no errors occurs.
            if Name.count < 1 {
                let uiAlert = UIAlertController(title: "No results!", message: "Please, try again.", preferredStyle: UIAlertControllerStyle.Alert)
                self.presentViewController(uiAlert, animated: true, completion: nil)
                uiAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                self.clearTableViewAndArrays()
                return
            }
            
            //Guarantee of number of results is lower than number of cells.
            let numberOfRows = (Name.count - 1)
            
            
            //Manupulating JSON results and saving in arrays for showing on tableView.
            
            //Main loop for getting all the info from each Marvel character.
            for i in 0...numberOfRows {
                
                //Secondary loop for getting RELATED LINKS results of each Marvel character.
                for j in 0...(Int(Name[i]["urls"].count) - 1) {
                    
                    self.marvelsLinksURLs.append([Name[i]["urls"][j]["type"].stringValue, Name[i]["urls"][j]["url"].stringValue])
                    
                    switch (Name[i]["urls"][j]["type"]) {
                        
                        case "detail":
                        self.detailLink.append(Name[i]["urls"][j]["url"].stringValue)
                        
                        case "wiki":
                        self.wikiLink.append(Name[i]["urls"][j]["url"].stringValue)
                        
                        case "comiclink":
                        self.comicLink.append(Name[i]["urls"][j]["url"].stringValue)
                        
                    default: break
                        
                    }
                    
                }
                
                //Loop for checking and certifying that all the Related Links items keep the same index at the final arrays loading.
                if self.detailLink.endIndex == i {
                    self.detailLink.append("Not available")
                }
                
                if self.wikiLink.endIndex == i {
                    self.wikiLink.append("Not available")
                    
                }
                
                if self.comicLink.endIndex == i {
                    self.comicLink.append("Not available")
                }
            
                self.marvelsNames.append(Name[i]["name"].stringValue)
                self.marvelsDescription.append(Name[i]["description"].stringValue)
                self.marvelsIds.append(Name[i]["id"].stringValue)
                self.marvelsComics.append(Name[i]["resourceURI"].stringValue)
                self.marvelsSeries.append(Name[i]["series"].stringValue)
                self.marvelsStories.append(Name[i]["stories"].stringValue)
                self.marvelsEvents.append(Name[i]["events"].stringValue)
                self.marvelsImagePath.append(Name[i]["thumbnail"]["path"].stringValue)
                self.marvelsImageExt.append(Name[i]["thumbnail"]["extension"].stringValue)
                self.marvelsImageURL.append("\(Name[i]["thumbnail"]["path"].stringValue)" + "/portrait_xlarge." + "\(Name[i]["thumbnail"]["extension"].stringValue)")
                
                //Forcing delay of reloading tableView avoiding mismatch of arrays index and number of rows in tableView.
                if self.marvelsNames.count == Name.count {
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                    
                })
                    
                }
                
            }
            
            if error != nil
            {
                let uiAlert = UIAlertController(title: "Oops!", message: "An error occurred! Please, try again.", preferredStyle: UIAlertControllerStyle.Alert)
                self.presentViewController(uiAlert, animated: true, completion: nil)
                uiAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                
                return
            }
            
        }
        self.tableView.reloadData()
        task.resume()
        
    }
    
        //Creating searchBar
    
       func createSearchBar() {
        
        let marvelsSearchBar = UISearchBar()
        marvelsSearchBar.showsCancelButton = false
        marvelsSearchBar.placeholder = "Type here..."
        marvelsSearchBar.delegate = self
        self.navigationItem.titleView = marvelsSearchBar
        marvelsSearchBar.barStyle = UIBarStyle.Black
        marvelsSearchBar.keyboardAppearance = UIKeyboardAppearance.Dark
    
        let textFieldMarvelsSearchBar = marvelsSearchBar.valueForKey("searchField") as? UITextField
        textFieldMarvelsSearchBar!.textColor = UIColor(red: 0.480, green: 0.755, blue: 1.000, alpha: 1.000)
        
        marvelsSearchBar.becomeFirstResponder()
       
            }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        //Choosing between searching with starting letter or general searching.
        if searchText.isEmpty == true {
            nameStartsWith = ""
            getHeroes()
            
        } else {
            offset = 0
            let str = searchText
            nameStartsWith = str.stringByReplacingOccurrencesOfString("\\s", withString: "", options: NSStringCompareOptions.RegularExpressionSearch, range: nil)
            
            getHeroes()
            
            searchBar.resignFirstResponder()
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
                return
            })
            
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        let imageTitle = UIImage(named: "marveltitle.png")
        navigationItem.titleView = UIImageView(image: imageTitle)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        searchBar
        
           }
   
    //Showing results on tableView.
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
   
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return marvelsNames.count
    }
    
    //Getting the images of the Marvel characters.
    func getDataFromUrl(urL:NSURL, completion: ((data: NSData?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(urL) { (data, response, error) in
            completion(data: NSData(data: (data)!))
            }.resume()
    }
    
    
    //Cleaning all arrays and tableView for new searching.
    func clearTableViewAndArrays() {
        
        self.marvelsNames.removeAll(keepCapacity: false)
        self.marvelsIds.removeAll(keepCapacity: false)
        self.marvelsComics.removeAll(keepCapacity: false)
        self.marvelsSeries.removeAll(keepCapacity: false)
        self.marvelsEvents.removeAll(keepCapacity: false)
        self.marvelsStories.removeAll(keepCapacity: false)
        self.marvelsImagePath.removeAll(keepCapacity: false)
        self.marvelsImageExt.removeAll(keepCapacity: false)
        self.marvelsDescription.removeAll(keepCapacity: false)
        self.marvelsImageURL.removeAll(keepCapacity: false)
        self.detailLink.removeAll(keepCapacity: false)
        self.wikiLink.removeAll(keepCapacity: false)
        self.comicLink.removeAll(keepCapacity: false)
        self.marvelsLinksURLs.removeAll(keepCapacity: false)
        self.imagesArray.removeAll()
      
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
            return
        })
    
    }
   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MarvelsListTableViewCell
      
        //Showing 'next page button' only on the last cell.
        if indexPath.row == (marvelsNames.count - 1) && marvelsNames.count == 30 {
        cell.nextPageButton.hidden = false
            
        } else {
            cell.nextPageButton.hidden = true
        }
        
        //Downloading the images and showing on cells.
        func downloadImage(url:NSURL){
            
             getDataFromUrl(url) { data in
                dispatch_async(dispatch_get_main_queue()) {
                  
                    
                    self.image = UIImage(data: (data)!)!
                    if self.marvelsImageURL[indexPath.row].containsString("image_not_available") {
                        self.image = UIImage(named: "imagemarvelcover.png")!
                        
                    }
                    
                    self.imageView = UIImageView(frame: CGRectMake(0, 30, self.view.frame.size.width * 0.9, 120))
                    self.imageView.layer.masksToBounds = true
                    self.imageView.layer.backgroundColor = UIColor.whiteColor().CGColor
                    self.imageView.image = self.image
                    self.imagesArray.append(self.image)
                    cell.self.addSubview(self.imageView)
                    
                   
                }
                
            }
            
        }
        
        cell.marvelName.text = marvelsNames[indexPath.row]
        let imageURL = marvelsImageURL[indexPath.row]
        if let url = NSURL(string: "\(imageURL)") {
        
            downloadImage(url)
        }
        
        return cell
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
       
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    //Sending info from each Marvel character to Detail View when cell is tapped.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowMarvelsDetail" {
            
            if let indexPath = tableView.indexPathForSelectedRow {
            let destinationController = segue.destinationViewController as! MarvelsDetailViewController
                
                destinationController.imageDetail = imagesArray[indexPath.row]
                destinationController.strName = marvelsNames[indexPath.row]
                destinationController.strId = marvelsIds[indexPath.row]
                destinationController.strDescription = marvelsDescription[indexPath.row]
                destinationController.strDetailLink = detailLink[indexPath.row]
                destinationController.strWikiLink = wikiLink[indexPath.row]
                destinationController.strComicLink = comicLink[indexPath.row]
                
           }

        }
    }
    
}

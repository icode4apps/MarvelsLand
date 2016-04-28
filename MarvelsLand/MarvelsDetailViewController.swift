//
//  MarvelsDetailViewController.swift
//  MarvelsLand
//
//  Created by Joao Batista Rocha Jr. on 25/04/16.
//  Copyright © 2016 Joao Batista Rocha Jr. All rights reserved.
//

import UIKit
import Foundation

class MarvelsDetailViewController: UIViewController {
    
    @IBOutlet var MarvelsImageView: UIImageView!
    @IBOutlet var detailName: UILabel!
    @IBOutlet var detailId: UILabel!
    @IBOutlet var detailDescription: UILabel!
    @IBOutlet var detailLinkButton: UIButton!
    @IBOutlet var wikiLinkButton: UIButton!
    @IBOutlet var comicLinkButton: UIButton!
    @IBOutlet var relatedLinksIV: UIImageView!
    
    var imageDetail = UIImage()
    var strName = String()
    var strId = String()
    var strDescription = String()
    var strDetailLink = String()
    var strWikiLink = String()
    var strComicLink = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        relatedLinksIV.layer.backgroundColor = UIColor(red: 0.026, green: 0.138, blue: 0.180, alpha: 1.000).CGColor
        relatedLinksIV.layer.cornerRadius = 3
        relatedLinksIV.layer.borderWidth = 0.4
        relatedLinksIV.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        detailLinkButton.layer.cornerRadius = 3
        wikiLinkButton.layer.cornerRadius = 3
        comicLinkButton.layer.cornerRadius = 3
        
        detailLinkButton.layer.backgroundColor = UIColor(red: 0.096, green: 0.562, blue: 0.974, alpha: 1.000).CGColor
        wikiLinkButton.layer.backgroundColor = UIColor(red: 0.096, green: 0.562, blue: 0.974, alpha: 1.000).CGColor
        comicLinkButton.layer.backgroundColor = UIColor(red: 0.096, green: 0.562, blue: 0.974, alpha: 1.000).CGColor
        
        if strDetailLink == "Not available" {
            detailLinkButton.setTitle("Not available", forState: .Normal)
            detailLinkButton.setTitleColor(UIColor.redColor(), forState: .Normal)
            detailLinkButton.layer.backgroundColor = UIColor(red: 0.021, green: 0.125, blue: 0.216, alpha: 1.000).CGColor
        }
        
        if strWikiLink == "Not available" {
            wikiLinkButton.setTitle("Not available", forState: .Normal)
            wikiLinkButton.setTitleColor(UIColor.redColor(), forState: .Normal)
            wikiLinkButton.layer.backgroundColor = UIColor.clearColor().CGColor
        }
        
        if strComicLink == "Not available" {
            comicLinkButton.hidden = true
        }
        
        //Formatting navigation Bar
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        let imageTitle = UIImage(named: "marveltitle.png")
        navigationItem.titleView = UIImageView(image: imageTitle)
        
        MarvelsImageView.layer.borderWidth = 0.6
        MarvelsImageView.layer.borderColor = UIColor.whiteColor().CGColor
        
        detailDescription.textAlignment = NSTextAlignment.Justified
        
        MarvelsImageView.image = imageDetail
        detailName.text = strName
        detailId.text = strId
        
        if strDescription != "" {
        detailDescription.text = strDescription
            
        } else {
            
            detailDescription.text = "Not available."
        }
    }
    
    //'Related Links' section.
    @IBAction func detailLinkButton(sender: AnyObject) {
        
        if let url = NSURL(string: strDetailLink) {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func wikiLinkButton(sender: AnyObject) {
        
        if let url = NSURL(string: strWikiLink) {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func comicLinkButton(sender: AnyObject) {
        
        if let url = NSURL(string: strComicLink) {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
        
    }
 
}
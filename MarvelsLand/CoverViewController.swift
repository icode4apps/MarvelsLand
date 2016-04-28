//
//  CoverViewController.swift
//  MarvelsLand
//
//  Created by Joao Batista Rocha Jr. on 20/04/16.
//  Copyright © 2016 Joao Batista Rocha Jr. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON

class CoverViewController: UIViewController {
    
    @IBOutlet var loadMarvelsButton: UIButton!
    @IBAction func loadMarvelsButton(sender: AnyObject) {
        
                
    }
        override func viewDidLoad() {
        super.viewDidLoad()
            
            loadMarvelsButton.layer.cornerRadius = 50
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
   }

}
    

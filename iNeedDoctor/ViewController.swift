//
//  ViewController.swift
//  iNeedDoctor
//
//  Created by Kamil Gacek on 15.05.2018.
//  Copyright © 2018 Kamil Gacek. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    
    var chosenCity: City?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let city = chosenCity {
            city.name = "Krakow"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


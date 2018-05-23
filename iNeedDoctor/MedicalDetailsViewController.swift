//
//  DetailMedicalTableViewController.swift
//  iNeedDoctor
//
//  Created by Kamil Gacek on 16.05.2018.
//  Copyright © 2018 Kamil Gacek. All rights reserved.
//

import UIKit
import CoreData

class MedicalDetailsViewController: UITableViewController {

    var recievedMedPlace: NSManagedObject?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var postalAndCityLabel: UILabel!
    @IBOutlet weak var timeWhenOpenLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBAction func navigateBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func PerformCall(_ sender: UIButton) {
        if let url = URL(string: "telprompt:\(phoneLabel.text)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        updateLabels(medData: recievedMedPlace!)
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    

    func updateLabels(medData: NSManagedObject ){
        nameLabel.text = medData.value(forKey: "name") as! String
        streetLabel.text = medData.value(forKey: "street") as! String
        let postal = medData.value(forKey: "postalCode") as! String
        let city = medData.value(forKey: "city") as! String
        postalAndCityLabel.text = postal + " " + city
        timeWhenOpenLabel.text = medData.value(forKey: "openingHours") as! String
        let rate = medData.value(forKey: "rate")
        let rateAsString = NSString(format: "%.2f" ,rate as! CVarArg)
        rateLabel.text = rateAsString as! String
        phoneLabel.text = medData.value(forKey: "phone") as! String
    }

}

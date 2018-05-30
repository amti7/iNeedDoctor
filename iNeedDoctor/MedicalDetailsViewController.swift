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
    @IBOutlet weak var postalCodeLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var timeWhenOpenLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBAction func PerformCall(_ sender: UIButton) {
        if let url = URL(string: "telprompt:\(phoneLabel.text)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    @IBAction func navigateBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
      
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
    }
    
    func updateLabels(){
        //let rate = recievedMedPlace?.value(forKey: "rate")
        //let rateAsString = NSString(format: "%.2f" ,rate as! CVarArg)
        
        update(for: nameLabel, with: "name")
        update(for: streetLabel, with: "street")
        update(for: postalCodeLabel, with: "postalCode")
        update(for: cityLabel, with: "city")
        
       // update(for: rateLabel, with: "rate")
       
        
        
        
        print(recievedMedPlace?.value(forKey: "rate"))
        print((recievedMedPlace?.value(forKey: "rate")) as! CVarArg)
        print(type(of: recievedMedPlace?.value(forKey: "rate")))
        print(String(format: "%d.00", recievedMedPlace?.value(forKey: "rate") as! CVarArg))
        
        //print(NSString(format: "%.2f" ,(recievedMedPlace?.value(forKey: "rate")) as! CVarArg)
        
        
        //let rateText = NSString(format: "%.2f" ,(recievedMedPlace?.value(forKey: "rate")) as! CVarArg) as! String
        //print("** " + rateText)
        //rateLabel.text = rateText
        
        update(for: timeWhenOpenLabel, with: "openingHours")
        update(for: phoneLabel, with: "phone")
        
    }
    
    func update(for label: UILabel,with key: String) {
        label.text = recievedMedPlace?.value(forKey: key) as! String
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // let navigationController = segue.destination // as! UIViewController
        let controller = segue.destination as! MapViewController
        
        controller.placeLatitude = Double(recievedMedPlace?.value(forKey: "latitude") as! Float)
        controller.placeLongitude = Double(recievedMedPlace?.value(forKey: "longitude") as! Float)
        controller.name = recievedMedPlace?.value(forKey: "name") as! String
        controller.street = recievedMedPlace?.value(forKey: "street") as! String
        controller.cityLatitude = recievedMedPlace?.value(forKey: "cityLatitude") as! Double
        controller.cityLongitude = recievedMedPlace?.value(forKey: "cityLongitude") as! Double
    }
    
}

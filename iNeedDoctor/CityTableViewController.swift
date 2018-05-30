//
//  CityTableViewController.swift
//  iNeedDoctor
//
//  Created by Kamil Gacek on 25.05.2018.
//  Copyright © 2018 Kamil Gacek. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CityTableViewController: UITableViewController {
    
    var medPlaceArray: [NSManagedObject] = []
    var cityArray: [String] = []
    var selectedCity: String = ""
    
    var placeLatitude: Double?
    var placeLongitude: Double?
    var cityLatitude: Double?
    var cityLongitude: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMedicalEntity()
        fillCityArray()

        // saveMedicalEntity(city: "Warszawa", name: "Optiland", phone: "555 222 333", openingHours: "8-20", postalCode: "32-022", rate: 8.5, street: "ul. Krakowiaków", latitude: 21.282778, longitude: -157.829444)
        mockRandomMedicalEntity(called: "Luxmed", in: "Krakow")
        mockRandomMedicalEntity(called: "Scanmed", in: "Krakow")
        mockRandomMedicalEntity(called: "Medicoverwbawa", in: "Krakow")
        mockRandomMedicalEntity(called: "iDoctor", in: "Krakow")

//        mockRandomMedicalEntity(called: "MehMed", in: "Krakow")
//        mockRandomMedicalEntity(called: "MyMed", in: "Warszawa")
//        mockRandomMedicalEntity(called: "SeeYourDoctor", in: "Warszawa")
        
        //deleteMedicalEntity(with: "MedicalCenter")
        
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)
        let singleCity = cityArray[indexPath.row]
        cell.textLabel?.text = singleCity as! String
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityArray.count
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//    }
    
    func fillCityArray(){ // with array: [String]){ // Cannot use mutating member on immutable value: 'array' is a 'let' constant ??!!
        for medEntity in medPlaceArray {
            if !(cityArray.contains(medEntity.value(forKey: "city") as! String)){
                cityArray.append(medEntity.value(forKey: "city") as! String)
            }
        }
    }
    
    func loadMedicalEntity(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MedicalCenter")
        
        do {
            medPlaceArray = try managedContext.fetch(fetchRequest)
        } catch let error as NSError{
            print("Could not fetch \(error) \(error.userInfo)")
        }
    }
    
    func saveMedicalEntity(city: String, name: String, phone: String, openingHours: String, postalCode: String, rate: Float, street: String, latitude: Double, longitude: Double, cityLatitude: Double, cityLongitude: Double){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "MedicalCenter", in: managedContext)!
        let medicalEntity = NSManagedObject(entity: entity, insertInto: managedContext)
        medicalEntity.setValue(city, forKey: "city")
        medicalEntity.setValue(name, forKey: "name")
        medicalEntity.setValue(phone, forKey: "phone")
        medicalEntity.setValue(openingHours, forKey: "openingHours")
        medicalEntity.setValue(postalCode, forKey: "postalCode")
        medicalEntity.setValue(rate, forKey: "rate")
        medicalEntity.setValue(street, forKey: "street")
        medicalEntity.setValue(latitude, forKey: "latitude")
        medicalEntity.setValue(longitude, forKey: "longitude")
        medicalEntity.setValue(cityLatitude, forKey: "cityLatitude")
        medicalEntity.setValue(cityLongitude, forKey: "cityLongitude")
        do {
            try managedContext.save()
            medPlaceArray.append(medicalEntity)
        } catch let error as NSError {
            print("Could not save: \(error) \(error.userInfo)")
        }
    }
    
    func deleteMedicalEntity(with entity: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            try managedContext.execute(batchDeleteRequest)
        } catch let error as NSError {
            print("Could not delete: \(error) \(error.userInfo)")
        }
    }
    
    func mockRandomMedicalEntity(called name: String,in city: String){
        
        let randomPhone = String(arc4random_uniform(900) + 100) + "-" +  String(arc4random_uniform(900) + 100) + "-" + String(arc4random_uniform(900) + 100)
        let randomHours = String(arc4random_uniform(3) + 6)  + "-" + String(arc4random_uniform(3) + 16)
        let randomPostal =  String(arc4random_uniform(900) + 100) + "-" +  String(arc4random_uniform(100) + 10)
        let randomRate = Float(arc4random_uniform(7) + 3)
        let streetBucket = ["Adamusa","Braterska","Cykliczna","Dębowa","Elektyczna","Filipa","Gregoriańska","Hydrauliczna","Ikrowa","Jana","Klonowa"]
        let randomStreet =  "ul. " + streetBucket[Int(arc4random_uniform(10))] + " " + String(arc4random_uniform(100) + 10)
        
     
        
//        switch(name){
//        case "Luxmed":
//            placeLatitude =
//            placeLongitude =
//        case "Scanmed":
//            placeLatitude =
//            placeLongitude =
//        case "iMed":
//            placeLatitude =
//            placeLongitude =
//        case "Medicover":
//            placeLatitude =
//            placeLongitude =
//        }
        
        switch(city){
        case "Krakow":
            cityLatitude = 50.064650
            cityLongitude = 19.944979
            switch(name){
            case "Luxmed":
                placeLatitude = 50.070000
                placeLongitude = 19.944979
            case "Scanmed":
                placeLatitude = 50.064650
                placeLongitude = 19.950000
            case "iMed":
                placeLatitude = 50.070000
                placeLongitude = 19.950000
            case "Medicover":
                placeLatitude = 50.080000
                placeLongitude = 19.980000
            default:
                return
            }
        // TODO : places for other cities 
        case "Warsaw":
            cityLatitude = 52.229675
            cityLongitude = 21.012228
        case "Wroclaw":
            cityLatitude = 51.107885
            cityLongitude = 17.038537
        case "Gdansk":
            cityLatitude = 54.352025
            cityLongitude = 18.646638
        default:
            return
        }
        
        
        saveMedicalEntity(city: city, name: name, phone: randomPhone, openingHours: randomHours, postalCode: randomPostal, rate: Float(randomRate), street: randomStreet, latitude: placeLatitude!, longitude: placeLongitude!, cityLatitude: cityLatitude!, cityLongitude: cityLongitude!)
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedCity = cityArray[indexPath.row]
        return indexPath
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let navigationController = segue.destination as! UINavigationController
        let controller = navigationController.topViewController as! MedicalTableViewController
        
        for medEntity in medPlaceArray {
            if (medEntity.value(forKey: "city") as! String == selectedCity){
                controller.medPlacesArrayInCity.append(medEntity)
            }
        }
    }
}

//
//  MedicalCenterTableViewController.swift
//  iNeedDoctor
//
//  Created by Kamil Gacek on 16.05.2018.
//  Copyright © 2018 Kamil Gacek. All rights reserved.
//

import CoreData
import UIKit

class MedicalTableViewController: UITableViewController {

    var medPlaceArray: [NSManagedObject] = []
    var indexPathToPrepare: IndexPath = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //saveMedicalEntity(city: "Krakow", name: "LuxMedicum", phone: "12-4994411", openingHours: "9:00 - 22:00", postalCode: "30-800", rate: 7.6, street: "Błażewskiego 32", latitude: 21.282778, longitude: -157.829444)
        
       // deleteMedicalEntity(with: "MedicalCenter")
        
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
    
    func saveMedicalEntity(city: String, name: String, phone: String, openingHours: String, postalCode: String, rate: Float, street: String, latitude: Float, longitude: Float){
        
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
        medicalEntity.setValue(phone, forKey: "phone")
        medicalEntity.setValue(postalCode, forKey: "postalCode")
        medicalEntity.setValue(rate, forKey: "rate")
        medicalEntity.setValue(street, forKey: "street")
        medicalEntity.setValue(latitude, forKey: "latitude")
        medicalEntity.setValue(longitude, forKey: "longitude")
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medPlaceArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedCell", for: indexPath)
        let medCenter = medPlaceArray[indexPath.row]
        cell.textLabel?.text = medCenter.value(forKey: "name") as? String
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        indexPathToPrepare = indexPath
        return indexPath
     }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let controller = navigationController.topViewController as! MedicalDetailsViewController
        controller.recievedMedPlace = medPlaceArray[indexPathToPrepare.row]

    }
}

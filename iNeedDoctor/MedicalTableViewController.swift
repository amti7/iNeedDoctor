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

    var medPlacesArrayInCity: [NSManagedObject] = []
    var indexPathToPrepare: IndexPath = IndexPath()
    
    @IBAction func navigateBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medPlacesArrayInCity.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedCell", for: indexPath)
        let medCenter = medPlacesArrayInCity[indexPath.row]
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
        controller.recievedMedPlace = medPlacesArrayInCity[indexPathToPrepare.row]

    }
}

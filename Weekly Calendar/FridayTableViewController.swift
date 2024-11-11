//
//  FridayTableViewController.swift
//  Weekly Calendar
//
//  Created by Student on 8/16/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit
import CoreData

class FridayTableViewController: UITableViewController {
    
    let swiftyData = CoreDataModule(entityName: "Friday", xcDataModelID: "Model")
    var myEvents = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myEvents = swiftyData.retrieveAndSort(byKey: "timeStart", ascending: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        myEvents = swiftyData.retrieveAndSort(byKey: "timeStart", ascending: true)
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myEvents.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let object = myEvents[indexPath.row]
        
        cell.textLabel?.text = object.value(forKey: "title") as? String
        cell.detailTextLabel?.text = object.value(forKey: "timeStart") as? String
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "PreviewController") as! PreviewController
        
        let object = myEvents[indexPath.row]
        
        vc.day = object.value(forKey: "day") as? String
        vc.eventDetails = object.value(forKey: "event") as? String
        vc.eventTitle = object.value(forKey: "title") as? String
        vc.startTime = object.value(forKey: "timeStart") as? String
        vc.endTime = object.value(forKey: "timeEnd") as? String
        
        
        show(vc, sender: self)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.alpha = 0
        let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
        cell.layer.transform = transform
        
        UIView.animate(withDuration: 0.5) {
            cell.alpha = 1.0
            cell.layer.transform = CATransform3DIdentity
        }
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            swiftyData.remove(object: myEvents, index: indexPath.row)
            myEvents.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
        
    }
}



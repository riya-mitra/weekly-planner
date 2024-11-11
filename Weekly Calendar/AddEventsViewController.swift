//
//  AddEventsViewController.swift
//  Weekly Calendar
//
//  Created by Student on 8/16/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit
import CoreData

class AddEventsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    
    @IBOutlet var eventTitleTextField: UITextField!
    @IBOutlet var eventDescriptionView: UITextView!
    @IBOutlet var timeStartPicker: UIDatePicker!
    @IBOutlet var timeEndPicker: UIDatePicker!
    @IBOutlet var dayPickerView: UIPickerView!
    
    let days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    var event: String?
    var eventTitle: String?
    var day = "Sunday"
    var timeStart: String?
    var timeEnd: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dayPickerView.delegate = self
        dayPickerView.dataSource = self
        
        title = "Add Event"
        
        if event != nil && eventTitle != nil  {
            title = eventTitle!
            eventDescriptionView.text = event!
            
            
        }
        
        let borderColor : UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        
        eventDescriptionView.layer.borderWidth = 1
        eventDescriptionView.layer.borderColor = borderColor.cgColor
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return days.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return days[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        day = days[row]
        
    }
    
    @IBAction func saveEvent() {
        let swiftyData = CoreDataModule(entityName: day, xcDataModelID: "Model")

        
        let eventTitle = eventTitleTextField.text!
        let event = self.eventDescriptionView.text!
        timeStart = DateMods.formatDate(date: timeStartPicker.date)
        timeEnd = DateMods.formatDate(date: timeEndPicker.date)
        
        swiftyData.push(values: [eventTitle, event, timeStart!, timeEnd!, day], keys: ["title", "event", "timeStart", "timeEnd", "day"])
        dismiss(animated: true, completion: nil)

    }
    
    @IBAction func backButton() {
        dismiss(animated: true, completion: nil)
    }
    
    
}

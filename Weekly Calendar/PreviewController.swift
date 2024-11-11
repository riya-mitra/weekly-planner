//
//  File.swift
//  Weekly Calendar
//
//  Created by Student on 8/17/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class PreviewController: UIViewController {
    
    var eventTitle: String!
    var eventDetails: String!
    var startTime: String!
    var endTime: String!
    var day: String!
    
    @IBOutlet var myDayLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var eventTextView: UITextView!
    @IBOutlet var titleLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = eventTitle
        titleLabel.text = eventTitle
        myDayLabel.text = day
        timeLabel.text = startTime + " - " + endTime
        eventTextView.text = eventDetails
   
        let borderColor : UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        
        eventTextView.layer.borderWidth = 1.5
        eventTextView.layer.borderColor = borderColor.cgColor
       
        
        
        
        
        
    }
    
}


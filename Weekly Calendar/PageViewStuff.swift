//
//  ViewController.swift
//  ScrollTableView
//
//  Created by Cyril Garcia on 8/16/18.
//  Copyright © 2018 Cyril Garcia. All rights reserved.
//

import UIKit
import CoreData

class PageViewStuff: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var orderedViewController = [UIViewController]()
    var viewControllerID = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let calendar = Calendar.current
        let weekOfYear = calendar.component(.weekOfYear, from: Date.init(timeIntervalSinceNow: 0))
        
        let weekCount = UserDefaults.standard.integer(forKey: "WeekCount")
        
        if weekOfYear != weekCount {
            for id in viewControllerID {
              let swiftyCoreData = CoreDataModule(entityName: id, xcDataModelID: "Model")
                swiftyCoreData.removeAll()
            }
        }
        
        
        UserDefaults.standard.set(weekOfYear, forKey: "WeekCount")
        
        
        createViewController()
        
        self.dataSource = self
        
        if let firstViewController = orderedViewController.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
        // Do any additional setup after loading the view.
    }
    
    func createViewController() {
        for id in viewControllerID {
            orderedViewController.append(newVC(identifier: id))
        }
    }
    
    func newVC(identifier: String) -> UIViewController {
        return self.storyboard!.instantiateViewController(withIdentifier:identifier)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let vcIndex = orderedViewController.index(of: viewController)!
        let lastIndex = vcIndex - 1
        
        guard lastIndex >= 0 else {
            return orderedViewController.last
        }
        
        guard orderedViewController.count > lastIndex else {
            return nil
        }
        
        return orderedViewController[lastIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        
        let vcIndex = orderedViewController.index(of: viewController)!
        let nextIndex = vcIndex + 1
        
        
        guard orderedViewController.count != nextIndex else {
            return orderedViewController.first
        }
        
        guard orderedViewController.count > nextIndex else {
            return nil
        }
        
        return orderedViewController[nextIndex]
    }
    
    
    
    
}

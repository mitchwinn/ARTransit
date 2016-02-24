//
//  AugmentedViewController.swift
//  ARTransit
//
//  Created by Mitch Winn on 2/24/16.
//  Copyright © 2016 Mitch Winn. All rights reserved.
//

import UIKit
import CoreLocation

class AugmentedViewController: UIViewController, ARDataSource {
    var stops = [Stop]()
    var annotatedStops = [ARStopAnnotation]()
    
    override func viewDidLoad() {
        // Check if device has hardware needed for augmented reality.
        let result = ARViewController.createCaptureSession()
        if result.error != nil
        {
            let message = result.error?.userInfo["description"] as? String
            
            //UIAlertView(title: "Error", message: message, delegate: nil, cancelButtonTitle: "Close")
            let alertView = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
            self.presentViewController(alertView, animated: true, completion: nil)
            return
        }
        
        // Create annotations.
        for stop in self.stops {
            annotatedStops.append(ARStopAnnotation(stop: stop))
        }
        
        // Create ARViewController with annotations.
        let arViewController = ARViewController()
        arViewController.debugEnabled = true
        arViewController.dataSource = self
        arViewController.setAnnotations(annotatedStops)
        self.presentViewController(arViewController, animated: true, completion: nil)
    }
    
    /// This method is called by ARViewController, make sure to set dataSource property.
    func ar(arViewController: ARViewController, viewForAnnotation: ARAnnotation) -> ARAnnotationView
    {
        // Annotation views should be lightweight views, try to avoid xibs and autolayout all together.
        let annotationView = ARStopAnnotationView()
        annotationView.frame = CGRect(x: 0,y: 0,width: 150,height: 50)
        return annotationView;
    }
}

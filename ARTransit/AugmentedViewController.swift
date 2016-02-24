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
    /// This method is called by ARViewController, make sure to set dataSource property.
    func ar(arViewController: ARViewController, viewForAnnotation: ARAnnotation) -> ARAnnotationView
    {
        // Annotation views should be lightweight views, try to avoid xibs and autolayout all together.
        let annotationView = ARStopAnnotationView()
        annotationView.frame = CGRect(x: 0,y: 0,width: 150,height: 50)
        return annotationView;
    }
}

//
//  ViewController.swift
//  ARTransit
//
//  Created by Mitch Winn on 2/21/16.
//  Copyright © 2016 Mitch Winn. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    var locationManager: CLLocationManager!
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // Setup location manager.
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLocation = locations.last

        let accuracy = lastLocation?.horizontalAccuracy
        print("Recieved location \(lastLocation) with accuracy \(accuracy)")

        if (accuracy < 100.0) {
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegionMake((lastLocation?.coordinate)!, span)

            mapView.setRegion(region, animated: true)

            // Call the model for stop data.
            TrimetAPI.sharedInstance.getStops(lastLocation!, radius: 300, completionBlock: {
                (let stops) in
                print("\(stops)")

                for stop in stops {
                    // Create a new annotation.
                    let stopAnnotation = StopAnnotation(stop: stop)

                    // Add the annotation to the map.
                    self.mapView.addAnnotation(stopAnnotation)
                }
            })

            manager.stopUpdatingLocation()
        }
    }
}


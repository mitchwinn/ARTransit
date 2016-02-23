//
//  StopAnnotation.swift
//  ARTransit
//
//  Created by Mitch Winn on 2/22/16.
//  Copyright © 2016 Mitch Winn. All rights reserved.
//

import Foundation
import MapKit

class StopAnnotation : NSObject, MKAnnotation {
    var stop: Stop

    @objc var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: stop.latitiude, longitude: stop.longitude)
    }

    @objc var title: String? {
        return stop.description
    }

    init(stop: Stop) {
        self.stop = stop
    }
}
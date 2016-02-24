//
//  ARStopAnnotation.swift
//  ARTransit
//
//  Created by Mitch Winn on 2/22/16.
//  Copyright © 2016 Mitch Winn. All rights reserved.
//

import Foundation
import MapKit

class ARStopAnnotation : ARAnnotation {
    var stop: Stop

    init(stop: Stop) {
        self.stop = stop

        super.init()

        self.title = stop.description
        self.location = CLLocation(latitude: stop.latitiude, longitude: stop.longitude)
    }
    
}
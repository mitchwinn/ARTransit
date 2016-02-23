//
//  Stop.swift
//  ARTransit
//
//  Created by Mitch Winn on 2/21/16.
//  Copyright © 2016 Mitch Winn. All rights reserved.
//

import Foundation

struct Stop {
    var description: String
    var latitiude: Double
    var longitude: Double
    var locationId: Int
    var direction: String

    init(stopLocationData: [String:AnyObject]) {
        self.description = stopLocationData["desc"] as! String
        self.latitiude = stopLocationData["lat"] as! Double
        self.longitude = stopLocationData["lng"] as! Double
        self.locationId = stopLocationData["locid"] as! Int
        self.direction = stopLocationData["dir"] as! String
    }
}
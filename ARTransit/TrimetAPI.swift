//
//  TrimetAPI.swift
//  ARTransit
//
//  Created by Mitch Winn on 2/21/16.
//  Copyright © 2016 Mitch Winn. All rights reserved.
//

import Foundation
import MapKit
import Alamofire

struct TrimetAPI {
    // MARK: - Instance Variables
    static let sharedInstance = TrimetAPI()
    private init() {}
    let appID = ""
    let apiURLV1 = "https://developer.trimet.org/ws/v1/"
    let apiURLV2 = "https://developer.trimet.org/ws/v2/"

    // Call the trimet api to get stops around a certain location and radius.
    func getStops(location: CLLocation, radius: Int, completionBlock:(([Stop])->())?) {
        let latlong = "\(location.coordinate.latitude),\(location.coordinate.longitude)"
        var stops = [Stop]()

        Alamofire.request(.GET, apiURLV1 + "stops",
                          parameters: ["appID": appID,
                                       "ll": latlong,
                                       "meters": radius,
                                       "json": "true"])
                 .responseJSON { response in
                    debugPrint(response.request)  // original URL request
                    debugPrint(response.response) // URL response
                    debugPrint(response.data)     // server data
                    debugPrint(response.result)   // result of response serialization

                    if let JSON = response.result.value as! [String:AnyObject]?,
                        resultSet = JSON["resultSet"] as! [String:AnyObject]? {
                            for location in resultSet["location"] as! [[String:AnyObject]] {
                                // Add the new location from the api to an array of stops.
                                stops.append(Stop(stopLocationData: location))
                            }
                    }

                    if (completionBlock != nil) {
                        completionBlock!(stops)
                    }
                 }
    }
}
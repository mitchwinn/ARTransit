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

class TrimetAPI {
    // MARK: - Instance Variables
    static let sharedInstance = TrimetAPI()
    private init() {}
    let appID = "D96D0407AC5A003B1CD75521D"
    let apiURL = "https://developer.trimet.org/ws/v1/"

    // Call the trimet api to get stops around a certain location and radius.
    func getStops(location: CLLocation, radius: Int, completionBlock:(([Stop])->())?) {
        let latlong = "\(location.coordinate.latitude),\(location.coordinate.longitude)".stringByRemovingPercentEncoding!
        var stops = [Stop]()

        Alamofire.request(.GET, apiURL + "stops",
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
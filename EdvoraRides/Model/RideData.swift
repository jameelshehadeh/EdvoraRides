//
//  RideData.swift
//  EdvoraRides
//
//  Created by Jameel Shehadeh on 01/04/2022.
//

import Foundation

struct RideData : Decodable , Identifiable {
    
    let id : Int
    let origin_station_code : Int
    let station_path : [Int]
    let destination_station_code : Int
    let date : String
    let map_url : String
    let state : String
    let city : String
    
    
    var formattedDate : String {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "M/d/y h:m a"
        
        guard let date = dateFormatter.date(from: date) else {
            return "N/A"
        }
        
        dateFormatter.dateFormat = "d MMM"
        let formattedDate = dateFormatter.string(from: date)
        
        return formattedDate
    }
    
}

//
//  NetworkManager.swift
//  EdvoraRides
//
//  Created by Jameel Shehadeh on 01/04/2022.
//

import Foundation
import UIKit
import SwiftUI

class NetworkManager : ObservableObject {
    
    @Published var ridePosts = [RideData]()
    
    var ridesType = "nearest"
    
    func fetchData(with stationCode : Int){
        
        DispatchQueue.main.async {
            self.ridePosts = []
        }
        
        
        guard let url = URL(string: "https://assessment.api.vweb.app/rides") else {return}
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data , _ , error in
            guard error == nil , let data = data else {
                print("error")
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let results = try decoder.decode([RideData].self, from: data)
                
                
                guard let results = self.fetchRides(rides: results, stationCode: stationCode) else {
                    return
                }
               
                DispatchQueue.main.async {
                    self.ridePosts = results
                }
            }
            
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    
    func getUserInfo() {
        
        guard let url = URL(string: "https://assessment.api.vweb.app/user") else {return}
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data , _ , error in
            
            guard error == nil , let data = data else {
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let results = try decoder.decode(UserInfo.self, from: data)
                // got user data successfully
                let stationCode = results.station_code
                let userName = results.name
                let imageUrl = results.url
                let user = UserInfo(station_code: stationCode, name: userName, url: imageUrl)
                self.fetchData(with: user.station_code)
            }
            catch {
                print(error)
            }
        }
        task.resume()

    }
    
    func fetchRides(rides : [RideData] , stationCode : Int)->[RideData]? {
        
        switch ridesType {

        case "nearest" :
            //Sorting rides based on their maximum value of each ride in in station_path array that is greater than the station code
            
            print("nearest")
            
            DispatchQueue.main.async {
                self.ridePosts = []
            }
            
            

            for ride in rides {
                
            }

            return ridePosts
            
        case "upcoming" :
            print("UPCOMING")

            return ridePosts
        default :
            print("error")
            return nil
            
        }
    }
}

enum typeOfRides {
    case nearest
    case upcoming
    case past
}

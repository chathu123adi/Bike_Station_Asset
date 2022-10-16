//
//  StationViewModel.swift
//  Bike_Station_Asset
//
//  Created by chathurnaga Adikari on 2022-10-13.
//

import Foundation

class StationViewModel: ObservableObject {
    var apiUrl = "http://www.poznan.pl/mim/plan/map_service.html?mtype=pub_transport&co=stacje_rowerowe"
    
    @Published var stationsData = [BikeStation]()
    
    func fetchStationData () {
        
        var json: AnyObject?
        
        guard let url = URL(string: apiUrl) else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
//        request.httpBody =
        
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue.main.async {
            let task = URLSession.shared.dataTask(with: request) { data, reponse, error in
                guard let data = data, error == nil else {return}
                
                do {
                    json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? NSDictionary
                    
                    var features =  json?["features"] as! [[String: Any]]
                    
                    for (index, value) in features.enumerated() {
                            var property = value["properties"] as! [String : Any]
                        var geometry = value["geometry"] as! [String : Any]
                        
                        let cordinate = geometry["coordinates"] as? [Double]
                        
                        var id = Int(value["id"] as! String) ?? 0
                            
                            let stationName = property["label"] as! String
                            let availableBike = Int(property["bikes"] as! String) ?? 0
                            let availablePlaces = Int(property["bike_racks"] as! String) ?? 0
                            let updated = property["updated"] as! String
                            let freeRack = Int(property["free_racks"] as! String) ?? 0
                        
                        let longitude = cordinate?[0] as! Double
                        let latitude = cordinate?[1] as! Double
                        
                        self.stationsData.append(BikeStation(id: id, stationName: stationName, totalBikeRack: availablePlaces, freeRacks: freeRack, availableBike: availableBike, lastUpdate: updated, longitute: longitude, latitude: latitude))
                    }
                    
                }catch{
                    print("Oopz not good json formatted response")
                    group.leave()
                }
                
            }
            task.resume()
        }
        
    }
}

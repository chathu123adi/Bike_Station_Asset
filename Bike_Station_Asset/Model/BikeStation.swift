//
//  BikeStation.swift
//  Bike_Station_Asset
//
//  Created by Chathuranga Adikari on 2022-10-13.
//

import Foundation

struct BikeStation: Identifiable, Decodable {
    var id: Int // id
    var stationName: String // label
    var totalBikeRack: Int // bike_racks
    var freeRacks: Int // free_racks
    var lastUpdate: String // updated
}

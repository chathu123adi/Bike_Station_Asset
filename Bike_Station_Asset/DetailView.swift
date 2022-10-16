//
//  DetailView.swift
//  Bike_Station_Asset
//
//  Created by vinoj randika on 2022-10-16.
//

import SwiftUI
import MapKit

struct DetailView: View {
    
    var stationObject: BikeStation
    
    @ObservedObject private var locationManger =  LocationManager()
    
    var body: some View {
        
        let currentCordinate = self.locationManger.location != nil ? self.locationManger.location!.coordinate: CLLocationCoordinate2D()
        
        let loc1 = CLLocation(latitude: currentCordinate.latitude, longitude: currentCordinate.longitude)
        
        let loc2 = CLLocation(latitude: stationObject.latitude, longitude: stationObject.longitute)
        
        var distance = loc1.distance(from: loc2)
        var roundeddistance = Int(distance.rounded())
        
        let longitude = stationObject.longitute
        let latitude = stationObject.latitude
        
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                VStack {
                    VStack {
                        ZStack {
                            Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude:longitude), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))), interactionModes: [])
                            
                            HStack{
                                Image("bike")
                                Text("\(stationObject.availableBike)")
                                    .font(.system(size: 25, weight: .bold, design: .default))
                                    .foregroundColor(.green)
                                    .padding()
                                    .cornerRadius(10)
                            }
                        }
                    }
                    VStack {
                        VStack(alignment: .leading) {
                            Text("047 ofiar dabaia").font(.system(size: 25, weight: .bold, design: .default))
//                                    .frame(alignment: .leading)
                            
                            Text("600m - Bike Station").font(.system(size: 15, weight: .light, design: .default))
                        }.frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            alignment: .topLeading
                          )
                    }
                    .padding()
                    
                    HStack(spacing: 40) {
                        VStack {
                            Image("bike").scaledToFit()
                            Text("Available Bikes").font(.system(size: 15, weight: .light, design: .default))
                            Text("7").font(.system(size: 45, weight: .bold, design: .default))
                                .foregroundColor(Color.green)
                        }
                        VStack {
                            Image("lock").scaledToFit()
                            Text("Available Places").font(.system(size: 15, weight: .light, design: .default))
                            Text("20").font(.system(size: 45, weight: .bold, design: .default))
                                .foregroundColor(Color.black)
                        }
                    }
                    Spacer()
                }
                .background(Color.white)
            }.foregroundColor(Color.black)
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(stationObject: BikeStation(id: 1, stationName: "1", totalBikeRack: 1, freeRacks: 1, availableBike: 1, lastUpdate: "1", longitute: 1, latitude: 1))
    }
}

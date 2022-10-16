//
//  ContentView.swift
//  Bike_Station_Asset
//
//  Created by chathurnaga Adikari on 2022-10-13.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = StationViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white //.edgesIgnoringSafeArea(.all) //.ignoresSafeArea()
                ScrollView {
                    ForEach(viewModel.stationsData) { item in // start loop
                        NavigationLink (destination: DetailView(stationObject: item) ){
                            VStack(spacing: 30) {
                                VStack(alignment: .leading) {
                                    Text("\(item.id) \(item.stationName)").font(.system(size: 25, weight: .bold, design: .default))
    //                                    .frame(alignment: .leading)
                                    
                                    Text("\(viewModel.findDistance(longitute: item.longitute, Latitute: item.latitude)) - Bike Station").font(.system(size: 15, weight: .light, design: .default))
                                }.frame(
                                    minWidth: 0,
                                    maxWidth: .infinity,
                                    alignment: .topLeading
                                  )
                                
                                HStack(spacing: 40) {
                                    VStack {
                                        Image("bike").scaledToFit()
                                        Text("Available Bikes").font(.system(size: 15, weight: .light, design: .default))
                                        Text("\(item.availableBike)").font(.system(size: 45, weight: .bold, design: .default))
                                            .foregroundColor(Color.green)
                                    }
                                    VStack {
                                        Image("lock").scaledToFit()
                                        Text("Available Places").font(.system(size: 15, weight: .light, design: .default))
                                        Text("\(item.totalBikeRack)").font(.system(size: 45, weight: .bold, design: .default))
                                            .foregroundColor(Color.black)
                                    }
                                }

                            }.frame(
                                minWidth: 0,
                                maxWidth: .infinity,
                                alignment: .center
                              )
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color.white).shadow(radius: 15))
                            .padding()
                        }
                    } // endloop
                }
                .background(
                    Color.white)
                    .foregroundColor(Color.black)
                    .navigationBarTitle("", displayMode: .inline)
                                .background(NavigationConfigurator { nc in
                                    nc.navigationBar.barTintColor = .black
                                    nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
                                })
            }

        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: viewModel.fetchStationData)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }

}

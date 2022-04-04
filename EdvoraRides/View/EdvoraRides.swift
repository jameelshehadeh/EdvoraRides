//
//  EdvoraRides.swift
//  EdvoraRides
//
//  Created by Jameel Shehadeh on 01/04/2022.
//

import SwiftUI

struct EdvoraRides: View  {
    
    @ObservedObject var networkManager = NetworkManager()
    
    @State private var selectedRideType: Int = 1
    
    var body: some View {
        VStack {
            HStack {
                NavigationView {
                    VStack {
                        HStack {
                            Picker(selection: $selectedRideType, label: Text("Picker")) {
                                Text("Nearest").tag(1)
                                Text("Upcoming").tag(2)
                                Text("Past").tag(3)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            Spacer(minLength: 50.0)
                            .onChange(of: selectedRideType) { value in
                                
                                switch value {
                                case 1 :
                                    //Nearest
                                    networkManager.ridesType = "nearest"
                                    networkManager.getUserInfo()
                                case 2 :
                                    //Upcoming
                                    networkManager.ridesType = "upcoming"
                                    networkManager.getUserInfo()
                                case 3 :
                                    //Past
                                    networkManager.ridesType = "past"
                                    networkManager.getUserInfo()
                                default :
                                    print("error")
                                }
                            
                            }
                            Button {
                                print(selectedRideType)
                            }
                        label: {
                            Label("Filter", systemImage: "line.3.horizontal.decrease")
                        }
                            
                        }
                        .padding()
                        List(networkManager.ridePosts) { ridePost in
                            //Text(ridePost.city)
                            RideView(rideData: ridePost)
                        }
                        .navigationTitle("Edvora")
                        
                    }
                    .toolbar {
                        ToolbarItem(placement:.navigationBarTrailing ) {
                            AsyncImage(url: URL(string: "https://picsum.photos/200"))
                                .frame(width: 50, height: 50, alignment: .center)
                                .clipShape(Circle())
                                .position(x: 20 , y :70)
                        }
                    }
                }
                
                .onAppear {
                    networkManager.ridesType = "nearest"
                    networkManager.getUserInfo()
                }
            }
        }
    }
}

struct EdvoraRides_Previews: PreviewProvider {
    static var previews: some View {
        EdvoraRides()
    }
}

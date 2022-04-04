//
//  RideView.swift
//  EdvoraRides
//
//  Created by Jameel Shehadeh on 01/04/2022.
//

import SwiftUI

struct RideView: View {
    
    var rideData : RideData
    
    var body: some View {
        ZStack {
            VStack {
                AsyncImage(url: URL(string: rideData.map_url)!) { image in
                    image.resizable()
                        .overlay(GeometryReader { geometry in
                            Text("200 Km")
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .position(x: geometry.size.width * 0.9, y: geometry.size.height * 0.9)
                        })
                    
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                }

                HStack {
                    Button {
                        
                    }
                    
                label: {
                    Label("\(rideData.id)", systemImage: "number")
                }
                    
                    Spacer()
                    
                    Button {
                        
                    }
                    
                label: {
                    Label(rideData.formattedDate, systemImage: "calendar")
                }
                    
                }
                .padding()
            }
            .frame(height: 300)
            
        }
        .background(Color.gray.opacity(0.5))
        .cornerRadius(12)
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
}

//struct RideView_Previews: PreviewProvider {
//    static var previews: some View {
//        RideView(rideData: RideData)
//    }
//}

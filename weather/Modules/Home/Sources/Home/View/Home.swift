// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct HomeView: View {
    
    @StateObject var locationManager = LocationManager()
    @ObservedObject var viewModel: HomeViewModel = HomeViewModel()
    
    public init() { }
    
    public var body: some View {
        
        if locationManager.locationIsDisabled {
            RequestLocationView()
                .environmentObject(locationManager)
        }else{
            
            ScrollView(.vertical, showsIndicators: false){
                
                VStack {
                    
                    HStack {
                        Text("Date")
                            .font(.title)
                        Spacer()
                        Text(viewModel.date ?? "")
                        Spacer()
                    }
                    
                    HStack {
                        Text("Description")
                        Spacer()
                        Text(viewModel.description?.capitalized ?? "")
                        Spacer()
                    }
                    
                   
                    
                    HStack {
                        Text("Temp")
                        Spacer()
                        Text(viewModel.temp ?? "")
                        Spacer()
                    }
                    
                    HStack {
                        Text("Feel")
                        Spacer()
                        Text(viewModel.feel ?? "")
                        Spacer()
                    }
                    
                    HStack{
                        Text("Pressure")
                        Spacer()
                        Text(viewModel.pressure ?? "")
                        Spacer()
                    }
                    
                    HStack {
                        Text("Description")
                        Spacer()
                        Text(viewModel.humidity ?? "")
                        Spacer()
                    }
                    HStack {
                        Text("Date")
                        Spacer()
                        Text(viewModel.date ?? "")
                        Spacer()
                    }
                    
                    HStack {
                        Text("Sunset")
                        Spacer()
                        Text(viewModel.sunset ?? "")
                        Spacer()
                    }
                    
                    HStack {
                        Text("Sunrise")
                        Spacer()
                        Text(viewModel.sunrise ?? "")
                        Spacer()
                    }
                    
                    HStack {
                        Text("Wind Speed")
                        Spacer()
                        Text(viewModel.windSpeed ?? "")
                        Spacer()
                    }
                    HStack {
                        Text("Wind Degree")
                        Spacer()
                        Text(viewModel.windDegree ?? "")
                        Spacer()
                    }
                    
                }
                .padding()
                
                
            }
            .padding(.top,64)
            .task {
                
                guard let lat = locationManager.lastSeenLocation?.coordinate.latitude else { return }
                guard let long = locationManager.lastSeenLocation?.coordinate.longitude else { return }

                await self.viewModel.fetchWeather(location: Location(latitude: lat, longitude: long))
            }
            
           
           

        }
    }
}

#Preview {
    HomeView()
}







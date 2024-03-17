//
//  File.swift
//  
//
//  Created by Rakib on 3/17/24.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    
    @Published var isLoading: Bool?
    private let weatherService: WeatherInfoService
    @Published var location: String?
    @Published var date: String?
    @Published var description: String?
    @Published var temp: String?
    @Published var feel: String?
    @Published var pressure: String?
    @Published var humidity: String?
    @Published var windSpeed: String?
    @Published var windDegree: String?
    @Published var sunrise: String?
    @Published var sunset: String?
    
    init(weatherService: WeatherInfoService = WeatherInfoService()) {
        self.weatherService = weatherService
    }
    
    
    func fetchWeather(location: Location) async{
        self.isLoading = true
        let weatherInfoResult = await self.weatherService.fetchWeather(for: location)
        switch weatherInfoResult {
        case let .success(weatherInfo):
            self.setWeatherData(info: weatherInfo)
        case let .failure(error):
            print(error.localizedDescription)
        }
        self.isLoading = false
    }
    
    private func setWeatherData(info: WeatherInfo){
        
        location = info.name
        date = info.dt?.getDate(format: "yyyy:MMM:dd")
        temp = String(info.main?.temp ?? 0)
        feel = String(info.main?.feelsLike ?? 0)
        pressure = String(info.main?.pressure ?? 0)
        humidity = String(info.main?.humidity ?? 0)
        windSpeed = String(info.wind?.speed ?? 0)
        windDegree = String(info.wind?.deg ?? 0)
        description = info.weather?.first?.description
        sunset = info.sys?.sunset?.getDate(format: "HH:mm a")
        sunrise = info.sys?.sunrise?.getDate(format: "HH.mm a")
    }
    

}


extension Int {
    func getDate(format: String) -> String? {
        let date = Date(timeIntervalSince1970: Double(self))
        let dateFormatter = DateFormatter()
        // Choose your desired date format
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
}

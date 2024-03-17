//
//  File.swift
//  
//
//  Created by Rakib on 3/17/24.
//

import Foundation
import Combine
import NetworkLibrary



protocol WeatherServiceProtocol {
    func fetchWeather(for location: Location) async -> Result<WeatherInfo,Error>
}

actor WeatherInfoService {
  private let requestManager: RequestManagerProtocol

  init(requestManager: RequestManagerProtocol = RequestManager()) {
    self.requestManager = requestManager
  }
}

extension WeatherInfoService : WeatherServiceProtocol {
    func fetchWeather(for location: Location)async ->  Result<WeatherInfo,Error> {
        let result: Result<WeatherInfo,Error> = await self.requestManager.perform(WeatherAPIRouter.getWeatherInfo(location: location))
        return result
    }
}

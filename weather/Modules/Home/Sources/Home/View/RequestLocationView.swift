//
//  File.swift
//  
//
//  Created by Rakib on 3/17/24.
//

import SwiftUI
import CoreLocationUI


struct RequestLocationView: View {
  @EnvironmentObject var locationManager: LocationManager

  var body: some View {
    VStack {
      Text(
        """
        To find weather on location, first, you need to
        share your current location.
        """
      )
        .multilineTextAlignment(.center)
        LocationButton(.currentLocation) {
            
            locationManager.requestWhenInUseAuthorization()
            self.startUpdatingLocation()
        }
      .symbolVariant(.fill)
      .foregroundColor(.white)
      .cornerRadius(8)
    }
    .padding()
    .onAppear {
      locationManager.updateAuthorizationStatus()
    }
  }

  func startUpdatingLocation() {
    locationManager.startUpdatingLocation()
  }
}

#Preview {
    RequestLocationView()
        .environmentObject(LocationManager())
}

struct RequestLocationView_Previews: PreviewProvider {
  static var previews: some View {
    RequestLocationView()
      .environmentObject(LocationManager())
  }
}

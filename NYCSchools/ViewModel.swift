//
//  ViewModel.swift
//  NYCSchools
//
//  Created by Akhil Anand Sirra on 23/03/23.
//

import Foundation
import CoreLocation
import MapKit

class getData : ObservableObject {
    @Published var data = [Schools]()
    @Published var count = 1
    
    init() {
        Task(priority: .userInitiated) {
            await updateData()
        }
    }
    
    func updateData() async {
        let url = "http://45.55.192.160:3001/api/v1/school/limit/\(count)"
        let session = URLSession(configuration: .default)
        do {
            let (data, _) = try await session.data(from: URL(string: url)!)
            let json = try JSONDecoder().decode(SchoolData.self, from: data)
            let oldData = self.data
            print(oldData)
            DispatchQueue.main.async {
                self.data = oldData + json.schools
                self.count += 1
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }

    
    func getTrimmedAddress(from addressString: String) -> String {
        if let endIndex = addressString.range(of: "(")?.lowerBound {
            let trimmedAddress = String(addressString[..<endIndex]).trimmingCharacters(in: .whitespacesAndNewlines)
            return trimmedAddress
        } else {
            return addressString
        }
    }
    
    func openMapsApp(forAddress addressString: String, withName name: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let placemarks = placemarks, let placemark = placemarks.first {
                let mapItem = MKMapItem(placemark: MKPlacemark(placemark: placemark))
                mapItem.name = name
                mapItem.openInMaps(launchOptions: nil)
            }
        }
    }

    func openWebsite(urlString: String) {
        if let url = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Error: Unable to open URL")
            }
        }
    }

    func makePhoneCall(phoneNumber: String) {
        let phone = "tel://"
        let phoneNumberformatted = phone + phoneNumber
        
        guard let url = URL(string: phoneNumberformatted) else {
            print("Error: Invalid phone number format")
            return
        }
        
        UIApplication.shared.open(url)
    }

    func sendEmail(to emailAddress: String?) {
        guard let emailAddress = emailAddress, let url = URL(string: "mailto:\(emailAddress)") else {
            print("Error: Invalid email address")
            return
        }
        
        UIApplication.shared.open(url)
    }

}

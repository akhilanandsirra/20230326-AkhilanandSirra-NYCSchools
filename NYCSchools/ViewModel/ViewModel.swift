//
//  ViewModel.swift
//  NYCSchools
//
//  Created by Akhil Anand Sirra on 23/03/23.
//

import Foundation
import CoreLocation
import MapKit
import SafariServices

enum APIError: Error {
    case requestFailed
}

class getData : ObservableObject {
    @Published var data = [Schools]()
    @Published var count = 1
    
    func updateData() async throws {
        let url = "http://45.55.192.160:3001/api/v1/school/limit/\(count)"
        let session = URLSession(configuration: .default)
        do {
            let (data, _) = try await session.data(from: URL(string: url)!)
            let json = try JSONDecoder().decode(SchoolData.self, from: data)
            let oldData = self.data
            DispatchQueue.main.async {
                self.data = oldData + json.schools
                self.count += 1
            }
        } catch {
            throw APIError.requestFailed
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
                return
            } else if let placemarks = placemarks, let placemark = placemarks.first {
                let mapItem = MKMapItem(placemark: MKPlacemark(placemark: placemark))
                mapItem.name = name
                
                if !mapItem.openInMaps(launchOptions: nil) {
                    print("Failed to open Maps app.")
                }
            }
        }
    }


    func openWebsite(urlString: String) {
        var url: URL
        
        if urlString.lowercased().hasPrefix("http://") || urlString.lowercased().hasPrefix("https://") {
            url = URL(string: urlString)!
        } else {
            url = URL(string: "http://" + urlString)!
        }
        
        let safariViewController = SFSafariViewController(url: url)
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first
        else {
            print("Unable to get app window.")
            return
        }
        
        guard let rootViewController = window.rootViewController else {
            print("Unable to get root view controller.")
            return
        }
        
        rootViewController.present(safariViewController, animated: true, completion: nil)
    }

    func makePhoneCall(phoneNumber: String) {
        let phone = "tel://"
        let phoneNumberformatted = phone + phoneNumber
        
        guard let url = URL(string: phoneNumberformatted) else {
            print("Error: Invalid phone number format")
            return
        }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            print("Error: Unable to make phone call")
        }
    }


    func sendEmail(to emailAddress: String?) {
        guard let emailAddress = emailAddress, let url = URL(string: "mailto:\(emailAddress)") else {
            print("Error: Invalid email address")
            return
        }
        
        if !isValidEmailAddress(emailAddress) {
            print("Error: Invalid email address format")
            return
        }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            print("Error: Unable to send email")
        }
    }

    func isValidEmailAddress(_ emailAddress: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: emailAddress)
    }
}

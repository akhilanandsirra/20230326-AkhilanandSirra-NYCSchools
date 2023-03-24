//
//  ViewModel.swift
//  NYCSchools
//
//  Created by Akhil Anand Sirra on 23/03/23.
//

import Foundation

class getData : ObservableObject {
    @Published var data = [Doc]()
    @Published var count = 1
    
    init(){
        updateData()
    }
    
    func updateData() {
        let url = "https://api.plos.org/search?q=title:%22Food%22start=\(count)&rows=10"
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!) { (data, _, error) in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            
            do {
                let json = try JSONDecoder().decode(Detail.self, from: data!)
                let oldData = self.data
                DispatchQueue.main.async {
                    self.data = oldData + json.response.docs
                    self.count += 10
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

//
//  ViewModel.swift
//  NYCSchools
//
//  Created by Akhil Anand Sirra on 23/03/23.
//

import Foundation

class getData : ObservableObject {
    @Published var data = [Schools]()
    @Published var count = 1
    
    init(){
        updateData()
    }
    
    func updateData() {
        let url = "http://45.55.192.160:3001/api/v1/school/limit/\(count)"
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!) { (data, _, error) in
            if error != nil {
                print("oldData")
                print((error?.localizedDescription)!)
                return
            }
            
            do {
                let json = try JSONDecoder().decode(SchoolData.self, from: data!)
                let oldData = self.data
                print(oldData)
                DispatchQueue.main.async {
                    self.data = oldData + json.schools
                    self.count += 1
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

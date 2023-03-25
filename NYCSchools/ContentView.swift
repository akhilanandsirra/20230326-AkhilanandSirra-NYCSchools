//
//  ContentView.swift
//  NYCSchools
//
//  Created by Akhil Anand Sirra on 23/03/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Home()
                .navigationTitle("NYC High Schools")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    @ObservedObject var listData = getData()
    var body: some View {
        List(0..<listData.data.count, id: \.self) { i in
//                if i == self.listData.data.count - 1 {
//                    cellView(data: self.listData.data[i], isLast: true, listData: self.listData)
//                } else {
//                    cellView(data: self.listData.data[i], isLast: false, listData: self.listData)
//                }
            
//                cellView(data: self.listData.data[i], isLast: (i == self.listData.data.count - 1), listData: self.listData)
            
            NavigationLink(destination: DetailsView(data: self.listData.data[i])) {
                cellView(data: self.listData.data[i], isLast: (i == self.listData.data.count - 1), listData: self.listData)
            }
            }
    }
}

struct cellView : View {
    var data: Schools
    var isLast : Bool
    
    @ObservedObject var listData : getData
    
    var body : some View {
        LazyVStack(alignment: .leading, spacing: 12){
            Text(data.school_name).fontWeight(.bold)
//            Text(data.eissn)
//            Text(data.article_type)
            if self.isLast {
                Text(data.neighborhood).font(.caption)
                    .onAppear{
//                        if self.listData.data.count != 50 {
//                            self.listData.updateData()
//                            print("loading")
//                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25 ) {
                            if self.listData.data.count != 45 {
                                print("loading1")
                                self.listData.updateData()
                                print("loading2")
                            }
                        }
                    }
            } else {
                Text(data.neighborhood).font(.caption)
            }
            
        }
        .padding(10)
    }
}

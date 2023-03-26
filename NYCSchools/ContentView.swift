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
            
            NavigationLink(destination: DetailsView(data: self.listData.data[i], listData: self.listData)) {
                cellView(data: self.listData.data[i], isLast: (i == self.listData.data.count - 1), listData: self.listData)
                    
            }
            .listRowSeparator(.hidden)
                            .listRowBackground(
                                RoundedRectangle(cornerRadius: 10)
                                    .background(.clear)
                                    .foregroundColor(Color(.systemBackground))
                                
                                    .padding(
                                        EdgeInsets(
                                            top: 5,
                                            leading: 10,
                                            bottom: 5,
                                            trailing: 10
                                        )
                                    )
                            )
        }
        .background(Color(.secondarySystemFill))
        .listStyle(.plain)
    }
}

struct cellView : View {
    var data: Schools
    var isLast : Bool
    
    @ObservedObject var listData : getData
    @State private var startAnimation: Bool = false
    
    var body : some View {
        LazyVStack(alignment: .leading, spacing: 8) {
            Text(data.school_name).font(.headline)
            Text(data.neighborhood).font(.subheadline)
                .foregroundColor(Color(.secondaryLabel))
                .onAppear {
                    if isLast && listData.data.count != 45 {
                        listData.updateData()
                    }
                }
        }
        .padding(10)
        .opacity(startAnimation ? 1.0: 0.0)
        .animation(.easeInOut (duration: 0.25).delay(0.1), value: startAnimation)
        .onAppear
        {
            startAnimation = true
        }
        //.foregroundColor(.black)
    }
}

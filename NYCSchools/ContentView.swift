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
    @State private var searchText = ""
    @ObservedObject var viewModel = getData()
    var body: some View {
        List(0..<viewModel.data.count, id: \.self) { i in
            NavigationLink(destination: DetailsView(data: self.viewModel.data[i], listData: self.viewModel)) {
                cellView(data: self.viewModel.data[i], isLast: (i == self.viewModel.data.count - 1), listData: self.viewModel)
                    
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
        .searchable(text: $searchText)
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
                        Task {
                            await listData.updateData()
                        }
                    }
                }
        }
        .padding()
        .opacity(startAnimation ? 1.0: 0.0)
        .animation(.easeInOut (duration: 0.25).delay(0.1), value: startAnimation)
        .onAppear
        {
            startAnimation = true
        }
    }
}

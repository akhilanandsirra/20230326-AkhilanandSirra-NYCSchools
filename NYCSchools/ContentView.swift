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
            
            ZStack {
                Color(UIColor.secondarySystemFill).ignoresSafeArea() // For not changing the background when keyboard is used
                Home()
                .navigationTitle("NYC High Schools")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
        
        @State var loading: Bool = false
            @State private var searchText = ""
            @ObservedObject var viewModel = getData()
            @State private var apiError: APIError?
            
            var body: some View {
                if let error = apiError {
                    ErrorView(message: error.localizedDescription)
                } else {
                    List(0..<searchResults.count, id: \.self) { i in
                        NavigationLink(destination: DetailsView(data: searchResults[i], listData: self.viewModel)) {
                            cellView(data: searchResults[i], isLast: (i == searchResults.count - 1), listData: self.viewModel)
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
                    .listStyle(.plain)
                    .task {
                        do {
                            try await viewModel.updateData()
                            apiError = nil
                        } catch {
                            apiError = error as? APIError
                        }
                    }
                }
            }
    var searchResults: [Schools] {
        if searchText.isEmpty {
            return viewModel.data
        } else {
            return viewModel.data.filter { $0.school_name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    }
    // Given more time I would perform query search on whole json, and added favorites filter to it


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
                            do {
                                try await listData.updateData()
                            } catch {
                                print("No Internet")
                            }
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

struct ErrorView: View {
    let message: String
    
    var body: some View {
        Text("Failed to retrieve data. Please check your internet connection and try again later.")
            .padding()
            .multilineTextAlignment(.center)
    }
}

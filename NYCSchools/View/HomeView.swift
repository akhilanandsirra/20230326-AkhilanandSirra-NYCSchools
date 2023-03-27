//
//  HomeView.swift
//  NYCSchools
//
//  Created by Akhil Anand Sirra on 26/03/23.
//

import SwiftUI


struct HomeView : View {
        
        @State var loading: Bool = false
            @State private var searchText = ""
            @ObservedObject var viewModel = getData()
            @State private var apiError: APIError?
            
            var body: some View {
                if let error = apiError {
                    ErrorView(message: error.localizedDescription)
                } else {
                    List(0..<viewModel.searchResults.count, id: \.self) { i in
                        NavigationLink(destination: DetailsView(data: viewModel.searchResults[i], listData: self.viewModel)) {
                            CellView(data: viewModel.searchResults[i], isLast: (i == viewModel.searchResults.count - 1), listData: self.viewModel)
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
                    .searchable(text: $viewModel.searchText) // Given more time I would perform query search on whole json, and added favorites filter to it
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
}
    


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

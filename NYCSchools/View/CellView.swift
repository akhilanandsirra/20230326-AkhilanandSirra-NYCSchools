//
//  CellView.swift
//  NYCSchools
//
//  Created by Akhil Anand Sirra on 26/03/23.
//

import SwiftUI

struct CellView : View {
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

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleData = Schools(dbn: "01M292", school_name: "Test School", neighborhood: "Test Neighborhood", location: "220 Henry Street, New York NY 10002", phone_number: "212-406-9411", website: "http://www.henrystreet.org", total_students: "323")
            let sampleListData = getData()
            return CellView(data: sampleData, isLast: false, listData: sampleListData)
        }
}

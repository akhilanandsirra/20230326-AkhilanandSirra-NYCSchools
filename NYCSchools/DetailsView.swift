//
//  DetailsView.swift
//  NYCSchools
//
//  Created by Akhil Anand Sirra on 24/03/23.
//

import SwiftUI

struct DetailsView: View {
    let data: Schools
     
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                Text(data.school_name)
                    .multilineTextAlignment(.leading)
                
                Text("Math: \(data.sat_math_avg_score ?? "No Scores")")
                    .multilineTextAlignment(.leading)
                
                Text("Writing: \(data.sat_writing_avg_score ?? "No Scores")")
                    .multilineTextAlignment(.leading)
                
                Text("Reading: \(data.sat_critical_reading_avg_score ?? "No Scores")")
                    .multilineTextAlignment(.leading)
                
        
            }
            Spacer()
        }
        .padding()
        .navigationBarTitle(Text("Additional Information"), displayMode: .inline)
    }
}

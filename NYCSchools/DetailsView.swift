//
//  DetailsView.swift
//  NYCSchools
//
//  Created by Akhil Anand Sirra on 24/03/23.
//

import SwiftUI

struct DetailsView: View {
    let data: Schools
    @ObservedObject var listData : getData
     
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            VStack(alignment: .leading, spacing: 10) {
                Text("Name: \(data.school_name)")
                Text("Address: \(listData.getTrimmedAddress(from: data.location))")
                Text("Total Students: \(data.total_students)")
                Text("SAT Scores:").fontWeight(.bold).font(.title2)
                Text("Number of Test Takers: \(data.num_of_sat_test_takers ?? "Not Available")")
                Text("Math: \(data.sat_math_avg_score ?? "Not Available")")
                Text("Writing: \(data.sat_writing_avg_score ?? "Not Available")")
                Text("Reading: \(data.sat_critical_reading_avg_score ?? "Not Available")")
            }
            .padding()
            
            Spacer()
            
            HStack (alignment: .center, spacing: 20) {
                Button(action: {
                    
                }, label: {
                    Text("More Info".uppercased())
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .cornerRadius (10)
                        .shadow(radius: 10)
                        .font(.headline)
                        .padding()
                        .background(
                            Color.blue
                                .cornerRadius(10)
                                .shadow(radius: 10)
                        )
                })
                
                Button(action: {
                    
                }, label: {
                    Text("Contact".uppercased())
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .cornerRadius (10)
                        .shadow(radius: 10)
                        .font(.headline)
                        .padding()
                        .background(
                            Color.blue
                                .cornerRadius(10)
                                .shadow(radius: 10)
                        )
                })
            }
        
            Spacer()

            //.background(Color.gray.opacity(0.2))
            //.frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        //.background(Color.gray.opacity(0.2))
        .navigationBarTitle(Text("Additional Information"), displayMode: .inline)
    }
}

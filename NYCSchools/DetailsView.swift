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
    
    @State private var isShowingContactOptions = false
    @State private var isShowingMoreInfoOptions = false
     
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
                    // handle More Info button action
                    isShowingMoreInfoOptions = true
                }, label: {
                    Text("More Info".uppercased())
                        .fontWeight(.semibold)
                        .font(.headline)
                })
                .buttonStyle(CustomButtonStyle())
                .actionSheet(isPresented: $isShowingMoreInfoOptions) {
                    ActionSheet(title: Text("More Info"), message: nil, buttons: [
                        .default(Text("Get Directions")) {
                            // Get directions
                            listData.openMapsApp(forAddress: listData.getTrimmedAddress(from: data.location), withName: data.school_name)
                        },
                        .default(Text("Visit Website")) {
                            // Open website
                            listData.openWebsite(urlString: data.website)
                        },
                        .cancel()
                    ])
                }
                
                Button(action: {
                    // handle Contact button action
                    isShowingContactOptions = true
                }, label: {
                    Text("Contact".uppercased())
                        .fontWeight(.semibold)
                        .font(.headline)
                })
                .buttonStyle(CustomButtonStyle())
                .actionSheet(isPresented: $isShowingContactOptions) {
                    ActionSheet(title: Text("Contact Options"), message: nil, buttons: [
                        .default(Text("Call: \(data.phone_number)")) {
                            // make a phone call
                            listData.makePhoneCall(phoneNumber: data.phone_number)
                        },
                        .default(Text("Email: \(data.school_email ?? "Not Available")")) {
                            // send email
                            listData.sendEmail(to: data.school_email)
                        },
                        .cancel()
                    ])
                }
            }
        
            Spacer()
        }
        .padding()
        .navigationBarTitle(Text("Additional Information"), displayMode: .inline)
    }
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 20)
            .padding()
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue)
                    .shadow(radius: 10)
            )
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

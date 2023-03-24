//
//  DetailsView.swift
//  NYCSchools
//
//  Created by Akhil Anand Sirra on 24/03/23.
//

import SwiftUI

struct DetailsView: View {
    let data: Doc
     
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                Text(data.publication_date)
                    .multilineTextAlignment(.leading)
                 
                Text("Neighborhood: \(data.id)")
                    .multilineTextAlignment(.leading)
        
            }
            Spacer()
        }
        .padding()
        .navigationBarTitle(Text(data.publication_date), displayMode: .inline)
    }
}

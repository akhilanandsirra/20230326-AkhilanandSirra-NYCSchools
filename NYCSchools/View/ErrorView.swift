//
//  ErrorView.swift
//  NYCSchools
//
//  Created by Akhil Anand Sirra on 26/03/23.
//

import SwiftUI

struct ErrorView: View {
    let message: String
    
    var body: some View {
        Text("Failed to retrieve data. Please check your internet connection and try again later.")
            .padding()
            .multilineTextAlignment(.center)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(message: "Test Error Message")
    }
}

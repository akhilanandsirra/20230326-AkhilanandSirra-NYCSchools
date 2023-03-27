//
//  CustomButtonStyle.swift
//  NYCSchools
//
//  Created by Akhil Anand Sirra on 26/03/23.
//

import SwiftUI

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

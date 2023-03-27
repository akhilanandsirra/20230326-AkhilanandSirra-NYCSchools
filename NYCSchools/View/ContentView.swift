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
                HomeView()
                .navigationTitle("NYC High Schools")
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

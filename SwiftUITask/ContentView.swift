//
//  ContentView.swift
//  SwiftUITask
//
//  Created by Decagon on 04/11/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // Animated Loader view
        AnimatedLoader()
        
        // Uncomment to see the Animated Tab Bar View
        //        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

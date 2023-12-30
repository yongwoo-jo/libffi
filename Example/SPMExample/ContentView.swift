//
//  ContentView.swift
//  SPMExample
//
//  Created by Wang Ya on 30/12/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear(perform: {
            runTest()
        })
    }
}

#Preview {
    ContentView()
}

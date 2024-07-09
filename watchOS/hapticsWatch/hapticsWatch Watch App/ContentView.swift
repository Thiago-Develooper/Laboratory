//
//  ContentView.swift
//  hapticsWatch Watch App
//
//  Created by Thiago Pereira de Menezes on 09/05/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
                .onTapGesture {
                    self.play(.success)
                }
            Text("Hello, world!")
                .onTapGesture {
                    self.play(.success)
                }

            
        }
        .padding()
    }
    
    func play(_ type: WKHapticType) {
            
    }
}

#Preview {
    ContentView()
}

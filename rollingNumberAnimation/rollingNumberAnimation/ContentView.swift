//
//  ContentView.swift
//  rollingNumberAnimation
//
//  Created by Thiago Pereira de Menezes on 26/06/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var value: Int = 111
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                RollingText(font: .system(size: 55), wight: .black, value: $value)
                
                Button("Chage value") {
                    value = .random(in: 200...300)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

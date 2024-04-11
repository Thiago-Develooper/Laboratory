//
//  Grid.swift
//  Laboratory
//
//  Created by Thiago Pereira de Menezes on 22/03/24.
//

import SwiftUI

struct Grid: View {
    
    private var data: [Int] = Array(1...20)
    private var colors: [Color] = [.red, .green, .blue, .yellow]
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]
    
    private let numberColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: numberColumns, spacing: 20) {
                    ForEach(data, id: \.self) { number in
                        ZStack {
                            RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
//                                .frame(width: 170, height: 170)
                                .foregroundColor(colors[number%4])
                            Text("\(number)")
                                .foregroundStyle(.white)
                                .font(.system(size: 80, weight: .medium, design: .rounded))
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Você criou o pecado e não criou o perdão")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    Grid()
}

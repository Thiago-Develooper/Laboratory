//
//  RolingText.swift
//  rollingNumberAnimation
//
//  Created by Thiago Pereira de Menezes on 26/06/24.
//

import SwiftUI

struct RollingText: View {
    
    var font: Font = .largeTitle
    var wight: Font.Weight = .regular
    @Binding var value: Int
    @State var animationRange: [Int] = []
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<animationRange.count, id: \.self) { index in
                Text("8")
                    .font(font)
                    .fontWeight(wight)
                    .opacity(0)
                    .overlay {
                        GeometryReader { proxy in
                            let size = proxy.size
                            
                            VStack(spacing: 0) {
                                ForEach(0...9, id: \.self) { number in
                                    Text("\(number)")
                                        .font(font)
                                        .fontWeight(wight)
                                        .frame(width: size.width, height: size.height, alignment: .center)
                                }
                            }
                            .offset(y: -CGFloat(animationRange[index])  * size.height)
                        }
//                        .clipped()
                    }
            }
        }
        .onAppear {
            // loading range
            animationRange = Array(repeating: 0, count: "\(value)".count)
            //starting with little delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.06) {
                updateText()
            }
        }
        .onChange(of: value) { newValue, oldvalue in
            updateText()
        }
    }
    
    func updateText() {
        let stringValue = "\(value)"
        

        
        for (index,value) in zip(0..<stringValue.count, stringValue) {
            
            // dampingFraction based on index value
            var fraction = Double(index) * 0.15
            
            fraction = (fraction > 0.0 ? 0.5 : fraction)
            
            withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 1, blendDuration: 1)) {
                animationRange[index] = (String(value) as NSString).integerValue
            }
        }
    }
}

//#Preview {
//    RolingText()
//}

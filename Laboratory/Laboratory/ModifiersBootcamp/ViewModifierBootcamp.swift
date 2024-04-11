//
//  ViewModifierBootcamp.swift
//  Laboratory
//
//  Created by Thiago Pereira de Menezes on 11/04/24.
//

import SwiftUI

struct ViewModifierBootcamp: View {
    var body: some View {
        Text("Modificador testado")
            .modifier(AlertTextModifier(textColor: .pink))
            .modifier(MYDefaultTextModifier())
        
        Text("\(Self.self)")
    }
}

#Preview {
    ViewModifierBootcamp()
}

struct MYDefaultTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body)
            .foregroundStyle(.gray)
            .multilineTextAlignment(.leading)
    }
}

struct AlertTextModifier: ViewModifier {
    
    let textColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundStyle(textColor)
            .multilineTextAlignment(.center)
            .bold()
    }
}

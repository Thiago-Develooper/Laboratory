//
//  ViewModifierBootcamp.swift
//  Laboratory
//
//  Created by Thiago Pereira de Menezes on 11/04/24.
//

import SwiftUI

struct ViewModifierBootcamp: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .modifier(AlertTextModifier())
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
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundStyle(.red)
            .multilineTextAlignment(.center)
            .bold()
    }
}

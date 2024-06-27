//
//  ActivityCard.swift
//  coreMotionTest
//
//  Created by Thiago Pereira de Menezes on 08/05/24.
//

import SwiftUI

struct ActivityCard: View {
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Daily steps")
                        .font(.system(size: 16))
                    
                    Text("Goal: 10,000")
                        .font(.system(size: 12))
                        .foregroundStyle(.gray)
                }
                
                Spacer()
                
                Image(systemName: "figure.walk")
                    .foregroundStyle(.green)
            }
            .padding()
            
            Text("6,234")
                .font(.system(size: 24))
        }
        .padding()
        .cornerRadius(15)
    }
}

#Preview {
    ActivityCard()
}

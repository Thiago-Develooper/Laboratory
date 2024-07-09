//
//  HomeView.swift
//  healthkitAppParaAprender
//
//  Created by Thiago Pereira de Menezes on 10/05/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var manager: HealthManager
    var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)) {
                ActivityCard()
                ActivityCard()
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    HomeView()
}

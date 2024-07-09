//
//  BeActivTabView.swift
//  healthkitAppParaAprender
//
//  Created by Thiago Pereira de Menezes on 10/05/24.
//

import SwiftUI

struct BeActivTabView: View {
    
    @State var selectedTab = "Home"
    @EnvironmentObject var manager: HealthManager
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tag("Home")
                .tabItem {
                    Image(systemName: "house")
                }
                .environmentObject(manager)
            
            ContentView()
                .tag("Content")
                .tabItem {
                    Image(systemName: "person")
                }
        }
        
    }
}

#Preview {
    BeActivTabView()
}

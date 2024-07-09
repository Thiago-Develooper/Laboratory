//
//  healthkitAppParaAprenderApp.swift
//  healthkitAppParaAprender
//
//  Created by Thiago Pereira de Menezes on 10/05/24.
//

import SwiftUI

@main
struct healthkitAppParaAprenderApp: App {
    
    @StateObject var manager = HealthManager()
    
    var body: some Scene {
        WindowGroup {
            BeActivTabView()
                .environmentObject(manager)
        }
    }
}

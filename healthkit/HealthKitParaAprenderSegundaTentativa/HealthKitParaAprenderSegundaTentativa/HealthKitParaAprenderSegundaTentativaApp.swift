//
//  HealthKitParaAprenderSegundaTentativaApp.swift
//  HealthKitParaAprenderSegundaTentativa
//
//  Created by Thiago Pereira de Menezes on 13/05/24.
//

import SwiftUI

@main
struct HealthKitParaAprenderSegundaTentativaApp: App {
    @StateObject var manager = HealthManager()
    var body: some Scene {
        WindowGroup {
            BeActivTabView()
                .environmentObject(manager)
        }
    }
}

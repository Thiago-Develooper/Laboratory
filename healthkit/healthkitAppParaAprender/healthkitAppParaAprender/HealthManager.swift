//
//  HealthManager.swift
//  healthkitAppParaAprender
//
//  Created by Thiago Pereira de Menezes on 13/05/24.
//

import Foundation
import HealthKit

class HealthManager: ObservableObject {
    
    let healthStore = HKHealthStore()
    
    init() {
        let steps = HKQuantityType(.stepCount)
        
        let healthTypes: Set = [steps]
        
        Task {
            do {
                try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
            } catch {
                print("Errror fetching health data")
            }
        }
    }
}

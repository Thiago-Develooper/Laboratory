//
//  HealthKitTeste.swift
//  RelenbandoNotifications Watch App
//
//  Created by Thiago Pereira de Menezes on 17/05/24.
//

import Foundation
import HealthKit

class HealthKitTeste {
    func requestAuthorization() {
        // Request authorization
        let healthStore = HKHealthStore()
        healthStore.requestAuthorization(toShare: nil, read: [HKObjectType.quantityType(forIdentifier: .heartRate)!], completion: { (success, error) in
            if success {
                // Begin observing changes in HealthKit data
                let query = HKObserverQuery(sampleType: HKObjectType.quantityType(forIdentifier: .heartRate)!, predicate: nil) { (query, completionHandler, error) in
                    if error != nil {
                        // Handle error
                    } else {
                        // Notify the health store
                        completionHandler()
                    }
                }
                healthStore.execute(query)
            }
        })
        
    }
    
    // Called when changes in HealthKit data are detected
    func didUpdate() {
        // Update existing HealthKit data or take other actions
    }
    
    //MARK: -
    
    func requestDaSegundaForma() {
        // Request authorization
        let healthStore = HKHealthStore()
        healthStore.requestAuthorization(toShare: nil, read: [HKObjectType.quantityType(forIdentifier: .heartRate)!], completion: { (success, error) in
            if success {
                // Begin observing changes in HealthKit data
                let query = HKObserverQuery(sampleType: HKObjectType.quantityType(forIdentifier: .heartRate)!, predicate: nil) { (query, completionHandler, error) in
                    if error != nil {
                        // Handle error
                    } else {
                        // Notify the health store
                        completionHandler()
                    }
                }
                healthStore.execute(query)
            }
        })
    }
    
    // Called when changes in HealthKit data are detected
//    func didUpdate() {
//        // Update existing HealthKit data or take other actions
//    }

}


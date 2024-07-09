//
//  HealthManager.swift
//  HealthKitParaAprenderSegundaTentativa
//
//  Created by Thiago Pereira de Menezes on 13/05/24.
//

import Foundation
import HealthKit

extension Date {
    //retorna o início do dia
    static var startOfDay: Date {
        Calendar.current.startOfDay(for: Date())
    }
}

extension Double {
    //retorna string formatada
    func formettedString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}

class HealthManager: ObservableObject {
    let healthStore = HKHealthStore()
    @Published var activites: [String : Activity] = [:]
    
    init() {
        let steps = HKQuantityType(.stepCount)
        let calories = HKQuantityType(.activeEnergyBurned)
        
        let heathTypes: Set = [steps, calories]
        
        Task {
            do {
                try await healthStore.requestAuthorization(toShare: [], read: heathTypes)
                fetchTodaySteps()
                fetchTodayCalories()
            } catch {
                print("Error fetching health data")
            }
        }
    }
    
    func fetchTodaySteps() {
        let steps = HKQuantityType(.stepCount)
//        let calories = HKQuantityType(.activeEnergyBurned)
        
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, result, error in
            guard let result = result, let quantity = result.sumQuantity(), error == nil else {
                print("error fetching todays step data")
                return
            }
            
            let stepCount = quantity.doubleValue(for: .count())
            let activity = Activity(id: 0, title: "Today steps", subtitle: "Goal 10,000", image: "figure.walk", amount: stepCount.formettedString())
            self.activites["todaySteps"] = activity
            
            DispatchQueue.main.async {
                self.activites["todaySteps"] = activity
            }
            
            print("Passos dados hoje: ")
            print(stepCount.formettedString())
        }
        
        healthStore.execute(query)
    }
    
    func fetchTodayCalories() {
        let calories = HKQuantityType(.activeEnergyBurned)
        
        //Definindo predicate para realizar filtragem da querry
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        
        // realizando a query
        // passa como parametro o HKQuantityType que será requisitado
        // passa como parametro o predicado da requisição
        let query = HKStatisticsQuery(quantityType: calories, quantitySamplePredicate: predicate) { _, result, error in
            
            //objeto HKQuantity que recebe o valor da requisição
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("error fetching todays calorie data")
                return
            }
            
            // atribue o valor de forma refinada
            let caloriesBurned = quantity.doubleValue(for: .kilocalorie())
            let activity = Activity(id: 0, title: "Today calories", subtitle: "Goal 900", image: "flame", amount: caloriesBurned.formettedString())
            
            DispatchQueue.main.async {
                self.activites["todayCalories"] = activity
            }
            
            print("Calorias queimadas hoje: ")
            print(caloriesBurned.formettedString())
            
        }
        healthStore.execute(query)
    }
}


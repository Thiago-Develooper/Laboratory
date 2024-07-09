//
//  ContentView.swift
//  FazendoFuncionarNavigationLink Watch App
//
//  Created by Thiago Pereira de Menezes on 21/05/24.
//

import SwiftUI

struct Workout: Identifiable {
  var id: String { name }
  let name: String
  let symbolName: String
}

struct WorkoutCellView: View {
  let workout: Workout
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack(alignment: .top) {
        // The workout symbol
        Image(systemName: workout.symbolName)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 40, height: 40, alignment: .leading)
          .foregroundColor(.green)
        Spacer()
        // The ellipsis
        Image(systemName: "ellipsis.circle.fill")
          .resizable()
          .frame(width: 24, height: 24)
          .foregroundColor(.gray)
      }
      // The name of the workout
      Text(workout.name)
    }
    .padding(16)
  }
}

struct ContentView: View {
    
    let workouts = [
      Workout(name: "Outdoor Walk", symbolName: "figure.walk"),
      Workout(name: "Outdoor Bike", symbolName: "bicycle"),
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(workouts) { workout in
                    NavigationLink(destination: WorkoutSetupView(workout: workout)) {
                        WorkoutCellView(workout: workout)
                    }
                }
            }
            .navigationTitle("Workouts")
        }
    }
}

struct WorkoutSetupView: View {
  let workout: Workout

  var body: some View {
    Text(workout.name)
  }
}

#Preview {
    ContentView()
}



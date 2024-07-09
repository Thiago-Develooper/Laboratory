//
//  ContentView.swift
//  LearningStoreKit
//
//  Created by Thiago Pereira de Menezes on 24/05/24.
//

import SwiftUI
import StoreKit

struct ContentView: View {
    @StateObject var storeKit = StoreKitManager()
    var body: some View {
        VStack {
            ForEach(storeKit.storeProducts) { product in
                HStack {
                    Text(product.displayName)
                    Spacer()
                    Button {
                        Task {
                            try await storeKit.purchase(product)
                        }
                        
                    } label: {
                        CourseItem(storeKit: storeKit, product: product)
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

struct CourseItem: View {
    @ObservedObject var storeKit: StoreKitManager
    @State private var isPurchased: Bool = false
    var product: Product
    
    var body: some View {
        VStack {
            if isPurchased {
                Text(Image(systemName: "checkmark"))
                    .bold()
                    .padding(20)
            } else {
                Text(product.displayPrice)
                    .padding(10)
            }
        }
        .onChange(of: storeKit.purchasedCourses) { course, i in
            Task {
                isPurchased = (try? await storeKit.isPurchased(product)) ?? false
            }
        }
    }
}


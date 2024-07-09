//
//  StoreKitManager.swift
//  LearningStoreKit
//
//  Created by Thiago Pereira de Menezes on 24/05/24.
//

import Foundation
import StoreKit

// 1. pega o caminho do plist
// 2. requisita os produtos disponíveis 

class StoreKitManager: ObservableObject {
    
    @Published var storeProducts: [Product] = []
    @Published var purchasedCourses: [Product] = []
    
    var updateListenerTask: Task<Void, Error>? = nil
    
    private let productDict: [String : String]
    
    init() {
        // check the path for the plist
        if let plistPath = Bundle.main.path(forResource: "PropertyList", ofType: "plist"),
           let plistData = FileManager.default.contents(atPath: plistPath) {
            productDict = (try? PropertyListSerialization.propertyList(from: plistData, format: nil) as? [String: String]) ?? [:]
        } else {
            productDict = [:]
        }
        
        updateListenerTask = listenForTransactions()
        
        Task {
            await requestProduct()
            
            await updateCustomerProductStatus()
        }
    }
    
    deinit {
        updateListenerTask?.cancel()
    }
    
    func listenForTransactions() -> Task<Void, Error> {
        return Task.detached {
            // iterate through any transactions that don't come from a direct call to 'purchase()'
            for await result in Transaction.updates {
                do {
                    let transaction = try self.checkVerified(result)
                    
                    // the transaction is verified, deliver the content to tthe user
                    await self.updateCustomerProductStatus()
                    
                    // Always finish a transaction
                    await transaction.finish()
                } catch {
                    // storeKit has a trasaction that fails verification, don't delvier content to the user
                    print("Transaction failed verification")
                }
            }
        }
    }
    
    @MainActor
    func requestProduct() async {
        do {
            // using the Product static method products to retrieve the list of products
            storeProducts = try await Product.products(for: productDict.values)
            // iterate the "type" if there are multiple product types.
        } catch {
            print("Failed - error retriving products \(error)")
        }
    }
    
    // Call the product purchase and returns an optional transaction
    func purchase(_ product: Product) async throws -> Transaction? {
        // make a purchase request - optional parameters available
        let result = try await product.purchase()
        
        // check the results
        switch result {
        case .success(let verificationResult):
            // transaction will be verified for automaticallu using JWT (jwsRepresentation) - we can check the result
            let transaction = try checkVerified(verificationResult)
            
            // the transaction is virified, deliver the concent to the user
            await updateCustomerProductStatus()
            
            // always finish a transaction - performance
            await transaction.finish()
            
            return transaction
        case .userCancelled, .pending:
            return nil
        
        default:
            return nil
            
        }
    }
    
    // Generics - check the verificationResults
    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        // check if JWS passes the StoreKit verification
        switch result {
        case .unverified:
            // feiled verification
            throw StoreError.failedVerification
        case .verified(let signedType):
            // the result is vefied, return the unwrapped value
            return signedType
        }
    }
    
    @MainActor
    func updateCustomerProductStatus() async {
        var purchasedCourses: [Product] = []
        
        // iterate through all the user's purchased products
        for await result in Transaction.currentEntitlements {
            do {
                // again check if transaction is verified
                let transaction = try checkVerified(result)
                
                // since we only have one type of producttype - .nonconsumables -- check if any storeProducts matches the transaction.productID then add the purchasedCourses
                if let course = storeProducts.first(where: { $0.id == transaction.productID }) {
                    purchasedCourses.append(course)
                }
            } catch {
                // storeKit has a transaction that fails verification, don't delvier content to the user
                print("Transaction failed verification")
            }
            
            // finally assigb the pyrchased products
            self.purchasedCourses = purchasedCourses
        }
    }
    
    // check if product has already been purchased
    func isPurchased(_ product: Product) async throws -> Bool {
        return purchasedCourses.contains(product)
    }
    
}

public enum StoreError: Error {
    case failedVerification
}

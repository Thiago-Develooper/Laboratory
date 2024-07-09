//
//  StoreKitManager.swift
//  testeCompraIphone2
//
//  Created by Thiago Pereira de Menezes on 04/06/24.
//

import Foundation
import StoreKit

//class StoreKitManager: ObservableObject {
//    
//    // armazena os produtos que estao a venda
//    @Published var storeProducts: [Product] = []
//    
//    // armazena produtos que já foram comprados
//    @Published var purchasedCourses: [Product] = []
//    
//    var updateLisneterTask: Task<Void, Error>? = nil
//    
//    // dicionário que recebe dados/produtos do PropertyList
//    let productDict: [String: String]
//    
//    
//    init() {
//        // checa o caminho para o plistPath
//        // recebe como parametro o nome do plist
//        if let plistPath = Bundle.main.path(forResource: "PropertyList", ofType: "plist"),
//            
//            //busca a lista de produtos
//        let plist = FileManager.default.contents(atPath: plistPath) {
//            
//            // chega se tem algum dado no PropertyList e colocar na var productDict, se não, dexar product list vazio.
//            productDict = (try? PropertyListSerialization.propertyList(from: plist, format: nil) as? [String : String]) ?? [:]
//        } else { // se não conseguir ler o arquivo apenas atribui vazio a variável
//            productDict = [:]
//        }
//        
//        // ----------------------- //
//        
//        updateLisneterTask = listenForTransactions()
//        
//        // chama a funcao para popular a var de storeProducts
//        Task {
//            await requestProducts()
//            
//            await updateCostumerProductStatus()
//        }
//    }
//    
//    deinit {
//        updateLisneterTask?.cancel()
//    }
//    
//    // função breadge/ponte
//    // variável que será o ouvinte, ou seja, função que também será um teste, ela vai ver a tualização da transaçõa e verificar a trasação, ela vai fazer uma serie de verificações, e termina a transação, precisamos chamar ela no início
//    func listenForTransactions() -> Task<Void, Error> {
//        return Task.detached {
//            // itera através de quaisquer transações que não venham de uma chamada direta para 'purchase()'
//            for await result in Transaction.updates {
//                do {
//                    // verifica o resultado
//                    let transaction = try self.checkVerified(result)
//                    
//                    // a transação foi verificada, entregar conteúdo para usuário
//                    await self.updateCostumerProductStatus()
//                    
//                    // sempre conclui a transação
//                    await transaction.finish()
//                }
//            }
//        }
//    }
//
//    
//    // Converte os Dictionarys tirados de PropertyList em productDict para objetos do tipo Product
//    @MainActor
//    func requestProducts() async {
//        do {
//            // usa o método Product.products para transformar itens do dicionário em instâncias de Products
//            storeProducts = try await Product.products(for: productDict.values)
//        } catch {
//            print("Falha em converter produtos de productDict para Produtos: \(error)")
//        }
//    }
//    
//    // tenta comprar um product, talvez retorna uma transação, tem um produto como parametro.
//    func purchase(_ product: Product) async throws -> Transaction? {
//        
//        // requisita uma compra
//        let result = try await product.purchase()
//
//        // checa o resultado da compra:
//        switch result {
//            case .success(let verificationResult):
//                
//                // verificar transacao, se a transacao for verificada executaresmos a funcao abaixo updateCostumerProductStatus()
//                let transaction = try checkVerified(verificationResult)
//                
//                // a transação foi verificada, entrega o contexto para o usuário
//                await updateCostumerProductStatus()
//                
//                // sempre executar ao terminar uma transação - performance
//                await transaction.finish()
//                
//                return transaction
//            case .userCancelled, .pending:
//                return nil
//            default:
//                return nil
//            }
//    }
//    
//    // função genérica que checa o resultado de um Product.purcase() -> VerificationResult
//    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
//        // checa com JWS pass para StoreKit verification
//        switch result {
//        case .unverified:
//            // falha na verificação
//            throw StoreError.failedVerification
//        case .verified(let signedType):
//            // sucesso na verificação, retorna um unwrapped value
//            return signedType
//        }
//    }
//        
//    // função que atualiza o estado do cliente, ela verifica todos os produtos que o usuário comprou e adiciona no array de produtos comprados
//    @MainActor
//    func updateCostumerProductStatus() async {
//        var purchasedCourses: [Product] = []
//        
//        // percorre todas as compras do usuário
//        for await result in Transaction.currentEntitlements {
//            
//            do {
//                // chega de novo se a tranação foi verificada
//                let transaction = try checkVerified(result)
//                
//                // since we only have one type of producttype - .nonconsumables -- check if any storeProducts matches the transaction.productID then add the purchasedCourses
//                if let course = storeProducts.first(where: { $0.id == transaction.productID}) {
//                    purchasedCourses.append(course)
//                }
//            } catch {
//                // a trasacao do storekit falhou, não entregue o conteúdo ao usuário
//                print("transaction failed verification")
//            }
//            
//            // finalmente avalia os produtos adquiridos (aparentemente finalmente atribui as novas compras ao array de compras do usuário
//            self.purchasedCourses = purchasedCourses
//        }
//    }
//    
//    // retorna se o produto já foi comprado ou não, retorna um booleado
//    func isPurchased(_ product: Product) async throws -> Bool {
//        // checa se o array de produtos comprados contém o produto recebido como parametro
//        return purchasedCourses.contains(product)
//    }
//}

public enum StoreError: Error {
    case failedVerification
}


class StoreKitManager: ObservableObject {
    // if there are multiple product types - create multiple variable for each .consumable, .nonconsumable, .autoRenewable, .nonRenewable.
    @Published var storeProducts: [Product] = []
    @Published var purchasedCourses : [Product] = []
    
    var updateListenerTask: Task<Void, Error>? = nil
    
    //maintain a plist of products
    private let productDict: [String : String]
    init() {
        //check the path for the plist
        if let plistPath = Bundle.main.path(forResource: "PropertyList", ofType: "plist"),
           //get the list of products
           let plist = FileManager.default.contents(atPath: plistPath) {
            productDict = (try? PropertyListSerialization.propertyList(from: plist, format: nil) as? [String : String]) ?? [:]
        } else {
            productDict = [:]
        }
        
        //Start a transaction listener as close to the app launch as possible so you don't miss any transaction
        updateListenerTask = listenForTransactions()
        
        //create async operation
        Task {
            await requestProducts()
            
            //deliver the products that the customer purchased
            await updateCustomerProductStatus()
        }
    }
    
    //denit transaction listener on exit or app close
    deinit {
        updateListenerTask?.cancel()
    }
    
    //listen for transactions - start this early in the app
    func listenForTransactions() -> Task<Void, Error> {
        return Task.detached {
            //iterate through any transactions that don't come from a direct call to 'purchase()'
            for await result in Transaction.updates {
                do {
                    let transaction = try self.checkVerified(result)
                    
                    //the transaction is verified, deliver the content to the user
                    await self.updateCustomerProductStatus()
                    
                    //Always finish a transaction
                    await transaction.finish()
                } catch {
                    //storekit has a transaction that fails verification, don't delvier content to the user
                    print("Transaction failed verification")
                }
            }
        }
    }
    
    // request the products in the background
    @MainActor
    func requestProducts() async {
        do {
            //using the Product static method products to retrieve the list of products
            storeProducts = try await Product.products(for: productDict.values)
            
            // iterate the "type" if there are multiple product types.
        } catch {
            print("Failed - error retrieving products \(error)")
        }
    }
    
    
    //Generics - check the verificationResults
    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        //check if JWS passes the StoreKit verification
        switch result {
        case .unverified:
            //failed verificaiton
            throw StoreError.failedVerification
        case .verified(let signedType):
            //the result is verified, return the unwrapped value
            return signedType
        }
    }
    
    // update the customers products
    @MainActor
    func updateCustomerProductStatus() async {
        print("updateCustomerProductStatus camada 1")
        var purchasedCourses: [Product] = []
        
        //iterate through all the user's purchased products
        for await result in Transaction.currentEntitlements {
            print("updateCustomerProductStatus camada 2, entrou no for await")

            do {
                print("updateCustomerProductStatus camada 3, entrou no do")
                //again check if transaction is verified
                let transaction = try checkVerified(result)
                // since we only have one type of producttype - .nonconsumables -- check if any storeProducts matches the transaction.productID then add to the purchasedCourses
                if let course = storeProducts.first(where: { $0.id == transaction.productID}) {
                    purchasedCourses.append(course)
                }
                
            } catch {
                //storekit has a transaction that fails verification, don't delvier content to the user
                print("Transaction failed verification")
            }
            
            //finally assign the purchased products
            self.purchasedCourses = purchasedCourses
        }
    }
    
    // call the product purchase and returns an optional transaction
    func purchase(_ product: Product) async throws -> Transaction? {
        //make a purchase request - optional parameters available
        let result = try await product.purchase()
        print("camada 1")
        
        // check the results
        switch result {
        case .success(let verificationResult):
            print("camada 2")
            //Transaction will be verified for automatically using JWT(jwsRepresentation) - we can check the result
            let transaction = try checkVerified(verificationResult)
            
            print("camada 3")
            
            //the transaction is verified, deliver the content to the user
            await updateCustomerProductStatus()
            print("camada 4")
            
            //always finish a transaction - performance
            await transaction.finish()
            print("camada 5")
            
            return transaction
        case .userCancelled, .pending:
            return nil
        default:
            return nil
        }
        
    }
    
    //check if product has already been purchased
    func isPurchased(_ product: Product) async throws -> Bool {
        //as we only have one product type grouping .nonconsumable - we check if it belongs to the purchasedCourses which ran init()
        return purchasedCourses.contains(product)
    }
    
    
}

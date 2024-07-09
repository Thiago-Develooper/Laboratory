//
//  test.swift
//  testeCompraIphone2
//
//  Created by Thiago Pereira de Menezes on 04/06/24.
//

import SwiftUI
import StoreKit

struct test: View {
    
    @ObservedObject var storeKit = StoreKitManager()
    
    var body: some View {
        StoreView(products: storeKit.storeProducts)
    }
}

#Preview {
    test()
}

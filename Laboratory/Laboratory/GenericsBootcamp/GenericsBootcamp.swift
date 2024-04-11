//
//  GenericsBootcamp.swift
//  Laboratory
//
//  Created by Thiago Pereira de Menezes on 11/04/24.
//

import SwiftUI

struct GenericModel<T> {
    let info: T?
    func removeInfo() -> GenericModel {
        GenericModel(info: nil)
    }
}


struct GenericView<T: View>: View {
    let content: T
    let title: String
    
    var body: some View {
        VStack {
            Text(title)
            content
        }
    }
}

class GenericsViewModel: ObservableObject {
    @Published var genericStringModel = GenericModel(info: "Olá, mundo!")
    @Published var genericBoolModal = GenericModel(info: true)
    
    func removeDataFromDataArray() {
        genericStringModel = genericStringModel.removeInfo()
        genericBoolModal = genericBoolModal.removeInfo()
    }
}

struct GenericsBootcamp: View {
    
    @StateObject private var vm = GenericsViewModel()
    
    
    var body: some View {
        VStack {
            GenericView(content: 
                            HStack {
                Image(systemName: "arrow.right.circle.fill").foregroundStyle(.blue).font(.largeTitle)
                
                Text("arrow.right.cirlce.fill").foregroundStyle(.green)
            }
                        
                        , title: "CustomViewTitle")
            Text(vm.genericStringModel.info ?? "no data")
            Text(vm.genericBoolModal.info?.description ?? "no data")
        }
        .onTapGesture {
            vm.removeDataFromDataArray()
        }
    }
}

#Preview {
    GenericsBootcamp()
}

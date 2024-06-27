//
//  ContentView.swift
//  coreMotionTest
//
//  Created by Thiago Pereira de Menezes on 08/05/24.
//

import SwiftUI
import Charts
import CoreMotion

struct ContentView: View {
    
    let motionManager = CMMotionManager()
    let queue = OperationQueue()
    
    @State var pitch: [Double] = []
    @State var yaw: [Double] = []
    @State var roll: [Double] = []
    
    var body: some View {
        VStack {
            
            
            
        }
    }
}

#Preview {
    ContentView()
}

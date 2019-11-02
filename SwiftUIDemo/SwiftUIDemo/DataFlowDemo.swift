//
//  DataFlowDemo.swift
//  SwiftUIDemo
//
//  Created by sunyang on 26.10.19.
//  Copyright © 2019 test. All rights reserved.
//

import SwiftUI

struct DataFlowDemo: View {
    @State private var counter: Int = 0
    var body: some View {
        VStack {
            Stepper(value: $counter) {
             Text("Stepper")
            }.padding(80)
            Text("MainView:\(self.counter)")
//            SubView(subCounter: $counter)
            SubView(subCounter: counter)
            .padding()
        }
    }
}

struct DataFlowDemo_Previews: PreviewProvider {
    static var previews: some View {
        DataFlowDemo()
    }
}

struct SubView: View {
//    @Binding var subCounter:Int
    @State var subCounter:Int
    var body: some View {
        VStack {
            Stepper(value: $subCounter) {
             Text("Stepper")
            }.padding(80)
            Text("SubView:\(self.$subCounter.wrappedValue)")
        }
    }
}

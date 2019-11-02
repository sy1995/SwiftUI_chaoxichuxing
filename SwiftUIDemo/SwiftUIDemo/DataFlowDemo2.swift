//
//  DataFlowDemo2.swift
//  SwiftUIDemo
//
//  Created by sunyang on 27.10.19.
//  Copyright © 2019 test. All rights reserved.
//

import SwiftUI

class ObserveClassDemo: ObservableObject {
    @Published var counter:Int = 0
}

struct DataFlowDemo2: View {
    @ObservedObject var observeClassDemo: ObserveClassDemo
    var body: some View {
        VStack {
            Stepper(value: self.$observeClassDemo.counter) {
             Text("Stepper")
            }.padding(80)
            Text("MainView:\(self.observeClassDemo.counter)")
            ObeservedSubViwe1(observeClassDemo: self.observeClassDemo)
            .padding()
        }
    }
}

struct DataFlowDemo2_Previews: PreviewProvider {
    static var previews: some View {
        DataFlowDemo2(observeClassDemo: ObserveClassDemo())
    }
}

struct ObeservedSubViwe1: View {
    @ObservedObject var observeClassDemo: ObserveClassDemo
        var body: some View {
            VStack {
                Stepper(value: self.$observeClassDemo.counter) {
                 Text("Stepper")
                }.padding(80)
                Text("MainView:\(self.observeClassDemo.counter)")
                ObeservedSubViwe2(observeClassDemo: self.observeClassDemo)
                .padding()
            }
        }
}

struct ObeservedSubViwe2: View {
    @ObservedObject var observeClassDemo: ObserveClassDemo
        var body: some View {
            VStack {
                Stepper(value: self.$observeClassDemo.counter) {
                 Text("Stepper")
                }.padding(80)
                Text("MainView:\(self.observeClassDemo.counter)")
                .padding()
            }
        }
}

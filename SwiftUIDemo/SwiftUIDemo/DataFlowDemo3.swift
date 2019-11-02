//
//  DataFlowDemo3.swift
//  SwiftUIDemo
//
//  Created by sunyang on 27.10.19.
//  Copyright © 2019 test. All rights reserved.
//

import SwiftUI

class EnvironmentDemo: ObservableObject {
    @Published var counter:Int = 0
}


struct DataFlowDemo3: View {
    @EnvironmentObject var environmentDemo: EnvironmentDemo
    var body: some View {
        VStack {
            Stepper(value: self.$environmentDemo.counter) {
                Text("Stepper")
            }.padding(80)
            Text("MainView:\(self.environmentDemo.counter)")
            EnviSubView1()
                .padding()
        }
    }
}

struct DataFlowDemo3_Previews: PreviewProvider {
    static var previews: some View {
        DataFlowDemo3().environmentObject(EnvironmentDemo())
    }
}

struct EnviSubView1: View {
    @State private var counter = 0
    var body: some View {
        VStack {
            Stepper(value: self.$counter) {
                Text("Stepper")
            }.padding(80)
            Text("MainView:\(self.counter)")
            EnviSubView2()
                .padding()
        }
    }
}
struct EnviSubView2: View {
    @EnvironmentObject var environmentDemo: EnvironmentDemo
    var body: some View {
        VStack {
            Stepper(value: self.$environmentDemo.counter) {
                Text("Stepper")
            }.padding(80)
            Text("MainView:\(self.environmentDemo.counter)")
        }
    }
}

//
//  StateDemo.swift
//  SwiftUIDemo
//
//  Created by sunyang on 26.10.19.
//  Copyright © 2019 test. All rights reserved.
//

import SwiftUI

struct StateDemo: View {
    @State private var isShow: Bool = false
    @State private var counter: Int = 0
    var body: some View {
        VStack {
            Button(action: {
                self.isShow.toggle()
            }) {
            Text("点击切换显示效果")
            }
            Stepper(value: $counter) {
             Text("Stepper")
            }.padding(80)
            ZStack {
                Text(/*@START_MENU_TOKEN@*/"Hello World!"/*@END_MENU_TOKEN@*/)
                    .blur(radius: self.isShow ? 10 : 0)
                if self.isShow{
                    Text("\(self.counter)")
                }
            }
        }
    }
}

struct StateDemo_Previews: PreviewProvider {
    static var previews: some View {
        StateDemo()
    }
}

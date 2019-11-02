//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by sunyang on 21.10.19.
//  Copyright © 2019 test. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 5.0) {
            HStack {
                Text("水平布局")
                Text("Hello World")
            }
            HStack {
                Text("水平布局")
                Text("Hello World")
            }
            .background(Color.red)
//            .shadow(color: Color.gray, radius: 20)
            .blur(radius: 20)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

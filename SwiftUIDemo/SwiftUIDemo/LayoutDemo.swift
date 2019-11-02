//
//  LayoutDemo.swift
//  SwiftUIDemo
//
//  Created by sunyang on 21.10.19.
//  Copyright © 2019 test. All rights reserved.
//
//微信读书布局示例

import SwiftUI

struct LayoutDemo: View {
    var body: some View {
        TabView(selection: /*@START_MENU_TOKEN@*/ /*@PLACEHOLDER=Selection@*/.constant(1)/*@END_MENU_TOKEN@*/) {
            DiscoverView()
                .tabItem {
                    Image(systemName: "safari").imageScale(.large)
                    Text("发现")
            }.tag(1)
            
            Text("Tab Content 2")
                .tabItem {
                    Image(systemName: "book.circle").imageScale(.large)
                    Text("书架")
            }.tag(2)
            Text("Tab Content 2")
                .tabItem {
                    Image(systemName: "personalhotspot").imageScale(.large)
                    Text("故事")
            }.tag(3)
            Text("Tab Content 2")
                .tabItem {
                    Image(systemName: "person").imageScale(.large)
                    Text("我的")
            }.tag(4)
        }
    }
}

struct LayoutDemo_Previews: PreviewProvider {
    static var previews: some View {
        LayoutDemo()
    }
}

struct DiscoverView: View {
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("SwiftUI教程（独家首发）", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                            Text("|  书城")
                                .fontWeight(.bold)
                                .foregroundColor(Color.gray)
                        }
                        
                    }
                    .padding()
                    .background(Color("SearchBg"))
                }
                .cornerRadius(30)
                .padding()
                
                Spacer()
                
                ScrollView {
                    CardView()
                }
                
                Spacer()

            }
            .background(Color("LayoutBg"))
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                ZStack {
                    Circle()
                        .fill(Color("SearchBg"))
                        .frame(width: 65.0, height: 65.0)
                    Image(systemName: "greaterthan")
                }
            }
            .offset(x: UIScreen.main.bounds.width/2 - 60, y: UIScreen.main.bounds.height/2 - 120)
        }
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Spacer()
                Image("image1")
                Text("SwiftUI教程")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Sun Yang")
                    .font(.headline)
                    .fontWeight(.light) 
                    .foregroundColor(Color.gray)
                Spacer()
                Text("朋友们都在读 >")
                    .foregroundColor(Color.gray)
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height - 260)
            .background(Color.white)
        }
        .cornerRadius(30)
        .padding()
    }
}

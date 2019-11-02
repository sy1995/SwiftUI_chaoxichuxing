//
//  AnimationDemo.swift
//  SwiftUIDemo
//
//  Created by sunyang on 27.10.19.
//  Copyright © 2019 test. All rights reserved.
//

import SwiftUI

struct AnimationDemo: View {
    @State var viewState = CGSize.zero
    var body: some View {
        VStack {
//            ScrollView(.horizontal) {
//                HStack {
//                    AnimationCard(bookImage: "image1", bookName: "SwiftUI教程", bookAuthor: "Sun Yang")
//                    AnimationCard(bookImage: "image2", bookName: "MySQL从删库到跑路", bookAuthor: "Yang Sun")
//                }
//            }
            HStack {
                AnimationCard(bookImage: "image1", bookName: "SwiftUI教程", bookAuthor: "Sun Yang")
                    .gesture(DragGesture()
                        .onChanged{value in
                            //只有往左才能滑动,即偏移量必须是负数
                            if(value.translation.width < 0){
                                self.viewState = value.translation
                            }
                        }
                        .onEnded{value in
                            //如果滑动值不超过屏幕半宽-40，就回归原位
                            if(value.translation.width > -(UIScreen.main.bounds.width/2 - 40) ){
                                self.viewState = CGSize.zero
                            }else {
                                //如果滑动超过了，就直接再偏移半个屏幕
                                self.viewState.width = -(UIScreen.main.bounds.width)
                            }
                        }
                )
                    .animation(.spring())
                AnimationCard(bookImage: "image2", bookName: "MySQL从删库到跑路", bookAuthor: "Yang Sun")
                    .animation(.spring())
            }
            .offset(x: UIScreen.main.bounds.width/2 + viewState.width)
            
        }
        .background(Color("LayoutBg"))
        
    }
}

struct AnimationDemo_Previews: PreviewProvider {
    static var previews: some View {
        AnimationDemo()
    }
}

struct AnimationCard: View {
    @State var bookImage: String
    @State var bookName: String
    @State var bookAuthor: String
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Spacer()
                Image(self.bookImage).resizable().frame(width: UIScreen.main.bounds.width - 80, height: UIScreen.main.bounds.height - 460)
                Text(self.bookName)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text(self.bookAuthor)
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

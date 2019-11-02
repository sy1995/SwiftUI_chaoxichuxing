//
//  ContentView.swift
//  chaoxichuxing
//
//  Created by 孙阳 on 2019/10/5.
//  Copyright © 2019 孙阳. All rights reserved.
//

import SwiftUI

var exampleList: [TrafficStatusItem] = [
    TrafficStatusItem(name: "深南南海立交", longitude: "113.931999", latitude: "22.534628", radius: "500", comment: "unknown", rowCircle: RowCircle()),
    TrafficStatusItem(name: "创业路天桥", longitude: "113.92701", latitude: "22.51511", radius: "1000", comment: "unknown", rowCircle: RowCircle()),
]

struct ContentView: View {
    @EnvironmentObject var main: Main
    @State private var isAddMode = false
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(self.main.trafficStatusList, id: \.name){ item in
                        RowView(trafficStatusItem: item)
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move)
                    
                }
                Button(action: {
                    self.isAddMode = true
                }) {
                    AddBtn()
                }
                .offset(x: UIScreen.main.bounds.width/2 - 60, y: UIScreen.main.bounds.height/2 - 120)
                .sheet(isPresented: $isAddMode, onDismiss: {
                    print("dismiss")
                }, content: {
                    AddView().environmentObject(self.main)
                })
                
            }
            .navigationBarTitle("Home")
            .navigationBarItems(leading: EditButton(), trailing:
                Button(action: {
                    self.refreshHome()
                }) {
                    Text("刷新")
                }
            )
        }
        .onAppear(){
            //初始化数据，从归档数据里解压
            print("Home onAppear")
            if let data = UserDefaults.standard.object(forKey: "trafficStatusList"){
                do {
                    if let trafficStatusList = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data as! Data) as? [TrafficStatusItem] {
                        self.main.trafficStatusList = trafficStatusList
                    }
                } catch {
                    print("Couldn't read file.")
                }
                //解压失败就使用示例数据
            } else {
                self.main.trafficStatusList = exampleList
            }
            //刷新
            self.refreshHome()
        }
    }
    //刷新按钮
    func refreshHome() {
        for item in self.main.trafficStatusList {
            item.getValue(key: self.main.key){ (res) in
                item.comment = res.trafficinfo?.evaluation?.description ?? "unknown"
                //移除最后一个%并转double
                item.rowCircle.expediteValue = trimLastChar(str: res.trafficinfo?.evaluation?.expedite ?? "0%")
                item.rowCircle.congestedValue = trimLastChar(str: res.trafficinfo?.evaluation?.congested ?? "0%")
                item.rowCircle.blockedValue = trimLastChar(str: res.trafficinfo?.evaluation?.blocked ?? "0%")
                item.rowCircle.unknownValue = trimLastChar(str: res.trafficinfo?.evaluation?.unknown ?? "0%")
                item.refreshDate = Date()
            }
        }
        //移除最后一个%并转double
        func trimLastChar(str: String)-> Double{
            var temp = str
            temp.removeLast()
            return Double(temp)!
        }
    }
    //右滑删除
    private func delete(at offsets: IndexSet) {
        for index in offsets {
            self.main.trafficStatusList.remove(at: index)
            //归档一次
            do {
                try UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: self.main.trafficStatusList, requiringSecureCoding: false), forKey: "trafficStatusList")
            } catch {
                print("error")
            }
        }
    }
    //编辑模式调整顺序
    private func move(from source: IndexSet, to destination: Int) {
        self.main.trafficStatusList.move(fromOffsets: source, toOffset: destination)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Main())
        //暗色模式
        //            .colorScheme(.dark)
    }
}

struct AddBtn: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color("btnAdd-bg"))
                .frame(width: 65.0, height: 65.0)
                .shadow(color: Color("btnAdd-shadow"), radius: 10)
            
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 65.0, height: 65.0)
                .foregroundColor(Color.blue)
            
        }
    }
}

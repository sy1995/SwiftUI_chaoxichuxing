//
//  AddView.swift
//  chaoxichuxing
//
//  Created by sunyang on 13.10.19.
//  Copyright © 2019 孙阳. All rights reserved.
//

import SwiftUI

struct AddView: View {
    //从环境中读取弹出状态，用此值可以dismiss
    @Environment(\.presentationMode) var presentation
    
    @EnvironmentObject var main: Main
    
    @State var title: String = ""
    @State var longitude: String = ""
    @State var latitude: String = ""
    @State var radius: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    Spacer()
                    Button(action: {
                        
                        //追加到数组后面
                        self.main.trafficStatusList.append(TrafficStatusItem(name: self.title, longitude: self.longitude, latitude: self.latitude, radius: self.radius, comment: "unknown", rowCircle: RowCircle()))
                        //存储归档一下
                        print("archive data")
                        do {
                            try UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: self.main.trafficStatusList, requiringSecureCoding: false), forKey: "trafficStatusList")
                        } catch {
                            print("error")
                        }
                        //收回弹出界面
                        self.presentation.wrappedValue.dismiss()
                    }) {
                        Text("添加")
                    }
                    .padding(.top)
                    .padding(.trailing)
                    
                }
                Form {
                    Section {
                        HStack {
                            //                    Text("名称: ")
                            TextField("请输入名称", text: $title)
                        }
                    }
                    
                    Section {
                        List {
                            TextField("经度 小数点后精度不要超过6位", text: $longitude)
                            TextField("纬度 小数点后精度不要超过6位", text: $latitude)
                        }
                        NavigationLink(destination: WebView(request: URLRequest(url: URL(string: "https://lbs.amap.com/console/show/picker")!))) {
                            Text("经纬度查询")
                        }
                    }
                    
                    Section{
                        TextField("半径 请输入整数范围0-5000", text: $radius)
                    }
                    Text("目前支持城市：北京，上海，广州，深圳，宁波，武汉，重庆，成都，沈阳，南京，杭州，长春，常州，大连，东莞，福州，青岛，石家庄，天津，太原，西安，无锡，厦门，珠海，长沙，苏州，金华，佛山，济南，泉州，嘉兴，西宁，惠州，温州，中山，合肥，乌鲁木齐，台州，绍兴，昆明。")
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding()
                }
                Spacer()
            }
            .navigationBarHidden(true)
            .navigationBarTitle("添加页面")
        }
        .onDisappear(){
            print("addMode disappear")
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}

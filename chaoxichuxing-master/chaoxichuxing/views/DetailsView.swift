//
//  detailsView.swift
//  chaoxichuxing
//
//  Created by 孙阳 on 2019/10/5.
//  Copyright © 2019 孙阳. All rights reserved.
//

import SwiftUI
import Moya

struct DetailsView: View {
        
    @ObservedObject var trafficStatusItem: TrafficStatusItem
    
    @State var key: String
//    @State var longitude: String
//    @State var latitude: String
//    @State var radius: String
    
    @State var failed: Bool = true
    //是否再刷新
    @State var refreshing: Bool = false
    
    @State private var response:TrafficStatusResponse = TrafficStatusResponse(status: "", info: "", infocode: "", trafficinfo: TrafficInfo(description: "",evaluation: Evaluation(expedite: "", congested: "", blocked:"", unknown: "", status: "",description:""),roads: [Road(name: "", status: "", direction: "", angle: "", speed: "", lcodes: "",polyline: "")]))
    
    var body: some View {
        ScrollView {
            VStack {
                 if !failed {
                    if self.response.status == "1" && self.response.infocode == "10000"{
                        ResultView(result: self.$response)
                            .animation(.spring())
                            .blur(radius: self.refreshing ? 5 : 0)
                    }
                }
                Spacer()
            }
            Divider()
            HStack {
                Spacer()
                Text("\(self.trafficStatusItem.longitude)/\(self.trafficStatusItem.latitude)/\(self.trafficStatusItem.radius)")
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
                    .fixedSize()
//                    .padding(.trailing)
            }
        }
        .padding(.leading)
        .padding(.trailing)
        .onAppear(){
            //一进入页面自动刷新
            self.refreshTrafficStatus()
        }
        //注意这个地方直接预览的话看不到，在下面需要把页面套入到navigation view里
        .navigationBarItems(trailing: Button(action: {
            self.refreshTrafficStatus()
        }) {
            Text("刷新")
        })
        
    }
    //刷新的函数
    func refreshTrafficStatus(){
        self.refreshing = true
        self.trafficStatusItem.getValue(key: self.key){ (res) in
            self.response = res
            self.failed = false
            //刷新trafficStatusItem的comment等值
            self.trafficStatusItem.comment = self.response.trafficinfo?.evaluation?.description ?? "unknown"
            print("-----------Done")
            self.refreshing = false
        }
        print("------------pressBtn")
    }
    //异步执行
//    func getTrafficStatus(key: String, longitude: String,latitude: String, radius: String) {
//        let location = longitude + "," + latitude
//        print(location)
//        let provier = MoyaProvider<TrafficStatusService>()
//        provier.request(.circle(key: key, location: location, radius: radius, extensions: "all")) { (result) in
//            switch result {
//            case let .success(response):
//                print(response.data)
//                self.response = try! JSONDecoder().decode(TrafficStatusResponse.self,from: response.data)
//                self.failed = false
//            case let .failure(error):
//                print("网络连接失败\(error)")
//                break
//            }
//        }
//    }
}
struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let trafficStatusItem = TrafficStatusItem(name: "Test", longitude: "113.931999", latitude: "22.534628", radius: "1000", comment: "unknown", rowCircle: RowCircle())
        return NavigationView {
            DetailsView(trafficStatusItem: trafficStatusItem, key: "7037b8cf71db60e414ced78db2fa1e93")
        }
    }
}

struct ResultView: View {
    @Binding var result:TrafficStatusResponse
    
    var body: some View {
        VStack {
            Text(self.result.trafficinfo?.evaluation?.description ?? "")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
            Text(self.result.trafficinfo?.description ?? "")
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                //为了不被压缩需要使用这个
                .fixedSize(horizontal: false, vertical: true)
                .padding()
                .background(Color("background"))
            Spacer()
            
            HStack{
                VStack(alignment: .leading) {
                    Text("畅通")
                    Text(self.result.trafficinfo?.evaluation?.expedite ?? "")
                        .fixedSize(horizontal: true, vertical: true)
                }
                .padding()
                .background(Color("expedite-Color"))
                .cornerRadius(10)

                VStack(alignment: .leading) {
                    Text("缓行:")
                    Text(self.result.trafficinfo?.evaluation?.congested ?? "")
                        .fixedSize(horizontal: true, vertical: true)
                }
                .padding()
                .background(Color("congested-Color"))
                .cornerRadius(10)
                
                VStack(alignment: .leading) {
                    Text("拥堵:")
                    Text(self.result.trafficinfo?.evaluation?.blocked ?? "")
                        .fixedSize(horizontal: true, vertical: true)
                }
                .padding()
                .background(Color("blocked-Color"))
                .cornerRadius(10)

                VStack {
                    Text("未知:")
                    Text(self.result.trafficinfo?.evaluation?.unknown ?? "")
                        .fixedSize(horizontal: true, vertical: true)
                }
                .padding()
                .background(Color("unknown-Color"))
                .cornerRadius(10)

            }
            Spacer()
//            Text(self.result.trafficinfo?.roads?[0].name ?? "")
            ScrollView(.horizontal) {
                HStack {
                    ForEach((self.result.trafficinfo?.roads ?? nil)!){ road in
                        RoadDetailsView(road: road)
                    }
                }
            }
            .frame(height: 120.0)
            
        }
    }
}

struct RoadDetailsView: View {
    var road: Road
    var roadStatusDic: [String: String] = ["0": "未知", "1": "畅通", "2": "缓行", "3": "拥堵", "4": "严重拥堵"]
    var roadStatusColor: [String: Color] = ["0": Color("unknown-Color"), "1": Color("expedite-Color"), "2": Color("congested-Color"), "3": Color("blocked-Color"), "4": Color.red]
    var body: some View {
        VStack(alignment: .leading, spacing: 5.0) {
            Text(self.road.name ?? "")
                .font(.headline)
                .foregroundColor(Color.primary)
            Text(self.road.direction ?? "")
                .font(.subheadline)
                .foregroundColor(Color.secondary)
            Text("\(roadStatusDic[self.road.status ?? "0"]!)")
                .font(.subheadline)
                .foregroundColor(Color.secondary)
//            Text( self.road.status ?? "")
            Text("时速" + (self.road.speed ?? "") + "km/h")
                .font(.subheadline)
                .foregroundColor(Color.secondary)
        }
        .padding()
        .background(roadStatusColor[self.road.status ?? "0"])
        .cornerRadius(30)
    }
}

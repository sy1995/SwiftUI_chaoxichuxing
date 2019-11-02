//
//  RowView.swift
//  chaoxichuxing
//
//  Created by 孙阳 on 2019/10/7.
//  Copyright © 2019 孙阳. All rights reserved.
//

import SwiftUI

struct RowView: View {
    @EnvironmentObject var main: Main
    @ObservedObject var trafficStatusItem: TrafficStatusItem
    
    var body: some View {
        NavigationLink(destination: DetailsView(trafficStatusItem: trafficStatusItem, key: self.main.key)) {
            HStack {
                VStack(alignment: .leading) {
                    Text(self.trafficStatusItem.name)
                        .font(.title)
                    Spacer()
                        .frame(height: 10.0)
                    HStack {
                        Text(self.trafficStatusItem.comment)
                            .font(.subheadline)
                        Spacer()
                        Text(self.date2String(self.trafficStatusItem.refreshDate, dateFormat: "yyyy-MM-dd HH:mm:ss"))
                            .font(.subheadline)
                    }
                }
                Spacer()
                VStack {
                    DrawCircle(expediteValue: self.$trafficStatusItem.rowCircle.expediteValue, congestedValue: self.$trafficStatusItem.rowCircle.congestedValue, blockedValue: self.$trafficStatusItem.rowCircle.blockedValue, unknownValue: self.$trafficStatusItem.rowCircle.unknownValue)
                }
                .frame(width: 60, height: 60)
                .animation(.spring())
            }
            .padding()
        }
    }
    //时间转字符串
    func date2String(_ date:Date, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        let trafficStatusItem = TrafficStatusItem(name: "Test", longitude: "113.931999", latitude: "22.534628", radius: "1000", comment: "unknown", rowCircle: RowCircle())
        return RowView(trafficStatusItem: trafficStatusItem).environmentObject(Main())
    }
}

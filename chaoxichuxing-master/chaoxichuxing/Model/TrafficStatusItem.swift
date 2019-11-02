//
//  TrafficStatusItem.swift
//  chaoxichuxing
//
//  Created by 孙阳 on 2019/10/6.
//  Copyright © 2019 孙阳. All rights reserved.
//

import Foundation
import Combine
import Moya

class Main: ObservableObject{
    @Published var trafficStatusList: [TrafficStatusItem] = []
    @Published var key = "7037b8cf71db60e414ced78db2fa1e93"
}

class TrafficStatusItem: NSObject, NSCoding, ObservableObject {
    func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        coder.encode(self.longitude, forKey: "longitude")
        coder.encode(self.latitude, forKey: "latitude")
        coder.encode(self.radius, forKey: "radius")
        coder.encode(self.comment, forKey: "comment")
        coder.encode(self.refreshDate, forKey: "refreshDate")
    }

    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        self.longitude = aDecoder.decodeObject(forKey: "longitude") as? String ?? ""
        self.latitude = aDecoder.decodeObject(forKey: "latitude") as? String ?? ""
        self.radius = aDecoder.decodeObject(forKey: "radius") as? String ?? ""
        self.comment = aDecoder.decodeObject(forKey: "comment") as? String ?? ""
        self.rowCircle = aDecoder.decodeObject(forKey: "rowCircle") as? RowCircle ?? RowCircle()
        self.refreshDate = aDecoder.decodeObject(forKey: "refreshDate") as? Date ?? Date()
    }
//
    @Published var name: String
    var longitude: String
    var latitude: String
    var radius: String
    @Published var comment: String
    @Published var rowCircle: RowCircle
    @Published var refreshDate: Date
    
    init(name: String, longitude: String, latitude: String, radius: String, comment: String, rowCircle: RowCircle) {
        self.name = name
        self.longitude = longitude
        self.latitude = latitude
        self.radius = radius
        self.comment = comment
        self.rowCircle = rowCircle
        self.refreshDate = Date(timeIntervalSince1970: 1571328000)
    }
    
    func getValue(key: String, completion: @escaping (TrafficStatusResponse) -> Void) {
        let location = self.longitude + "," + self.latitude
        print(location)
        let provier = MoyaProvider<TrafficStatusService>()
        provier.request(.circle(key: key, location: location, radius: self.radius, extensions: "all")) { (result) in
            switch result {
            case let .success(response):
                print(response.data)
                let res = try! JSONDecoder().decode(TrafficStatusResponse.self,from: response.data)
                completion(res)
            case let .failure(error):
                print("网络连接失败\(error)")
                break
            }
        }
    }
    
}

class RowCircle: ObservableObject {
    @Published var expediteValue: Double = 0.0
    @Published var congestedValue: Double = 0.0
    @Published var blockedValue: Double = 0.01
    @Published var unknownValue: Double = 0.0
}


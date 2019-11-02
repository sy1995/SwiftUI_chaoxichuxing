//
//  TrafficStatusResponse.swift
//  chaoxichuxing
//
//  Created by 孙阳 on 2019/10/5.
//  Copyright © 2019 孙阳. All rights reserved.
//

import Foundation

//？代表可能返回空值
class TrafficStatusResponse: Codable{

    var status: String
    var info: String
    var infocode: String
    var trafficinfo: TrafficInfo?
    
    init(status: String, info: String, infocode: String, trafficinfo: TrafficInfo){
        self.status = status
        self.info = info
        self.infocode = infocode
        self.trafficinfo = trafficinfo
    }
    
}

class TrafficInfo: Codable {
    
    var description: String?
    var evaluation:Evaluation?
    var roads:[Road]?
    
    init(description: String, evaluation: Evaluation, roads: [Road]){
        self.description = description
        self.evaluation = evaluation
        self.roads = roads
    }
}

class Evaluation: Codable{
    
    var expedite: String?
    var congested: String?
    var blocked: String?
    var unknown: String?
    var status: String?
    var description: String?
    
    init(expedite: String, congested: String, blocked: String, unknown: String, status: String,description: String){
        self.expedite = expedite
        self.congested = congested
        self.blocked = blocked
        self.unknown = unknown
        self.status = status
        self.description = description
    }
}

class Road: Codable, Identifiable{
    var name: String?
    var status: String?
    var direction: String?
    var angle: String?
    var speed: String?
    var lcodes: String?
    var polyline: String?
    
    init(name: String, status: String, direction: String, angle: String, speed: String, lcodes: String,polyline: String){
        self.name = name
        self.status = status
        self.direction = direction
        self.angle = angle
        self.speed = speed
        self.lcodes = lcodes
        self.polyline = polyline
    }
}

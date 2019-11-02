//
//  getUrl.swift
//  chaoxichuxing
//
//  Created by 孙阳 on 2019/10/5.
//  Copyright © 2019 孙阳. All rights reserved.
//

import Foundation
import Moya

enum TrafficStatusService {
    case circle(key: String, location: String, radius: String, extensions: String)
    //    case topicDetail(id: String)
}

extension TrafficStatusService: TargetType{
    //定义接口请求路径
    var path: String {
        switch self {
        case .circle:
            return "/circle"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .circle:
            return .get
        }
    }
    /// 这个是做单元测试模拟的数据，必须要实现，只在单元测试文件中有作用
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case let .circle(key, location, radius, extensions):
            let params: [String:Any] = ["key":key, "location": location, "radius": radius, "extensions": extensions]
            //可选参数的写法
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
        
    }
    // 定义请求头，可以加上数据类型，cookie等信息
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var baseURL: URL {
        return URL(string: "https://restapi.amap.com/v3/traffic/status")!
    }
}

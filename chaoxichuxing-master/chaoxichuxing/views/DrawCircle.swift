//
//  DrawCircle.swift
//  chaoxichuxing
//
//  Created by sunyang on 17.10.19.
//  Copyright © 2019 孙阳. All rights reserved.
//

import SwiftUI

struct DrawCircle: View {
    @Binding var expediteValue: Double
    @Binding var congestedValue: Double
    @Binding var blockedValue: Double
    @Binding var unknownValue: Double
    
    var expediteDegreeEnd: Double
    var congestedDegreeEnd: Double
    var blockedDegreeEnd: Double
    
    //初始化函数
    init(expediteValue: Binding<Double>, congestedValue: Binding<Double>, blockedValue: Binding<Double>, unknownValue: Binding<Double>) {
        self._expediteValue = expediteValue
        self._congestedValue = congestedValue
        self._blockedValue = blockedValue
        self._unknownValue = unknownValue
        //开始要从270度开始，这是12点钟的位置，所以要加了之后对360取余
        self.expediteDegreeEnd = (270 + (360 * expediteValue.wrappedValue / 100)) .truncatingRemainder(dividingBy: 360)
        //下一段是对上一个值开始作为起点，相加作为终点
        self.congestedDegreeEnd = (self.expediteDegreeEnd + (360 * congestedValue.wrappedValue / 100) )
            .truncatingRemainder(dividingBy: 360)
        self.blockedDegreeEnd = (self.congestedDegreeEnd + (360 * blockedValue.wrappedValue / 100) )
            .truncatingRemainder(dividingBy: 360)
    }
    
    var body: some View {
        
        //为了更好地提供相对布局，包裹在这个容器中能够更好地提供相对大小
        GeometryReader { geometry in
            ZStack {
                //畅通路段绿色表示
                Path { path in
                    //100%的时候会画不出来,三元运算符处理一下
                    path.addArc(center: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2), radius: geometry.size.width / 2, startAngle: Angle.init(degrees: 270), endAngle: Angle.init(degrees: (self.expediteDegreeEnd != 270) ? self.expediteDegreeEnd : 269.99), clockwise: false)
                }
                .stroke(lineWidth: 8)
//                                    .fill(Color("expedite-Color"))
                    //渐变效果
                    //这里endAngle需要+360
                    .fill(AngularGradient(gradient: Gradient(colors: [Color("expedite-Color"), Color("congested-Color")]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, startAngle: Angle.init(degrees: 270), endAngle: Angle.init(degrees: self.expediteDegreeEnd + 360)))
                
                //缓行橙色
                Path { path in
                    path.addArc(center: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2), radius: geometry.size.width / 2, startAngle: Angle.init(degrees: self.expediteDegreeEnd), endAngle: Angle.init(degrees: self.congestedDegreeEnd), clockwise: false)
                }
                .stroke(lineWidth: 8)
                    //                .fill(Color("congested-Color"))
                    .fill(AngularGradient(gradient: Gradient(colors: [Color("congested-Color"), Color("blocked-Color")]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, startAngle: Angle.init(degrees: self.expediteDegreeEnd ), endAngle: Angle.init(degrees: self.congestedDegreeEnd)))

                //拥堵红色
                Path { path in
                    path.addArc(center: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2), radius: geometry.size.width / 2, startAngle: Angle.init(degrees: self.congestedDegreeEnd), endAngle: Angle.init(degrees: self.blockedDegreeEnd), clockwise: false)
                }
                .stroke(lineWidth: 8)
//                .fill(Color("blocked-Color"))
                    .fill(AngularGradient(gradient: Gradient(colors: [Color("blocked-Color"), Color("unknown-Color")]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, startAngle: Angle.init(degrees: self.congestedDegreeEnd), endAngle: Angle.init(degrees: self.blockedDegreeEnd)))

                //未知灰色，终点就是270,起点判断是否会大于270，如果大于就置为270
                //终点多一点点是为了解决unkonwn为零时全绘制成灰色
                Path { path in
                    path.addArc(center: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2), radius: geometry.size.width / 2, startAngle: Angle.init(degrees: self.blockedDegreeEnd < 270 ? self.blockedDegreeEnd  : 270), endAngle: Angle.init(degrees: 270.01), clockwise: false)
                }
                .stroke(lineWidth: 8)
                .fill(Color("unknown-Color"))
                
            }
            
//            Text("畅通：\(String(format: "%.2f", self.$expediteValue.wrappedValue))%")
        }
    }
}


struct DrawCircle_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DrawCircle(expediteValue: .constant(48.21), congestedValue: .constant(32.75), blockedValue: .constant(13.61), unknownValue: .constant(5.43))
            //预览暗色模式
            DrawCircle(expediteValue: .constant(82.81), congestedValue: .constant(12.69), blockedValue: .constant(3.21), unknownValue: .constant(1.29))
                .environment(\.colorScheme, .dark)
                .background(Color.black)
                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
                .previewDisplayName("iPhone SE")
        }
    }
}
    

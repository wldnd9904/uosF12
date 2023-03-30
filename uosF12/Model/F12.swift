//
//  F12.swift
//  uosF12
//
//  Created by 최지웅 on 2023/03/30.
//

import Foundation

public struct F12 {
    var currentSum:Int = 0
    var totalSum:Int = 0
    var avg:Float = 0.0
    var items:[F12Item] = []
    static let demo = F12(currentSum: 6, totalSum: 12, avg: 4.33, items: [uosF12.F12Item(name: "컴파일러구성", pnt: 3, grade: 4.5, gradeStr: "A+"), uosF12.F12Item(name: "화일처리론", pnt: 3, grade: 4.5, gradeStr: "A+")])
}

public struct F12Item {
    var name:String = ""
    var pnt:Int = 0
    var grade:Float = 0.0
    var gradeStr:String = ""
    static let demo = F12Item(name: "클라우드컴퓨팅", pnt: 3, grade: 4.5, gradeStr: "A+")
}

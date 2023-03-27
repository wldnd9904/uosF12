//
//  Registration.swift
//  uosF12
//
//  Created by 최지웅 on 2023/03/27.
//

import Foundation

public struct Registration {
    var name:String = ""
    var pnt:Int = 0
    var isMajor:Bool = false
    static let demo = Registration(name:"컴파일러구성",pnt:3, isMajor: true)
    static let demo2 = Registration(name:"공학소양세미나",pnt:2, isMajor: false)
}

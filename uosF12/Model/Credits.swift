//
//  Credits.swift
//  uosF12
//
//  Created by 최지웅 on 2023/03/24.
//

import Foundation

public class Credits {
    var min: Int = 0
    var max: Int = 0
    var cnt: Int = 0
    var pnt: Int = 0
    var CreditItems: [CreditItem] = []
    var major: CreditItem = CreditItem()
    var GE: CreditItem = CreditItem()
    var etc: [CreditItem] = []
    static var demo: Credits {
        let ret = Credits()
        ret.major = CreditItem.demo
        ret.GE = CreditItem.demo
        ret.etc = [CreditItem.demo,CreditItem.demo]
        return ret
    }
}

public class CreditItem {
    var parent:String = ""
    var name: String = ""
    var min: Int = 0
    var max: Int = 0
    var cnt: Int = 0
    var pnt: Int = 0
    var child: [CreditItem] = []
    static var demo: CreditItem {
        let ret = CreditItem()
        ret.name = "교양"
        ret.min = 30
        ret.max = 50
        ret.cnt = 5
        ret.pnt = 16
        let child1 = CreditItem()
        child1.name = "교양필수"
        child1.min = 30
        child1.max = 50
        child1.cnt = 5
        child1.pnt = 16
        ret.child.append(child1)
        let child2 = CreditItem()
        child2.name = "교양선택"
        child2.min = 30
        child2.max = 50
        child2.cnt = 5
        child2.pnt = 16
        ret.child.append(child2)
        return ret
    }
}

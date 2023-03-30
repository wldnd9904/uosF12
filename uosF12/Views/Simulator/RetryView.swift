//
//  RetryView.swift
//  uosF12
//
//  Created by 최지웅 on 2023/03/31.
//

import SwiftUI

struct RetryView: View {
    @Binding var subject:Subject
    var body: some View {
        if(subject.retryable){
            HStack {
                VStack{
                    HStack{
                        Text(subject.korName)
                            .font(.headline)
                        Spacer()
                    }
                    HStack{
                        Text("\(String(subject.year))년 \(subject.semester.rawValue) \(subject.pnt)학점")
                            .font(.subheadline)
                        if(subject.subjectDiv.rawValue.contains("전공")) {
                            Text("전공")
                                .font(.subheadline)
                        }
                        Spacer()
                    }
                }
                Spacer()
                HStack{
                    Text(subject.gradeStr)
                        .foregroundColor(gradeColor(subject.gradeStr))
                    Text("→")
                    Picker("등급",selection: $subject.grade){
                        Text("A+").tag(Float(4.5))
                        Text("A0").tag(Float(4.0))
                        Text("B+").tag(Float(3.5))
                        Text("B0").tag(Float(3.0))
                        Text("C+").tag(Float(2.5))
                        Text("C0").tag(Float(2.0))
                        Text("D+").tag(Float(1.5))
                        Text("D0").tag(Float(1.0))
                        Text("F").tag(Float(0))
                    }
                    .pickerStyle(.menu)
                }
            }
        }
    }
}

struct RetryView_Previews: PreviewProvider {
    static var previews: some View {
        RetryView(subject: .constant(Subject.demo))
            .environmentObject(ModelData())
    }
}

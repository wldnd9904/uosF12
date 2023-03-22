//
//  Subject.swift
//  uosF12
//
//  Created by 최지웅 on 2023/03/21.
//

import SwiftUI

struct SubjectView: View {
    var subject:Subject
    @State private var showDetail = false
    
    
    var body: some View {
        VStack{
            HStack {
                Text(subject.korName)
                    .font(.title3)
                Spacer()
                if showDetail {
                        Text(String(subject.grade))
                        .foregroundColor(gradeColor(subject.gradeStr))
                } else {
                    Text(subject.gradeStr)
                        .foregroundColor(gradeColor(subject.gradeStr))
                }
                Button {
                    withAnimation{
                        showDetail.toggle()
                    }
                } label: {
                    Label("Detail", systemImage: "chevron.right")
                        .labelStyle(.iconOnly)
                        .imageScale(.large)
                        .rotationEffect(.degrees(showDetail ? 90 : 0))
                        .padding()
                }
            }
            if showDetail {
                HStack{
                    Text(subject.engName)
                        .font(.subheadline)
                    Spacer()
                    Text(subject.subjectDiv.rawValue)
                }
                HStack{
                    Text(String(subject.year)+"년")
                    Text(subject.semester.rawValue)
                    Spacer()
                    if subject.retry {
                        Text("재수강")
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
}

struct SubjectView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            SubjectView(subject:Subject.demo)
                .padding(.bottom,10)
            SubjectView(subject:Subject.demo)
            Spacer()
        }.padding()
    }
}

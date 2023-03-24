//
//  CreditView.swift
//  uosF12
//
//  Created by 최지웅 on 2023/03/24.
//

import SwiftUI

struct CreditView: View {
    let credit: CreditItem
    @State private var showDetail: Bool = false
    var body: some View {
        VStack{
            HStack {
                Text("\(credit.name): \(credit.cnt)개, \(credit.pnt)/\(credit.min)학점")
                    .font(.headline)
                if credit.max > 0 {
                    Text("최대이수제한: \(credit.max)학점")
                        .font(.headline)
                }
                Spacer()
                if !credit.child.isEmpty {
                    Button {
                        withAnimation{
                            showDetail.toggle()
                        }
                    } label: {
                        Label("Detail", systemImage: "chevron.right")
                            .labelStyle(.iconOnly)
                            .imageScale(.large)
                            .rotationEffect(.degrees(showDetail ? 90 : 0))
                            .padding(10)
                    }
                }
            }
            if showDetail {
                    VStack{
                        ForEach(credit.child, id: \.name){
                            CreditView(credit:$0)
                        }
                        .padding(.leading,10)
                }
            }
        }
    }
}
struct CreditView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            CreditView(credit:CreditItem.demo)
                .padding(.bottom,10)
            Divider()
            CreditView(credit:CreditItem.demo)
            Spacer()
        }.padding()
    }
}

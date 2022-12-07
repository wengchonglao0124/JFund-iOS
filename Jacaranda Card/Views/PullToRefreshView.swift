//
//  PullToRefreshView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 8/12/2022.
//

import SwiftUI

struct PullToRefreshView: View {
    
    var coordinateSpaceName: String
        var onRefresh: () -> Void
        
        @State var needRefresh: Bool = false
        
        var body: some View {
            GeometryReader { geo in
                if (geo.frame(in: .named(coordinateSpaceName)).midY > 50) {
                    Spacer()
                        .onAppear {
                            needRefresh = true
                        }
                } else if (geo.frame(in: .named(coordinateSpaceName)).maxY < 10) {
                    Spacer()
                        .onAppear {
                            if needRefresh {
                                needRefresh = false
                                onRefresh()
                            }
                        }
                }
                HStack {
                    Spacer()
                    if needRefresh {
                        ProgressView()
                    } else {
                        Image(systemName: "arrow.down.square")
                            .foregroundColor(Color(red: 151/255, green: 151/255, blue: 151/255))
                    }
                    Spacer()
                }
            }.padding(.top, -50)
        }
}

struct PullToRefreshView_Previews: PreviewProvider {
    static var previews: some View {
        PullToRefreshView(coordinateSpaceName: "") {
            
        }
    }
}

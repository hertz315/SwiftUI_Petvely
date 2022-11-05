//
//  ContentView.swift
//  Petvely
//
//  Created by Hertz on 11/5/22.
//

import SwiftUI
import MapKit

struct ContentView: View {

    
    // MARK: - 바디
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("홈")
                }
            Text("지역 검색 화면")
                .tabItem {
                    Image(systemName: "magnifyingglass.circle.fill")
                    Text("검색")
                }
            Text("메세지 화면 샌드버드 연동")
                .tabItem {
                    Image(systemName: "message")
                    Text("메세지")
                }
            Text("프로필 화면 / 즐겨찾기 / 리뷰 ")
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("프로필")
                }
        }
        .accentColor(.orange)
        
        
    }
    
    
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

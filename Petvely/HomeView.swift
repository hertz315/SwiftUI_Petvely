//
//  HomeView.swift
//  Petvely
//
//  Created by Hertz on 11/5/22.
//

import SwiftUI
import MapKit
//import ExytePopupView

struct HomeView: View {
    
    // 고기굽기
    // @StateObject 처음으로 메모리에 올리는 용도
    @StateObject var viewModel = HomeVM()
    
    //서울 좌표
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.5666791, longitude: 126.9782914), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    /// 홈화면
    var body: some View {
        
        VStack(spacing: 0) {
            Map(coordinateRegion: $region)
                .frame(height: 300)
                .cornerRadius(16, corners: .bottomLeft)
                .cornerRadius(16, corners: .bottomRight)
                .overlay{
                    Text("\(self.viewModel.boundaryString) km")
                        .foregroundColor(.white)
                        .padding(.all, 5)
                        .background(Color.red)
                        .cornerRadius(8)
                        .offset(x: 150, y: 120)
                }
            List {
                ListButton(viewModel: self.viewModel)
                    .listRowBackground(Color.clear)
                ForEach(0..<10, content: { _ in
                    Groomer()
                })
                .listRowInsets(EdgeInsets())
            }
            .listStyle(.plain)
            .listRowSeparator(.hidden)
            .scrollContentBackground(.hidden)
            .frame(maxWidth:.infinity)
            .padding(.leading, 5)
            
        }
    }
}



/// 리스트 헤더부분 버튼
struct ListButton: View {
    
    @ObservedObject var viewModel: HomeVM
    // 팝업 띄우기
    @State var showingAlert: Bool = false
    @State var selection: String = "10Km"
    
    var body: some View {
        
        HStack {
            Button {
                
            } label: {
                Text("인기순")
                    .foregroundColor(.gray)
            }
            Text("|")
                .foregroundColor(.gray)
            Button {
                
            } label: {
                Text("거리순")
                    .foregroundColor(.gray)
            }
            Spacer()
            Button {
                showingAlert = true
            } label: {
                HStack {
                    Image(systemName: "figure.walk")
                    Text("\(self.viewModel.boundary) km")
                    Image(systemName: "chevron.down")
                }
                .foregroundColor(.black)
            }
            .confirmationDialog("거리를 선택해주세요", isPresented: $showingAlert) {
                Button("10Km") {
                    self.viewModel.boundary = 10
                }
                Button("20Km") {
                    self.viewModel.boundary = 20
                }
                Button("30Km") {
                    self.viewModel.boundary = 30
                }
                Button("40Km") {
                    self.viewModel.boundary = 40
                }
                Button("50Km") {
                    self.viewModel.boundary = 50
                }
            }
        }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}

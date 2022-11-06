//
//  HomeView.swift
//  Petvely
//
//  Created by Hertz on 11/5/22.
//

import SwiftUI
import MapKit

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let contactNumber: String
    let coordinate: CLLocationCoordinate2D
}

struct HomeView: View {
    
    // 고기굽기
    // @StateObject 처음으로 메모리에 올리는 용도
    @StateObject var viewModel = HomeVM()
    
    //서울 좌표
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.541, longitude: 126.986), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    let location = [
        Location(name: "애견견출지", contactNumber: "010-7100-1624", coordinate: .init(latitude: 37.660471, longitude: 127.057041)),
        Location(name: "도그송", contactNumber: "02-900-9069", coordinate: .init(latitude: 37.645937, longitude: 127.039569)),
        Location(name: "365동물병원", contactNumber: "02-6402-0365", coordinate: .init(latitude: 37.662920, longitude: 127.046407)),
        Location(name: "참동물병원", contactNumber: "02-952-0089", coordinate:  .init(latitude: 37.665024, longitude: 127.057041)),
        Location(name: "써니애견미용실", contactNumber: "02-992-2229", coordinate: .init(latitude: 37.666047, longitude: 127.057041)),
        Location(name: "버블펫", contactNumber: "02-987-9808", coordinate: .init(latitude: 37.624601, longitude: 127.032156)),
        Location(name: "샬롱드라벨리", contactNumber: "050-71335-8288", coordinate: .init(latitude: 37.602710, longitude: 127.020329)),
        Location(name: "퍼스트동물병원", contactNumber: "02-911-7582", coordinate: .init(latitude: 37.619536, longitude: 127.050711)),
        Location(name: "리즈강아지미용실", contactNumber: "02-989-0575", coordinate: .init(latitude: 37.615293, longitude: 127.033649)),
        Location(name: "니니애견미용실", contactNumber: "02-977-9981", coordinate: .init(latitude: 37.616309, longitude: 127.075469)),
        Location(name: "이모네강아지", contactNumber: "010-2693-3783", coordinate: .init(latitude: 37.617362, longitude: 127.081444)),
        Location(name: "영하개", contactNumber: "010-2873-9798", coordinate: .init(latitude: 37.624505, longitude: 127.079624)),
        Location(name: "시현펫살롱", contactNumber: "02-957-7900", coordinate: .init(latitude: 37.598477, longitude: 127.067595)),
        Location(name: "봄봄동물병원", contactNumber: "02-969-7579", coordinate: .init(latitude: 37.590312, longitude: 127.054140)),
        Location(name: "해피도그애견미용실", contactNumber: "02-966-5946", coordinate: .init(latitude: 37.585106, longitude: 127.050795)),
        Location(name: "앙꼬네강아지미용실", contactNumber: "02-2295-4569", coordinate: .init(latitude: 37.559919, longitude: 127.036634)),
        Location(name: "N24BEAUTYLAB 도곡동점", contactNumber: "02-573-2266", coordinate: .init(latitude: 37.484444, longitude: 127.045847)),
        Location(name: "펫그루밍샵 몽슈", contactNumber: "031-706-1331", coordinate: .init(latitude: 37.374557, longitude: 127.145636)),
        Location(name: "도그넷애견미용실고양이미용실", contactNumber: "02-888-9556", coordinate: .init(latitude: 37.481638, longitude: 126.942032)),
        Location(name: "올리비아 애견미용", contactNumber: "031-529-0617", coordinate: .init(latitude: 37.652071, longitude: 127.115449))
    ]
    
    
    /// 홈화면
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {               
                Map(coordinateRegion: $region,
                    interactionModes: .all,
                    showsUserLocation: true,
                    userTrackingMode: nil,
                    annotationItems: location) { location in
                    MapMarker(coordinate: location.coordinate, tint: Color.orange)
                    
                }
              
                    .frame(height: 300)
                    .cornerRadius(16, corners: .bottomLeft)
                    .cornerRadius(16, corners: .bottomRight)
                List {
                    ListButton(viewModel: self.viewModel)
                    ForEach(0..<10, content: { _ in
                        NavigationLink(destination: GroomerDetailView("asdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdf", lineLimit: 2)) {
                            Groomer()
                        }
                    })
                    .listRowInsets(EdgeInsets())
                }
                .listStyle(.plain)
                .listRowSeparator(.hidden)
                .frame(maxWidth:.infinity)
                .padding(.leading, 5)
                
            }
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
                .onTapGesture {
                    self.showingAlert = true
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
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}

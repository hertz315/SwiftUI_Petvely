//
//  GroomerDetailView.swift
//  Petvely
//
//  Created by Hertz on 11/5/22.
//

import SwiftUI

struct GroomerDetailView: View {
    
    @State private var expanded: Bool = false
    @State private var truncated: Bool = false
    @State private var shrinkText: String
    @State private var isRendered: Bool = false
    //    @State var showingAlert: Bool = false
    //
    //    var phoneNumber = "010-9962-3015"
    
    var rows: [GridItem] =
    Array(repeating: .init(.fixed(150)), count: 2)
    
    private var text: String = ""
    let lineLimit: Int
    private var moreLessText: String {
        if !truncated {
            return ""
        } else {
            return self.expanded ? "" : " 더보기"
        }
    }
    
    let font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
    
    init(_ text: String, lineLimit: Int) {
        self.text = text
        self.lineLimit = lineLimit
        _shrinkText = State(wrappedValue: text)
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView() {
                VStack(spacing: 10) {
                    
                    // MARK: - 매장이미지 정보
                    Group{
                        LazyHStack {
                            PageView() // 이미지 슬라이더
                        }
                        
                        Text("개의온도")
                        
                        Text("👍🏻28")
                            .font(.body)
                            .foregroundColor(.gray)
                        
                        // MARK: - 더보기 상태
                        Group {
                            if !truncated {
                                Text(text)
                            } else {
                                Text(self.expanded ? text : (shrinkText + "..."))
                                + Text(moreLessText)
                                    .underline()
                            }
                        }
                        .font(Font(font))
                        .multilineTextAlignment(.center)
                        .lineLimit(expanded ? nil : lineLimit)
                        .padding(.horizontal, 16)
                        .onTapGesture {
                            if truncated {
                                expanded.toggle()
                            }
                        }
                        .background(
                            Text(text)
                                .lineLimit(lineLimit)
                                .background(GeometryReader { visibleTextGeometry in
                                    Color.clear
                                        .onChange(of: isRendered) { _ in
                                            guard isRendered else {
                                                return
                                            }
                                            let size = CGSize(width: visibleTextGeometry.size.width, height: .greatestFiniteMagnitude)
                                            let style = NSMutableParagraphStyle()
                                            style.lineSpacing = 4
                                            style.lineBreakStrategy = .hangulWordPriority
                                            let attributes: [NSAttributedString.Key: Any] = [
                                                NSAttributedString.Key.font: font,
                                                NSAttributedString.Key.paragraphStyle: style
                                            ]
                                            
                                            /// Line Limit 내에서 문제 없이 보여질 경우 체크
                                            let pureAttributedText = NSAttributedString(string: shrinkText, attributes: attributes)
                                            let pureBoundingRect = pureAttributedText.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
                                            if abs(pureBoundingRect.size.height - visibleTextGeometry.size.height) < 1 {
                                                return
                                            }
                                            
                                            /// Binary Search 방식으로 '... 더보기'로 라인이 적절히 끊길 수 있는 index를 찾는다
                                            var low = 0
                                            var height = shrinkText.count
                                            var mid = height
                                            while ((height - low) > 1) {
                                                let attributedText = NSAttributedString(string: shrinkText + "... " + moreLessText, attributes: attributes)
                                                let boundingRect = attributedText.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
                                                if boundingRect.size.height > visibleTextGeometry.size.height {
                                                    truncated = true
                                                    height = mid
                                                    mid = (height + low) / 2
                                                } else {
                                                    if mid == text.count {
                                                        break
                                                    } else {
                                                        low = mid
                                                        mid = (low + height) / 2
                                                    }
                                                }
                                                shrinkText = String(text.prefix(mid))
                                            }
                                        }
                                        .onAppear {
                                            isRendered = true
                                        }
                                })
                                .hidden() // Hide the background
                        )
                        
                        
                    }
                    Divider()
                    // MARK: - 매장정보
                    StoreInfo()
                    StoreInfoButton()
                    // MARK: - 포트폴리오
                    Group {
                        HStack {
                            Text("포트폴리오")
                                .font(.headline)
                            Spacer()
                        }
                        .padding()
                        .background(Color.yellow)
                        /// 그리드
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: rows, alignment: .top) {
                                ForEach((0...30), id: \.self) { _ in
                                    Rectangle()
                                        .frame(width: 150, height: 150)
                                        .background(Color.pink)
                                        .cornerRadius(16)
                                        .clipped()
                                }
                            }
                            .padding()
                        }
                        //                        Color.pink
                        //                            .frame(maxWidth: .infinity)
                        //                            .frame(height: 100)
                        //                        ReservationButton()
                    }
                }
            }
            ReservationButton()
        } // Zstack
    } // Body
}

struct GroomerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GroomerDetailView("내 앞에 있는 안내 근무자의 안내를 받아 한자리에 두 분씩 한 보트에 열 분이서 머리 젖습니다 신발 젖습니다 양말 까지 다 젖는 여기는 아아 아아 아마존", lineLimit: 2)
    }
}

struct PageView: View {
    var body: some View {
        TabView {
            ForEach(0..<5) { i in
                ZStack {
                    Image("groomer")
                        .resizable()
                }.clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            }
            .padding(.horizontal, 10)
        }
        .frame(width: UIScreen.main.bounds.width, height: 250)
        .tabViewStyle(PageTabViewStyle())
    }
}

struct StoreInfoButton: View {
    @State var showingAlert: Bool = false
    var phoneNumber = "010-9962-3015"
    
    var body: some View {
        Group {
            HStack {
                Button {
                    
                } label: {
                    VStack(spacing: 5) {
                        Image(systemName: "heart")
                        Text("좋아요")
                    }
                    .frame(width: 60, height: 70)
                    .foregroundColor(.gray)
                }
                
                Text("|")
                
                Button {
                    let phone = "tel://"
                    let phoneNumberformatted = phone + phoneNumber
                    guard let url = URL(string: phoneNumberformatted) else { return }
                    UIApplication.shared.open(url)
                } label: {
                    VStack(spacing: 5) {
                        Image(systemName: "phone")
                        Text("전화")
                    }
                    .frame(width: 60)
                    .foregroundColor(.gray)
                }
                
                Text("|")
                
                Button {
                    
                } label: {
                    VStack(spacing: 5) {
                        Image(systemName: "location")
                        Text("위치")
                    }
                    .frame(width: 60)
                    .foregroundColor(.gray)
                }
                
                Text("|")
                
                Button {
                    self.showingAlert = true
                } label: {
                    VStack(spacing: 5) {
                        Image(systemName: "square.and.arrow.up")
                        Text("공유")
                    }
                    .frame(width: 60)
                    .foregroundColor(.gray)
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("공유하시겠습니까?"), message: Text("Error Reson"), dismissButton: .default(Text("OK")))
                    }
                }
            }
            // MARK: - 매장정보
        } // HStack
        .frame(maxWidth: .infinity)
    }
    
}


struct StoreInfo: View {
    var body: some View {
        Group{
            HStack {
                Text("매장정보")
                    .font(.headline)
                Spacer()
            }
            .padding()
            
            HStack(spacing: 0) {
                Text("영업시간")
                    .frame(width: 60)
                    .background(Color.yellow)
                    .padding(.trailing, 30)
                //                            Spacer()
                //                                .frame(width: 20)
                Text("평일: 11시 ~ 20시 / 정기휴일: 월요일")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.yellow)
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            
            HStack(spacing: 0) {
                
                Text("주소")
                    .frame(width: 60, alignment: .leading)
                    .frame(maxHeight: .infinity, alignment: .top)
                    .background(Color.yellow)
                    .padding(.trailing, 30)
                
                //                            Spacer()
                //                                .frame(width: 20)
                
                Text("서울 강북구 삼양로 285(미아동) 지하 애견카페 동행")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.yellow)
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .background(Color.purple)
        }
    }
}




//
//  GroomerCardView.swift
//  Petvely
//
//  Created by Hertz on 11/5/22.
//

import SwiftUI

struct Groomer: View {
    var body: some View {
        HStack { //
            // 그루머 이미지
            Image("groomer")
                .resizable()
                .frame(width: 150, height: 150)
            
            
            VStack(alignment: .leading) {
                Text("핑크멍")
                    .font(.headline)
                Text("👍🏻") + Text(" 5")
                    .foregroundColor(.secondary)
                Text("서울 강북구 수유2동 대성빌딩 1층")
                    .lineLimit(2)
//                Spacer()
                sizeCardView
                Text("⏰ 09:00 ~ 20:00")
                    .padding(.bottom,10)
            }
        }
        .frame(maxHeight: .infinity)
        .background(Color.primary.colorInvert())
        .cornerRadius(6)
        .shadow(color: Color.primary.opacity(0.33), radius: 1, x: 2, y: 2)
        .padding(.vertical, 8)
    }
    
    
    var sizeCardView: some View {
        HStack() {
            Text("소형")
                .font(.headline)
                .foregroundColor(.white)
                .padding(3)
                .background(Color.gray)
                .cornerRadius(16)
            Text("중형")
                .font(.headline)
                .foregroundColor(.white)
                .padding(3)
                .background(Color.gray)
                .cornerRadius(16)
            Text("대형")
                .font(.headline)
                .foregroundColor(.white)
                .padding(3)
                .background(Color.gray)
                .cornerRadius(16)
        }
//        .padding(.top,0)
        
    }
}

struct Groomer_Previews: PreviewProvider {
    static var previews: some View {
        Groomer()
    }
}

//
//  ReservationButton.swift
//  Petvely
//
//  Created by Hertz on 11/5/22.
//

import SwiftUI

struct ReservationButton: View {
    var body: some View {
        Button {
            // 예약하기 화면으로 가기
        } label: {
            Rectangle().background(Color.yellow)
                .font(.system(size: 100))
                .foregroundColor(.orange)
                .shadow(color: .gray, radius: 2, x: 1, y: 1)
                .frame(width: 200, height: 70)
                .cornerRadius(30)
                .padding()
                .overlay {
                    Text("예약하기")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                }
        }

    }
}

struct ReservationButton_Previews: PreviewProvider {
    static var previews: some View {
        ReservationButton()
    }
}

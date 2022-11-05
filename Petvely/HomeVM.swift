//
//  HomeVM.swift
//  Petvely
//
//  Created by Hertz on 11/5/22.
//

import Foundation
import Combine

class HomeVM : ObservableObject {
    
    var subscriptions = Set<AnyCancellable>()
    
    // stateful = .value - @Published, CurrentValueSubject
    // stateless = .value 접근못하는 애들
    @Published var boundary : Int = 10
    @Published var boundaryString: String = ""
    
    
    init(){
        $boundary
            .removeDuplicates()
            .map{ "\($0)" }
            .assign(to: \.boundaryString, on: self)
            .store(in: &subscriptions)
    }
}

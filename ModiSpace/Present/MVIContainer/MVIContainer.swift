//
//  MVIContainer.swift
//  ModiSpace
//
//  Created by 최승범 on 10/26/24.
//

import Foundation
import Combine

final class MVIContainer<Intent,Model>: ObservableObject {
    let intent: Intent
    let model: Model
    
    private var cancellable: Set<AnyCancellable> = []
    
    init(intent: Intent, model: Model, modelChangedPublisher: ObjectWillChangePublisher) {
        self.intent = intent
        self.model = model
        
        modelChangedPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: objectWillChange.send)
            .store(in: &cancellable)
    }
}

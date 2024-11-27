//
//  DataBaseManager.swift
//  ModiSpace
//
//  Created by 최승범 on 11/10/24.
//

import Foundation
import SwiftData

final class DBManager {
    
    var modelContext: ModelContext?
    
    init(modelContext: ModelContext? = nil) {
        self.modelContext = modelContext
    }
    
    static func makeModelContainer() -> ModelContainer {
        let schema = Schema([
            ChannelChatList.self,
            User.self,
            DMChatList.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema,
                                                    isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema,
                                      configurations: [modelConfiguration])
        } catch {
            fatalError("ModelContainer를 생성하는데 실패했습니다")
        }
    }
}

//MARK: - 데이터베이스 CRUD Method
extension DBManager {
    
    func addItem<T: PersistentModel>(_ model: T) {
        guard let modelContext else { return }
        
        modelContext.insert(model)
        
        do {
            try modelContext.save()
        } catch {
            print(error.localizedDescription)
            print("DB 저장 실패")
        }
    }
    
    func fetchItems<T: PersistentModel>(ofType type: T.Type) -> [T]  {
        guard let modelContext else { return [] }
        
        let request = FetchDescriptor<T>()
        
        do {
            let items: [T] = try modelContext.fetch(request)
            return items
        } catch {
            print("불러오기 실패")
            return []
        }
    }
    
    func removeItem<T: PersistentModel>(_ model: T) {
        guard let modelContext else { return }
        
        modelContext.delete(model)
        
        do {
            try modelContext.save()
        } catch {
            print("DB삭제 실패 \(model)")
        }
    }
    
}

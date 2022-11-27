//
//  RealmService.swift
//  ProgrammerQuotes
//
//  Created by Taha Bozdemir on 16.11.2022.
//

import Foundation
import RealmSwift

final class RealmService {
    private init() {}
    static let shared = RealmService()
    
    func getDatabasePath() -> URL? {
        return Realm.Configuration.defaultConfiguration.fileURL
    }
    
    var realm = try! Realm()
    
    func create<T: Object>(_ object: T){
        do {
            try realm.write{
                realm.add(object)
            }
        }
        
        catch {
            print(error)
        }
    }
    
    func delete<T: Object>(_ object: T) {
        do {
            try realm.write{
                realm.delete(object)
            }
        }
        catch {
            print(error)
        }
    }
}

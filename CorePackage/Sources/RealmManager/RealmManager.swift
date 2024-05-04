//
//  RealmManager.swift
//
//
//  Created by AmrFawaz on 04/05/2024.
//

import Foundation
import RealmSwift

public class RealmManager {
    public static let shared = RealmManager()
    private let realm: Realm

    private init() {
        do {
            self.realm = try Realm()
        } catch {
            fatalError("Error initializing Realm: \(error.localizedDescription)")
        }
    }

    public func save<T: Codable>(_ items: [T]) {
        let realmObjects = items.compactMap { item -> Object? in
            guard let codableObject = item as? Object else { return nil }
            return codableObject
        }

        do {
            try realm.write {
                realm.deleteAll()
                realm.add(realmObjects, update: .modified)
            }
        } catch {
            print("Error saving objects to Realm: \(error.localizedDescription)")
        }
    }

    public func load<T: Codable>(_ type: T.Type) -> [T] {
        let realmObjects = realm.objects(T.self as! Object.Type).compactMap { $0 as? T }
        return Array(realmObjects)
    }
}

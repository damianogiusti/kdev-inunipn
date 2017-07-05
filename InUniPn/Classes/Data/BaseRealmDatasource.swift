//
//  BaseRealmDatasource.swift
//  InUniPn
//
//  Created by Damiano Giusti on 05/07/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation
import RealmSwift

protocol BaseRealmDatasource: class {

    associatedtype DM: Object
    associatedtype M

    func obj(byId id: String) -> M?

    @discardableResult
    func save(obj: M) -> Bool

    @discardableResult
    func saveAll(objects: [M]) -> Bool

    @discardableResult
    func delete(byId id: String) -> Bool

    @discardableResult
    func all() -> [M]

    @discardableResult
    func deleteAll() -> Bool

    func mapToModel(dataModel: DM?) -> M?

    func mapToDataModel(model: M?) -> DM?
}

extension BaseRealmDatasource {

    private func realm() -> Realm? {
        return try? Realm()
    }

    func obj(byId id: String) -> M? {
        if let realm = realm() {
            return mapToModel(dataModel: realm.object(ofType: DM.self, forPrimaryKey: id))
        }
        return nil
    }

    @discardableResult
    func save(obj: M) -> Bool {
        if let realm = realm(), let obj = mapToDataModel(model: obj) {
            realm.beginWrite()
            realm.add(obj, update: true)
            do {
                try realm.commitWrite()
            } catch {
                realm.cancelWrite()
                return false
            }
        }
        return true
    }

    @discardableResult
    func saveAll(objects: [M]) -> Bool {
        if let realm = realm() {
            let array = objects.flatMap(mapToDataModel)
            realm.beginWrite()
            realm.add(array, update: true)
            do {
                try realm.commitWrite()
            } catch {
                realm.cancelWrite()
                return false
            }
        }
        return true
    }

    @discardableResult
    func delete(byId id: String) -> Bool {
        if let realm = realm() {
            realm.beginWrite()
            if let news = realm.object(ofType: DM.self, forPrimaryKey: id) {
                realm.delete(news)
            }
            do {
                try realm.commitWrite()
            } catch {
                realm.cancelWrite()
                return false
            }
        }
        return true
    }

    @discardableResult
    func all() -> [M] {
        if let realm = realm() {
            let array: [M] = realm.objects(DM.self).flatMap(mapToModel)
            return array
        }
        return []
    }

    @discardableResult
    func deleteAll() -> Bool {
        if let realm = realm() {
            realm.beginWrite()
            realm.delete(realm.objects(DM.self))
            do {
                try realm.commitWrite()
            } catch {
                realm.cancelWrite()
                return false
            }
        }
        return true
    }
    
}

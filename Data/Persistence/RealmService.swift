//
//  RealmService.swift
//  UserManager
//
//  Created by Brian Huamani on 5/07/26.
//

import Foundation
import RealmSwift

// MARK: - Protocol

protocol RealmServiceProtocol {
    func saveUsers(_ objects: [UserRealmObject]) throws
    func saveUser(_ object: UserRealmObject) throws
    func updateUser(id: Int, name: String, email: String) throws
    func softDeleteUser(id: Int) throws
    func fetchActiveUsers() throws -> [UserRealmObject]
}

// MARK: - Implementation

final class RealmService: RealmServiceProtocol {
    
    static let shared = RealmService()

    private init() {}

    private func openRealm() throws -> Realm {
        do {
            return try Realm()
        } catch {
            throw RealmError.initializationFailed(error)
        }
    }

    private func write(to db: Realm, block: () throws -> Void) throws {
        do {
            try db.write { try block() }
        } catch let realmError as RealmError {
            throw realmError
        } catch {
            throw RealmError.writeFailed(error)
        }
    }

    // MARK: - Save

    func saveUsers(_ objects: [UserRealmObject]) throws {
        let db = try openRealm()
        try write(to: db) {
            for object in objects {
                guard db.object(ofType: UserRealmObject.self, forPrimaryKey: object.id) == nil else {
                    continue
                }
                db.add(object, update: .modified)
            }
        }
    }

    func saveUser(_ object: UserRealmObject) throws {
        let db = try openRealm()
        try write(to: db) {
            db.add(object, update: .modified)
        }
    }

    // MARK: - Update

    func updateUser(id: Int, name: String, email: String) throws {
        let db = try openRealm()
        guard let object = db.object(ofType: UserRealmObject.self, forPrimaryKey: id) else {
            throw RealmError.objectNotFound(id: id)
        }
        try write(to: db) {
            object.name  = name
            object.email = email
        }
    }

    // MARK: - Delete

    func softDeleteUser(id: Int) throws {
        let db = try openRealm()
        guard let object = db.object(ofType: UserRealmObject.self, forPrimaryKey: id) else {
            throw RealmError.objectNotFound(id: id)
        }
        try write(to: db) {
            object.isDeleted = true
        }
    }

    // MARK: - Fetch

    func fetchActiveUsers() throws -> [UserRealmObject] {
        let db = try openRealm()
        return Array(
            db.objects(UserRealmObject.self)
                .filter("isDeleted == false")
        )
    }
}

// MARK: - RealmError

enum RealmError: LocalizedError {
    case initializationFailed(Error)
    case objectNotFound(id: Int)
    case writeFailed(Error)

    var errorDescription: String? {
        switch self {
        case .initializationFailed(let error):
            return "Realm init failed: \(error.localizedDescription)"
        case .objectNotFound(let id):
            return "User \(id) not found in local database."
        case .writeFailed(let error):
            return "Realm write failed: \(error.localizedDescription)"
        }
    }
}

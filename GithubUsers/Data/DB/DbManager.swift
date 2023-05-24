//
//  DbManage.swift
//  GithubUsers
//
//  Created by Andrew Ananda on 19/05/2023.
//

import Foundation
import RealmSwift


class DbManager {
	private var realm: Realm!
	private var schemaVersion: UInt64 = 1
	
	
	init() {
		
		do {
			var config = Realm.Configuration(deleteRealmIfMigrationNeeded: false)
			config.schemaVersion = self.schemaVersion
			realm = try Realm(configuration: config)
		}catch(let error) {
			var config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
			config.schemaVersion = self.schemaVersion
			realm = try! Realm(configuration: config)
		}
	}
	
	
	
	func saveUsers(_ user: UserEntity) {
		removeUsers()
		
		try! self.realm.write() {
			self.realm.add(user, update: .modified)
		}
	}
	
	func getUsers() -> Results<UserEntity> {
		return realm.objects(UserEntity.self)
	}
	
	func saveFollowers(_ followers: [FollowersEntity]) {
		removeFollowers()
		
		try! self.realm.write() {
			followers.forEach { (item) in
				self.realm.add(item, update: .modified)
			}
		}
	}
	
	func getFollowers() -> Results<FollowersEntity> {
		return realm.objects(FollowersEntity.self)
	}
	
	func saveFollowing(_ followers: [FollowingEntity]) {
		removeFollowing()
		
		try! self.realm.write() {
			followers.forEach { (item) in
				self.realm.add(item, update: .modified)
			}
		}
	}
	
	func getFollowing() -> Results<FollowingEntity> {
		return realm.objects(FollowingEntity.self)
	}
	
	
	func removeUsers() {
		try! realm.write() {
			let items = realm.objects(UserEntity.self)
			
			items.forEach { item in
				self.realm.delete(item)
			}
		}
	}
	
	func removeFollowers() {
		try! realm.write() {
			let items = realm.objects(FollowersEntity.self)
			
			items.forEach { item in
				self.realm.delete(item)
			}
		}
	}
	
	func removeFollowing() {
		try! realm.write() {
			let items = realm.objects(FollowingEntity.self)
			
			items.forEach { item in
				self.realm.delete(item)
			}
		}
	}
	
}

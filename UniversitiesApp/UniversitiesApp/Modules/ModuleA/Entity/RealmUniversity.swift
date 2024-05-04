//
//  RealmUniversity.swift
//  UniversitiesApp
//
//  Created by AmrFawaz on 03/05/2024.
//

import Foundation
import RealmSwift

class RealmUniversity: Object, Codable {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var state: String? = ""
    @objc dynamic var country: String = ""
    @objc dynamic var countryCode: String = ""
    var webPages = List<String>()

    override static func primaryKey() -> String? {
        return "id"
    }
}

extension RealmUniversity {
    convenience init(university: University) {
        self.init()
        self.id = university.id
        self.name = university.name
        self.state = university.state
        self.country = university.country
        self.countryCode = university.countryCode
        let webPagesList = List<String>()
        university.webPages.forEach { webPagesList.append($0) }
        self.webPages = webPagesList
    }
}

extension University {
    init(realmUniversity: RealmUniversity) {
//        self.id = realmUniversity.id
        self.name = realmUniversity.name
        self.state = realmUniversity.state
        self.country = realmUniversity.country
        self.countryCode = realmUniversity.countryCode
        var webPagesArray: [String] = []
        realmUniversity.webPages.forEach { webPagesArray.append($0) }
        self.webPages = webPagesArray
    }
}

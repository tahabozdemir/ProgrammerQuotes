//
//  Quote.swift
//  ProgrammerQuotes
//
//  Created by Taha Bozdemir on 22.10.2022.
//
import Foundation
import RealmSwift

final class Quote: Object, Codable {
    @objc dynamic var id: String = ""
    @objc dynamic var author: String = ""
    @objc dynamic var en: String = ""
}

//
//  Favourite.swift
//  ProgrammerQuotes
//
//  Created by Taha Bozdemir on 7.11.2022.
//
import Foundation
import RealmSwift
import UIKit

final class Favorite: Object {
    @objc dynamic weak var quote: Quote? = nil
    @objc dynamic var imageURLString: String? = nil
    @objc dynamic var date: Date? = nil
    
    convenience init(quote: Quote?, imageURLString: String?, date: Date?) {
        self.init()
        self.quote = quote
        self.imageURLString = imageURLString
        self.date = date
    }
}

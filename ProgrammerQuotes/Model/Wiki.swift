//
//  Wiki.swift
//  ProgrammerQuotes
//
//  Created by Taha Bozdemir on 22.10.2022.
//
import Foundation

struct Wiki: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int:Page]
}

struct Page: Codable {
    let pageid: Int
    let title: String
    let extract: String?
    let thumbnail: Thumbnail?
}

struct Thumbnail: Codable {
    let source: String
    let width: Int
    let height: Int
}

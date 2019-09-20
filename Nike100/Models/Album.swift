//
//  Album.swift
//  Nike100
//
//  Created by Jeffrey Haley on 9/19/19.
//  Copyright © 2019 Jeffrey Haley. All rights reserved.
//

import Foundation

struct ResponseBody: Decodable {
    let feed: Feed
    
    enum CodingKeys: String, CodingKey {
        case feed = "feed"
    }
}

struct Feed: Decodable {
    let albums: [Album]?
    
    enum CodingKeys: String, CodingKey {
        case albums = "results"
    }
}

struct Album: Decodable {
    let artistName: String?
    let id: String?
    let releaseDate: String?
    let name: String?
    let copyright: String?
    let artworkUrl100: String?
    let genres: [Genre]?
    
    enum CodingKeys: String, CodingKey {
        case artistName = "artistName"
        case id = "id"
        case releaseDate = "releaseDate"
        case name = "name"
        case copyright = "copyright"
        case artworkUrl100 = "artworkUrl100"
        case genres = "genres"
    }
}

struct Genre: Decodable {
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
}

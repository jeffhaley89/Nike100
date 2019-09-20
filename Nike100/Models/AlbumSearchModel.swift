//
//  AlbumSearchModel.swift
//  Nike100
//
//  Created by Jeffrey Haley on 9/19/19.
//  Copyright © 2019 Jeffrey Haley. All rights reserved.
//

import Foundation

struct AlbumSearchModel {
    let iTunesAlbumsURL = URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json")
    
    func retrieveTopAlbums(completionHandler: @escaping (ResponseBody?, Error?) -> ()) {
        guard let url = iTunesAlbumsURL else { return }
        DispatchQueue.main.async {
            NetworkManager.get(url, objectType: ResponseBody.self) { (result: NetworkManager.Result<ResponseBody>) in
                switch result {
                case .success(let albums):
                    completionHandler(albums, nil)
                case .failure(let failureError):
                    switch failureError {
                    case .deserializationError(let error), .unknown(let error):
                        completionHandler(nil, error)
                    case .unexpectedResponse:
                        completionHandler(nil, nil)
                    }
                }
            }
        }
    }
    
}

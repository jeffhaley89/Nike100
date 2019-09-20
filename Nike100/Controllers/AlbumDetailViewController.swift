//
//  AlbumDetailViewController.swift
//  Nike100
//
//  Created by Jeffrey Haley on 9/19/19.
//  Copyright © 2019 Jeffrey Haley. All rights reserved.
//

import UIKit

class AlbumDetailViewController: UIViewController {
    
    var album: Album?
    
    @IBOutlet weak var albumCover: AlbumImageView!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var artist: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var copyright: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Album Details"
        configureView()
    }
    
    private func configureView() {
        if let album = album {
            albumCover.setImage(imageURL: album.artworkUrl100)
            albumName.text = album.name
            artist.text = album.artistName
            releaseDate.text = album.releaseDate
            copyright.text = album.copyright
            if let genres = album.genres {
                genre.text = genres.map({ ($0.name ?? "").capitalized }).joined(separator: ", ")
            }
        }
    }
    
    @IBAction func itunesButton(_ sender: UIButton) {
        if let name = album?.name,
           let id = album?.id,
           let urlString = "itms://itunes.apple.com/us/album/\(name)/id\(id)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlString),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            displaySimpleAlert(message: "Unable to open iTunes")
        }
    }
}

//
//  AlbumTableViewCell.swift
//  Nike100
//
//  Created by Jeffrey Haley on 9/19/19.
//  Copyright © 2019 Jeffrey Haley. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    @IBOutlet weak var albumImageView: AlbumImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configureAlbumCell(album: Album) {
        albumImageView.image = nil
        artistLabel.text = album.artistName
        albumLabel.text = album.name
        albumImageView.setImage(imageURL: album.artworkUrl100)
    }
}

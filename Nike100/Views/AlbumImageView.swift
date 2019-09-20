//
//  AlbumImageView.swift
//  Nike100
//
//  Created by Jeffrey Haley on 9/19/19.
//  Copyright © 2019 Jeffrey Haley. All rights reserved.
//

import UIKit

class AlbumImageView: UIImageView {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentMode = .scaleAspectFit
    }
    
    func setImage(imageURL: String?) {
        if let imageFromCache = albumImageCache.object(forKey: imageURL as AnyObject) as? UIImage {
            self.image = imageFromCache
        } else {
            guard let url = imageURL else { return }
            loadImage(imageURL: url) { [weak self] loadedImage in
                guard let image = loadedImage else { return }
                self?.image = image
                albumImageCache.setObject(image, forKey: imageURL as AnyObject)
            }
        }
    }
    
    private func loadImage(imageURL: String, completionHandler: @escaping (UIImage?) -> ()) {
        DispatchQueue.global().async {
            if let url = URL(string: imageURL), let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    completionHandler(UIImage(data: data))
                }
            }
        }
    }
}


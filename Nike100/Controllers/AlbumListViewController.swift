//
//  AlbumListViewController.swift
//  Nike100
//
//  Created by Jeffrey Haley on 9/19/19.
//  Copyright © 2019 Jeffrey Haley. All rights reserved.
//

import UIKit

let albumImageCache = NSCache<AnyObject, AnyObject>()

class AlbumListViewController: UIViewController {
    
    enum CellId: String {
        case album = "AlbumTableViewCell"
    }
    
    var albums: [Album]? {
        didSet {
            albumListTableView.reloadData()
        }
    }
    
    let activityIndicator = UIActivityIndicatorView(style: .gray)

    @IBOutlet weak var albumListTableView: UITableView! {
        didSet {
            albumListTableView.register(UINib(nibName: CellId.album.rawValue, bundle: nil), forCellReuseIdentifier: CellId.album.rawValue)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Nike 100"
        getAlbums()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
    }
    
    private func getAlbums() {
        activityIndicator.startAnimating()
        AlbumSearchModel().retrieveTopAlbums { [weak self] (result: ResponseBody?, error: Error?) in
            DispatchQueue.main.async {
                if let albums = result?.feed.albums {
                    self?.activityIndicator.stopAnimating()
                    self?.albums = albums
                } else {
                    self?.displaySimpleAlert(message: error?.localizedDescription ?? "Unexpected response")
                }
            }
        }
    }
}

extension AlbumListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let albumCell = tableView.dequeueReusableCell(withIdentifier: CellId.album.rawValue) as? AlbumTableViewCell,
              let album = self.albums?[indexPath.row] else { return UITableViewCell() }
        albumCell.configureAlbumCell(album: album)
        return albumCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let selectedAlbum = albums?[indexPath.row] else { return }
        let albumDetailVC = AlbumDetailViewController()
        albumDetailVC.album = selectedAlbum
        self.navigationController?.pushViewController(albumDetailVC, animated: true)
    }
}

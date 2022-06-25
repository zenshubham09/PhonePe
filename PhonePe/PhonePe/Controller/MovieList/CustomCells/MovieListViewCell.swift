//
//  MovieListViewCell.swift
//  PhonePe
//
//  Created by Shubham JAIn on 25/06/22.
//

import UIKit

class MovieListViewCell: UITableViewCell {

    @IBOutlet private weak var movieTitle: UILabel!
    @IBOutlet private weak var movieDesxription: UILabel!
    @IBOutlet private weak var movieBanner: UIImageView!
    
    
    func configureCell(title: String, des: String, banner: String) {
        movieTitle.text = title
        movieDesxription.text = des
        let bannerURL = NetworkKeys.imageBasePath + banner
        
        if let customURL = URL(string: bannerURL) {
            load(url: customURL)
        }
    }
    
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.movieBanner.image = image
                    }
                }
            }
        }
    }
}

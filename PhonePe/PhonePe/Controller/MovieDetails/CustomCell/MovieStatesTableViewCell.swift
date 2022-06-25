//
//  MovieStatesTableViewCell.swift
//  PhonePe
//
//  Created by Shubham JAIn on 25/06/22.
//

import UIKit

class MovieStatesTableViewCell: UITableViewCell {

    @IBOutlet private weak var movieBanner: UIImageView!
    @IBOutlet private weak var moviereleaseDate: UILabel!
    @IBOutlet private weak var movieRating: UILabel!
    @IBOutlet private weak var moviewPopularity: UILabel!
    
    func configureCell(banner: String, releaseDate: String, rating: Double, popularity: Double) {
        
        moviereleaseDate.text = releaseDate
        self.movieRating.text = "\(rating)"
        self.moviewPopularity.text = "\(popularity)"
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

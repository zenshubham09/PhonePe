//
//  MovieDetailsViewController.swift
//  PhonePe
//
//  Created by Shubham JAIn on 25/06/22.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var selectedMoviesModel: ResultsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MovieStatesTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieStatesTableViewCell")
        tableView.register(UINib(nibName: "OverViewTableViewCell", bundle: nil), forCellReuseIdentifier: "OverViewTableViewCell")
        if let title = selectedMoviesModel?.title {
            self.title = title
        }
    }
}

extension MovieDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieStatesTableViewCell") as? MovieStatesTableViewCell else {
                return UITableViewCell()
            }
            
            if let poster = selectedMoviesModel?.poster_path,
               let releaseDate = selectedMoviesModel?.release_date,
               let rating = selectedMoviesModel?.vote_average,
               let popularity = selectedMoviesModel?.popularity {
                cell.configureCell(banner: poster,
                                   releaseDate: releaseDate,
                                   rating: rating,
                                   popularity: popularity)

            }
            
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OverViewTableViewCell") as? OverViewTableViewCell else {
            return UITableViewCell()
        }
        if let overView = selectedMoviesModel?.overview {
            cell.configureCell(text: overView)
        }
        return cell
        
    }
}

//
//  MovieListViewController.swift
//  PhonePe
//
//  Created by Shubham JAIn on 25/06/22.
//

import UIKit

class MovieListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let movieViewModel = MovieListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
         movieViewModel.getMovies()
         movieViewModel.delegate = self
        
        tableView.register(UINib(nibName: "MovieListViewCell", bundle: nil), forCellReuseIdentifier: "MovieListViewCell")
        self.title = "Movies"
        
    }
}


extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = movieViewModel.movieModel?.results?.count {
            return count
        }
        return .zero
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListViewCell") as? MovieListViewCell else {
            return UITableViewCell()
        }
        if let title = movieViewModel.movieModel?.results?[indexPath.row].title,
           let des = movieViewModel.movieModel?.results?[indexPath.row].overview,
           let banner = movieViewModel.movieModel?.results?[indexPath.row].poster_path {
            
            cell.configureCell(title: title, des: des, banner: banner)
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let selectedModel = movieViewModel.movieModel?.results?[indexPath.row] else {
            return
        }
        let moviedetails = MovieDetailsViewController()
        moviedetails.selectedMoviesModel = selectedModel
        self.navigationController?.pushViewController(moviedetails, animated: true)
    }
}


extension MovieListViewController: MovieListViewModelDeletgate {
    func getMoviesSuccess() {
        self.tableView.reloadData()
    }
    
    func getMoviesFailure() {
        // show custom alert for failure case
    }
}

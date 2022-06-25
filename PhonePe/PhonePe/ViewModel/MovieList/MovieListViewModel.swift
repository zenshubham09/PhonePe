//
//  MovieListViewModel.swift
//  PhonePe
//
//  Created by Shubham JAIn on 25/06/22.
//

import Foundation

protocol MovieListViewModelDeletgate: AnyObject {
    func getMoviesSuccess()
    func getMoviesFailure()
}

struct MovieEndPoints {
    static let getMovie = "now_playing"
}

class MovieListViewModel {
    
    weak var delegate: MovieListViewModelDeletgate?
    var movieModel: MoviesModel?
    
    func getMovies() {
        let params = [
            URLQueryItem(name: NetworkKeys.apiKey, value: NetworkKeys.apiKeyValue)
        ]
        
        guard let request = NetworkManager.makeRequest(endPoint: MovieEndPoints.getMovie,
                                                       queryParams: params,
                                                       isQueryParms: true) else {
            print("Some error occoured while creating the request")
            return
        }
        
        NetworkManager.processRequestForResponse(MoviesModel.self,
                                                 request: request) { response in
            switch response {
            case .success(let modelData):
                self.movieModel = modelData
                DispatchQueue.main.async {
                    self.delegate?.getMoviesSuccess()
                }
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    self.delegate?.getMoviesFailure()
                }
            }
        }
    }
}

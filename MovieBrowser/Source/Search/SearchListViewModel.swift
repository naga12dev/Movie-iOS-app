//
//  SearchListViewModel.swift
//  MovieBrowser
//
//  Created by mounika on 5/29/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation
// View Model
protocol MovieListViewModelDelegate: class {
    func update(with error: AppErrors?)
}

class SearchListViewModel {
    var results = [Results]()
    weak var delegate: MovieListViewModelDelegate?
    
    func fetchData(_ searchText: String) {
        ApiManager.manager.getData(movieName: searchText) { [self] data in
            DispatchQueue.main.async {
                switch data {
                case .success(let movieData):
                    self.results = movieData.results
                    delegate?.update(with: nil)
                case .failure(let error):
                    delegate?.update(with: error)
                }
            }
        }
    }
}

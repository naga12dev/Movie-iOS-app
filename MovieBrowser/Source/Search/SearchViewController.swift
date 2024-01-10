//
//  SearchViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/19/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
  
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchListTableView: UITableView!
    var viewModel = SearchListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        searchListTableView.delegate = self
        searchListTableView.dataSource = self
        viewModel.fetchData("A")
        self.navigationItem.title = "Movie Search"
    }
    
    @IBAction func searchButton(_ sender: Any) {
        viewModel.fetchData(searchBar.text ?? "")
    }
}

// ALert Message
extension SearchViewController: MovieListViewModelDelegate {
    
    func update(with error: AppErrors?) {
        if (error != nil) {
            let alert = UIAlertController(title: "Error", message: "Error in getting a data from server", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        } else {
            searchListTableView.reloadData()
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    // SearchBar Config
    
}

// TableView Properties
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = searchListTableView.dequeueReusableCell(withIdentifier: "movie_list", for: indexPath) as? MovieListTableViewCell else {
            return UITableViewCell()
        }
        
        let movieList = viewModel.results[indexPath.row]
        cell.movie_title.text = movieList.title
        cell.movie_rating.text = String(movieList.vote_average ?? 0.0)
        cell.release_date.text = movieList.release_date

        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let destiVC = storyboard?.instantiateViewController(withIdentifier: "detailVC") as? MovieDetailViewController {
        destiVC.movieDetails = viewModel.results[indexPath.row]
        self.navigationController?.pushViewController(destiVC, animated: true)
        }
    }
}


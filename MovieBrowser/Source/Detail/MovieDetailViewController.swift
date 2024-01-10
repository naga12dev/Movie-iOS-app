//
//  MovieDetailViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/26/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    

    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var release_date: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var descp: UILabel!
    var movieDetails : Results?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.posterImage.image = UIImage(named: "placeholder")
        
        if let movieInfo = movieDetails {
            if let path = movieInfo.poster_path {
            if let imageData = CacheManager.manager.fetch(from: path), let img = UIImage(data: imageData) {
                posterImage.image = img
            } else {
                ApiManager.manager.downloadImage(url: path) { result in
                    switch result {
                    case .success(let data):
                        CacheManager.manager.cahceImage(url:  data.1, data: data.0)
                        if let posterImg = UIImage(data: data.0) {
                            DispatchQueue.main.async {
                                self.posterImage.image = posterImg
                            }
                        }
                    case .failure(let error):
                        print("error")
                    }
                }
            }
            }
            titleName.text = movieInfo.title
            release_date.text = movieInfo.release_date
            descp.text = movieInfo.overview
        }
    
    }
    
}

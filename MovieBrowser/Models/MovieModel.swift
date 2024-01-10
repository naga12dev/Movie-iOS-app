//
//  MovieModel.swift
//  MovieBrowser
//
//  Created by mounika on 5/27/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

struct Page: Codable {
    let page : Int
    let results :[Results]
}
struct Results: Codable {
    let title : String
    let vote_average : Float?
    let release_date : String?
    let poster_path : String?
    let overview: String?
}



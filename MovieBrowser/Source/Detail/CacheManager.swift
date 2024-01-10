//
//  CacheManager.swift
//  MovieBrowser
//
//  Created by mounika on 5/29/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation
class CacheManager {
    static let manager = CacheManager()
    
    let cache = NSCache<NSString, NSData>()
    
    private init() {}
    
    func fetch(from imageUrl: String) -> Data? {
        return cache.object(forKey: imageUrl as NSString) as Data?
    }
    
    func cahceImage(url: String, data: Data) {
        cache.setObject(data as NSData, forKey: url as NSString)
    }
}

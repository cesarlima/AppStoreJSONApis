//
//  Service.swift
//  AppStoreJSONApis
//
//  Created by MacPro on 09/08/19.
//  Copyright © 2019 br.com.cesarlima. All rights reserved.
//

import Foundation

class Service {
    static let shared = Service()
    
    func fetchApps(searchTerm:String, onComplete:@escaping ([Result], Error?) -> ()) {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                print("Failed to fetch apps:", err)
                onComplete([], err)
                return
            }
            
            guard let data = data else { return }
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                onComplete(searchResult.results, nil)
            } catch let jsnErr {
                print("Error to decode json", jsnErr)
                onComplete([], jsnErr)
            }
            }.resume()
    }
}

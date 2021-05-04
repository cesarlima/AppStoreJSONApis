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
    
    func fetchApps(searchTerm:String, onComplete:@escaping (SearchResult?, Error?) -> ()) {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        fetchGenericJSONData(urlString: urlString, onComplete: onComplete)
    }
    
    func fetchSocialApps(onComplete:@escaping ([SocialApp]?, Error?) -> Void)  {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        fetchGenericJSONData(urlString: urlString, onComplete: onComplete)
    }
    
    func fetchGames(onComplete:@escaping (AppGroup?, Error?) -> Void) {
        fetchGenericJSONData(urlString: "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json", onComplete: onComplete)
    }
    
    func fetchGrossing(onComplete:@escaping (AppGroup?, Error?) -> Void) {
        fetchGenericJSONData(urlString: "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/50/explicit.json", onComplete: onComplete)
    }
    
    func fetchApps(onComplete:@escaping (AppGroup?, Error?) -> Void) {
        fetchGenericJSONData(urlString: "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-apps-we-love/all/50/explicit.json", onComplete: onComplete)
    }
    
    public func fetchGenericJSONData<T: Decodable>(urlString:String, onComplete:@escaping (T?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                onComplete(nil, err)
                return
            }
            
            do {
                let object = try JSONDecoder().decode(T.self, from: data!)
                onComplete(object, nil)
            } catch {
                onComplete(nil, error)
            }
            }.resume()
    }
}

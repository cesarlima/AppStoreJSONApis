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
    
    func fetchSocialApps(onComplete:@escaping ([SocialApp]?, Error?) -> Void)  {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, rsp, err) in
            if let err = err {
                print("Failed to fetch social apps:", err)
                onComplete([], err)
                return
            }
            
            guard let data = data else { return }
            do {
                let socialApps = try JSONDecoder().decode([SocialApp].self, from: data)
                onComplete(socialApps, nil)
            } catch let jsnErr {
                print("Error to decode json SocialApps", jsnErr)
                onComplete([], jsnErr)
            }
        }.resume()
    }
    
    func fetchGames(onComplete:@escaping (AppGroup?, Error?) -> Void) {
        fetchAppGroup(urlSgring: "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json", onComplete: onComplete)
    }
    
    func fetchGrossing(onComplete:@escaping (AppGroup?, Error?) -> Void) {
        fetchAppGroup(urlSgring: "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/50/explicit.json", onComplete: onComplete)
    }
    
    func fetchApps(onComplete:@escaping (AppGroup?, Error?) -> Void) {
        fetchAppGroup(urlSgring: "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-apps-we-love/all/50/explicit.json", onComplete: onComplete)
    }
    
    private func fetchAppGroup(urlSgring:String, onComplete:@escaping (AppGroup?, Error?) -> Void) {
        guard let url = URL(string: urlSgring) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                onComplete(nil, err)
                return
            }
            
            do {
                let appGroup = try JSONDecoder().decode(AppGroup.self, from: data!)
                onComplete(appGroup, nil)
            } catch {
                onComplete(nil, error)
            }
            }.resume()
    }
}

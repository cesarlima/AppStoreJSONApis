//
//  AppGroup.swift
//  AppStoreJSONApis
//
//  Created by MacPro on 22/08/19.
//  Copyright © 2019 br.com.cesarlima. All rights reserved.
//

import Foundation

struct AppGroup: Decodable {
    let feed:Feed
}

struct Feed: Decodable {
    let title:String
    let results: [FeedResult]
}

struct FeedResult: Decodable {
    let id:String
    let name:String
    let artistName:String
    let artworkUrl100:String
}

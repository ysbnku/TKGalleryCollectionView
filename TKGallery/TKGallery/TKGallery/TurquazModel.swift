//
//  TurquazModelGallery.swift
//  TKGallery
//
//  Created by Yavuz BİTMEZ on 06/12/2018.
//  Copyright © 2018 Yavuz BİTMEZ. All rights reserved.
//

import Foundation



struct TKData:Decodable {
    let data:Data
    let meta:Meta
    let pagination:Pagination

}
struct Meta:Decodable {
    let status_code:Int
    let message:String
    let description:String
}

struct Data:Decodable {
   let listGalleryHomeAndDetail:listG
    
    
}
struct listG:Decodable {
    let Status:Bool
    let Response:[Response]
    
}
struct Response:Decodable {
    let Title:String
    let Description:String
    let AlbumMedias:[AlbumMedias]
}
struct Pagination:Decodable {
    let previous_url:String?
    let next_url:String?
}

struct AlbumMedias:Decodable {
    let Title:String
    let Description:String
    let Image:String
}

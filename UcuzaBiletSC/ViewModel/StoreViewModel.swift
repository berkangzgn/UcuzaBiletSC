//
//  StoreViewModel.swift
//  UcuzaBiletSC
//
//  Created by Berkan Gezgin on 15.06.2022.
//

import Foundation

struct StoreVM {
    let model : StoreItem
    
    var name: String { return model.name }
    var artist: String { return model.artist }
    var description: String { return model.description }
    var kind: String { return model.kind }
    var artworkURL: URL { return model.artworkURL }
    
    init?(json: [String: Any]) {
        
        guard let name = json["trackName"] as? String,
            let artist = json["artistName"] as? String,
            let kind = json["kind"] as? String,
            let artworkURLString = json["artworkUrl100"] as? String,
            let artworkURL = URL(string: artworkURLString) else { return nil }
        
        self.name = name
        self.model.artist = artist
        self.model.kind = kind
        self.model.artworkURL = artworkURL
        
        self.model.description = json["description"] as? String ?? json["longDescription"] as? String ?? ""
    }
}

struct StoreItemsVM: Codable {
    let results: [StoreItem]
}

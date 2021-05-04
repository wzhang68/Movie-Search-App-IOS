//
//  SearchViewModel.swift
//  USCMovies
//
//  Created by WEI ZHANG on 4/19/21.
//

import Foundation
import Alamofire
import SwiftyJSON
import SwiftUI

class SearchViewModel : ObservableObject {
    @Published var movies = [SearchResult]()  // Collection
    var query:String
    @Published var fetched = false
    // @Published: if the property, bands, is changed, all views that subscribe BandsViewModel will be notified
    
    init(query:String) {
        self.query = query.replacingOccurrences(of: " ", with: "%20")
        
        let debouncer = Debouncer(delay: 1)
        if(self.query.count>=3){
            debouncer.run(action: {
                self.search(val: self.query)
                
            })
        }
    }
    
    func search(val:String){
        self.fetched = false
        var idx = 0
        let testURL = "https://movie-web-571.wn.r.appspot.com/search/" + val
        AF.request(testURL,method: .get).responseJSON{ (res) in
            switch res.result{
            case .success(let value):
                let json = JSON(value)
                for i in json["results"].arrayValue  {
                    if(idx>=20){
                        return
                    }
                    if(i["backdrop_path"].stringValue.count>0){
                        let name = (i["media_type"].stringValue == "tv") ? i["name"].stringValue: i["title"].stringValue
                        let type = i["media_type"].stringValue
                        let id = i["id"].stringValue
                        let back = i["backdrop_path"].stringValue
                        let release = (i["media_type"].stringValue == "tv") ? i["first_air_date"].stringValue:i["release_date"].stringValue
                        let poster = i["poster_path"].stringValue
                        let rating = i["vote_average"].floatValue
                        let temp = SearchResult(id: id, media_type: type, name: name, backdrop: back, poster: poster, release: release, rating: rating)
                        self.movies.append(temp)
                        idx += 1
                    }
                }
                self.fetched = true
            case .failure(let error):
                print(error)
                self.fetched = true
            }
        }
    }
    
    func reset(){
        self.movies.removeAll();
        self.query = ""
    }
    
}

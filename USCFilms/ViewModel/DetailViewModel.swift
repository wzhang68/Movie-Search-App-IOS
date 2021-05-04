//
//  DetailViewModel.swift
//  USCFilms
//
//  Created by WEI ZHANG on 4/23/21.
//

import Foundation
import Alamofire
import Kingfisher
import SwiftyJSON

class DetailViewModel : ObservableObject {
    var video_id:String
    var video_type:String
    @Published var fetched = false
    @Published var video_name:String
    @Published var video_release:String
    @Published var video_overview:String
    @Published var video_rate:Float
    @Published var video_genre:String
    @Published var video_youtube:String
    @Published var reviews = [Review]()
    @Published var recommend_MV = [Video]()
    @Published var recommend_TV = [Video]()
    @Published var trailer = [String]()
    @Published var cast = [Cast]()


    init(id:String ,type:String) {
        self.video_id = id
        self.video_type = type
        self.video_name = ""
        self.video_release = ""
        self.video_overview = ""
        self.video_rate = 0
        self.video_genre = ""
        self.video_youtube = ""
//        fetchAll()
    }

    func fetchAll(){
        var flag_detail = false
        var flag_youtube = false
        var flag_review = false
        var flag_recommend = false
        var flag_cast = false
        
        if (flag_youtube==false){
            self.getYoutube()
            flag_youtube = true
            if (flag_detail==false){
                self.getDetail()
                flag_detail = true
                if (flag_cast==false){
                    self.getCast()
                    flag_cast = true
                    if (flag_review==false){
                        self.getReview()
                        flag_review = true
                        if(flag_recommend==false){
                            if(self.video_type == "movie"){
                                self.getRecommendMv()
                            }else{
                                self.getRecommendTv()
                            }
                            flag_recommend = true
                            self.fetched = true
                        }
                    }
                }
            }
        }
        
    }
    
    func getDetail(){
        let detailURL = "https://movie-web-571.wn.r.appspot.com/watch/" + self.video_type + "/" + self.video_id
        AF.request(detailURL,method: .get).responseJSON{ (res) in
            switch res.result{
            case .success(let value):
                let json = JSON(value)
                if(self.video_type == "movie"){
                    self.video_name = json["title"].stringValue
                    self.video_release = json["release_date"].stringValue
                }else{
                    self.video_name = json["name"].stringValue
                    self.video_release = json["first_air_date"].stringValue
                }
                self.video_overview = json["overview"].stringValue
                self.video_rate = json["vote_average"].floatValue
                for i in json["genres"].arrayValue{
                    self.video_genre += i["name"].stringValue + ", "
                }
            case .failure(let error):
                print(error)
            }
        }

    }
    
    func getYoutube(){
        let detailURL = "https://movie-web-571.wn.r.appspot.com/youtube/" + self.video_type + "/" + self.video_id
        var resu:String = ""
        AF.request(detailURL,method: .get).responseJSON{ (res) in
            switch res.result{
            case .success(let value):
                let json = JSON(value)
                for i in json["results"].arrayValue{
                    if(i["type"].stringValue == "Teaser"){
                        resu = i["key"].stringValue
                        self.video_youtube = resu
                        return
                    }else if(i["type"].stringValue == "Trailer"){
                        self.trailer.append(i["key"].stringValue)
                    }
                }
                if(self.video_youtube == "" && self.trailer.count > 0){
                    self.video_youtube = self.trailer[0]
                }
            case .failure(let error):
                print(error)

            }
        }

    }
    
    func getReview() {
        var idx = 0
        let reviewURL = "https://movie-web-571.wn.r.appspot.com/reviews/" + self.video_type + "/" + self.video_id
        AF.request(reviewURL,method: .get).responseJSON{ (res) in
            switch res.result{
            case .success(let value):
                let json = JSON(value)
                for i in json["results"].arrayValue  {
                    if(idx >= 3){
                        return
                    }
                    let usrname = i["author_details"]["username"].stringValue
                    let rating = i["author_details"]["rating"].intValue
                    let content = i["content"].stringValue
                    let date = i["created_at"].stringValue
                    let date2 = self.dateconvert(val: String(date.prefix(10)))
                    let id = i["id"].stringValue
                    let temp = Review(id: id, username: usrname, date: date2, rating: rating, content: content)
                    self.reviews.append(temp)
                    idx += 1
                }

            case .failure(let error):
                self.reviews = []
                print(error)

            }
        }

    }
    
    // Recommend Movie
    func getRecommendMv(){
        var idx = 0
        let recommandmvURL = "https://movie-web-571.wn.r.appspot.com/recommend/movie/" + self.video_id
        AF.request(recommandmvURL ,method: .get).responseJSON{ (res) in
            switch res.result{
            case .success(let value):
                let json = JSON(value)
//                print(json)
                for i in json["results"].arrayValue  {
                    if(idx>=20){
                        return
                    }
                    let name = i["title"].stringValue
                    let id  = String(i["id"].intValue)
                    let release = i["release_date"].stringValue
                    let pic = i["backdrop_path"].stringValue
                    let pic2 = i["poster_path"].stringValue
                    let temp = Video(name: name,id: id, pic: pic, poster: pic2,release: release, media_type: "movie", idx:idx)
                    self.recommend_MV.append(temp)
                    idx += 1
                }

            case .failure(let error):
                self.recommend_MV = []
                print(error)

            }
        }

    }
    // Recommend TV
    func getRecommendTv(){
        var idx = 0
        let recommendtvURL = "https://movie-web-571.wn.r.appspot.com/recommend/tv/" + self.video_id
        AF.request(recommendtvURL,method: .get).responseJSON{ (res) in
            switch res.result{
            case .success(let value):
                let json = JSON(value)
                for i in json["results"].arrayValue  {
                    if(idx>=20){
                        return
                    }
                    let name = i["name"].stringValue
                    let id  = String(i["id"].intValue)
                    let release = i["first_air_date"].stringValue
                    let pic = i["backdrop_path"].stringValue
                    let pic2 = i["poster_path"].stringValue
                    let temp = Video(name: name,id: id, pic: pic, poster: pic2,release: release, media_type: "tv", idx:idx)
                    self.recommend_TV.append(temp)
                    idx += 1
                }

            case .failure(let error):
                self.recommend_TV = []
                print(error)

            }
        }

    }
    
    func getCast(){
        var idx = 0
        let castURL = "https://movie-web-571.wn.r.appspot.com/cast/" + self.video_type + "/" + self.video_id
        AF.request(castURL,method: .get).responseJSON{ (res) in
            switch res.result{
            case .success(let value):
                let json = JSON(value)
                for i in json["cast"].arrayValue  {
                    if(idx>=10){
                        return
                    }
                    let name = i["name"].stringValue
                    let id = i["id"].intValue
                    let pic = i["profile_path"].stringValue
                    let temp = Cast(id: id, name: name, pic: pic)
                    self.cast.append(temp)
                    idx += 1
                }

            case.failure(let error):
                self.cast = []
                print(error)

            }
        }

    }
    

    func dateconvert(val:String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD"
        //2015-08-27
        let date = dateFormatter.date(from: val)
        dateFormatter.dateFormat = "MMM DD, YYYY"
        let goodDate = dateFormatter.string(from: date!)
        return goodDate
    }
    

    
    
}

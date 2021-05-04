//
//  HomeViewModel.swift
//  USCMovies
//
//  Created by WEI ZHANG on 4/22/21.
//

import Foundation
import Alamofire
import SwiftyJSON
import SwiftUI

class HomeViewModel : ObservableObject { 
    @Published var fetched = false
    @Published var topmv = [Video]()
    @Published var popmv = [Video]()
    @Published var toptv = [Video]()
    @Published var poptv = [Video]()
    @Published var trending = [Video]()
    @Published var nowplaying = [Video]()
    
//    init() {
//        self.fetchAll()
//    }
    
    //NowPlaying MV
    func getNowPlaying(){
        //https://movie-web-571.wn.r.appspot.com/
        //http://127.0.0.1:9000/
        let nowplayingURL = "https://movie-web-571.wn.r.appspot.com/playingmv"
        var idx = 0
        AF.request(nowplayingURL,method:.get,encoding: JSONEncoding.default).responseJSON{ (res) in
            switch res.result{
            case .success(let value):
                let json = JSON(value)
                for i in json["results"].arrayValue  {
                    if(idx>=5){
                        return
                    }
                    let cc = i["title"].stringValue
                    let id = i["id"].stringValue
                    if(i["poster_path"].stringValue.count>0){
                        let pic = i["backdrop_path"].stringValue
                        let pic2 = i["poster_path"].stringValue
                        let release = i["release_date"].stringValue
                        let m_type = "movie"
                        let temp = Video(name: cc,id: id, pic: pic, poster: pic2,release: release, media_type: m_type,  idx:idx)
                        self.nowplaying.append(temp)
                        idx += 1
                    }else{
                        continue
                    }
                }
            case.failure(let error):
                self.nowplaying = []
                print(error)
            }
        }
    }
    
    //TRENDING TV
    func getTrending(){
        let airingURL = "https://movie-web-571.wn.r.appspot.com/airing"
        var idx = 0
        AF.request(airingURL,method:.get,encoding: JSONEncoding.default).responseJSON{ (res) in
            switch res.result{
            case .success(let value):
                let json = JSON(value)
                for i in json["results"].arrayValue  {
                    if(idx>=5){
                        return
                    }
                    let cc = i["name"].stringValue
                    let id = i["id"].stringValue
                    if(i["poster_path"].stringValue.count>0){
                        let pic = i["backdrop_path"].stringValue
                        let pic2 = i["poster_path"].stringValue
                        let release = i["first_air_date"].stringValue
                        let m_type = "tv"
                        let temp = Video(name: cc,id: id, pic: pic, poster: pic2,release: release, media_type: m_type,  idx:idx)
                        self.trending.append(temp)
                        idx += 1
                    }else{
                        continue
                    }
                }
            case.failure(let error):
                self.trending = []
                print(error)
            }
        }
    }
    
    // POPULAR MOVIE
    func getPopMv(){
        var idx = 0
        let popmvURL = "https://movie-web-571.wn.r.appspot.com/popularmv"
        AF.request(popmvURL,method:.get,encoding: JSONEncoding.default).responseJSON{ (res) in
            switch res.result{
            case .success(let value):
                let json = JSON(value)
                for i in json["results"].arrayValue  {
                    if(idx>=20){
                        return
                    }
                    let cc = i["title"].stringValue
                    let id = i["id"].stringValue
                    if(i["poster_path"].stringValue.count>0){
                        let pic = i["backdrop_path"].stringValue
                        let pic2 = i["poster_path"].stringValue
                        let release = i["release_date"].stringValue
                        let m_type = "movie"
                        let temp = Video(name: cc,id: id, pic: pic, poster: pic2,release: release, media_type: m_type , idx:idx)
                        self.popmv.append(temp)
                        idx += 1
                    }else{
                        continue
                    }
                }
            case .failure(let error):
                self.popmv = []
                print(error)
            }
            
        }
    }
    
    
    
    // TOPRATED MV
    func getTopMv(){
        var idx = 0
        let topmvURL = "https://movie-web-571.wn.r.appspot.com/topratemv"
        AF.request(topmvURL,method:.get,encoding: JSONEncoding.default).responseJSON{ (res) in
            switch res.result{
            case .success(let value):
                let json = JSON(value)
                for i in json["results"].arrayValue  {
                    if(idx>=20){
                        return
                    }
                    let name = i["title"].stringValue
                    let id = i["id"].stringValue
                    if(i["poster_path"].stringValue.count>0){
                        let pic = i["backdrop_path"].stringValue
                        let pic2 = i["poster_path"].stringValue
                        let release = i["release_date"].stringValue
                        let m_type = "movie"
                        let temp = Video(name: name,id: id, pic: pic, poster: pic2,release: release, media_type: m_type, idx:idx)
                        self.topmv.append(temp)
                        idx += 1
                    }else{
                        continue
                    }
                }
            case .failure(let error):
                self.topmv = []
                print(error)
            }
        }
    }
    
    // POPULAR TV
    func getPopTv(){
        var idx = 0
        let poptvURL = "https://movie-web-571.wn.r.appspot.com/populartv"
        AF.request(poptvURL,method:.get,encoding: JSONEncoding.default).responseJSON{ (res) in
            switch res.result{
            case .success(let value):
            let json = JSON(value)
            for i in json["results"].arrayValue  {
                if(idx>=20){
                    return
                }
                let name = i["name"].stringValue
                let id = i["id"].stringValue
                if(i["poster_path"].stringValue.count>0){
                    let pic = i["backdrop_path"].stringValue
                    let pic2 = i["poster_path"].stringValue
                    let release = i["first_air_date"].stringValue
                    let m_type = "tv"
                    let temp = Video(name: name,id: id, pic: pic, poster: pic2,release: release, media_type: m_type, idx:idx)
                    self.poptv.append(temp)
                    idx += 1
                }else{
                    continue
                }
            }
            case.failure(let error):
                self.poptv = []
                print(error)

            }
        }
    }
    
    // TOPRATED TV
    func getTopTv(){
        var idx = 0
        let toptvURL = "https://movie-web-571.wn.r.appspot.com/topratetv"
        AF.request(toptvURL,method:.get,encoding: JSONEncoding.default).responseJSON{ (res) in
            switch res.result{
            case .success(let value):
            let json = JSON(value)
            for i in json["results"].arrayValue  {
                if(idx>=20){
                    return
                }
                let name = i["name"].stringValue
                let id = i["id"].stringValue
                if(i["poster_path"].stringValue.count>0){
                    let pic = i["backdrop_path"].stringValue
                    let pic2 = i["poster_path"].stringValue
                    let release = i["first_air_date"].stringValue
                    let m_type = "tv"
                    let temp = Video(name: name,id: id, pic: pic, poster: pic2,release: release, media_type: m_type, idx:idx)
                    self.toptv.append(temp)
                    idx += 1
                }else{
                    continue
                }
            }
            case.failure(let error):
                self.toptv = []
                print(error)
            }
        }
    }
    
    func fetchAll(){
        var flag_nowplaying = false
        var flag_trending = false
        var flag_popmv = false
        var flag_poptv = false
        var flag_topmv = false
        var flag_toptv = false
        
        if (flag_nowplaying==false){
            self.getNowPlaying()
            flag_nowplaying = true
        }
        if (flag_trending==false){
            self.getTrending()
            flag_trending = true
        }
        if (flag_popmv==false){
            self.getPopMv()
            flag_popmv = true
        }
        if (flag_poptv==false){
            self.getPopTv()
            flag_poptv = true
        }
        
        if (flag_topmv==false){
            self.getTopMv()
            flag_topmv = true
        }
        if (flag_toptv==false){
            self.getTopTv()
            flag_toptv = true
        }
        if(flag_nowplaying && flag_trending && flag_popmv && flag_poptv && flag_topmv && flag_toptv){
            self.fetched = true
        }
    }
    
}


 

//
//  LikeViewModel.swift
//  USCFilms
//
//  Created by WEI ZHANG on 4/25/21.
//

import Foundation
import Alamofire
import SwiftyJSON

class LikeViewModel : ObservableObject {
    @Published var comm_watchlist:String = ""
    @Published var watchlist = [Like]()
    let defaults = UserDefaults.standard
    @Published var idx = 0
    @Published var curr_like:Like = Like(id: "as", type: "as", order: 999, poster: "")
    
    func add(id:String,type:String,poster:String){
        let temp = id+":"+type+":"+poster
        comm_watchlist += temp + " "
        defaults.set(comm_watchlist, forKey: "like")
        watchlist.append(Like(id:id,type:type,order:idx,poster:poster))
        idx+=1
    }
    
    func delete(id:String,type:String,poster:String){
        let temp = id+":"+type+":"+poster
        if(comm_watchlist.contains(temp)){
            comm_watchlist = comm_watchlist.replacingOccurrences(of: temp, with: " ")
        }
        defaults.set(comm_watchlist, forKey: "like")
        var n:Int = 0
        for i in watchlist{
            if(i.id == id && i.type == type && i.poster == poster){
                watchlist.remove(at: n)
                return 
            }
            n += 1
        }
    
    }
    
    func WatchlistToString(){
        var watchlist_str = ""
        for i in self.watchlist{
            let temp:String = i.id + ":" + i.type+":" + i.poster + " "
            watchlist_str.append(temp)
        }
        
    }
    
    
    func check(id:String,type:String,poster:String) -> Bool{
        let temp = id+":"+type+":"+poster
        if(comm_watchlist.contains(temp)){
            return true
        }else{
            return false
        }
    }
    
    func checkEmpty() -> Bool{
        comm_watchlist = defaults.string(forKey: "like") ?? ""
        let temp = self.comm_watchlist.trimmingCharacters(in: .whitespaces)
        return temp.isEmpty
    }
    
    func generateWatchlist(){
        self.watchlist.removeAll()
        if(!checkEmpty()){
            let fullStr:String = defaults.string(forKey: "like") ?? ""
            var idx = 0
            if (fullStr.count > 0){
                let fullStrArr: [String] = fullStr.components(separatedBy: " ")
                for i in fullStrArr{
                    if(i.count>0){
                        let subArr:[String] = i.components(separatedBy: ":")
                        let url = "https://image.tmdb.org/t/p/w500" + subArr[2]
                        let temp = Like(id: subArr[0], type: subArr[1], order: idx,poster: url)
                        self.watchlist.append(temp)
                        idx+=1
                    }
                }
            }
        }
    }
    
}

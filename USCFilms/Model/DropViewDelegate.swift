//
//  DropViewDelegate.swift
//  USCFilms
//
//  Created by WEI ZHANG on 4/27/21.
//

import Foundation
import SwiftUI

struct DropViewDelegate:DropDelegate {
    var like:Like
    @EnvironmentObject var likeVM:LikeViewModel
    
    func performDrop(info: DropInfo) -> Bool {
        return true
    }
    
    func dropEntered(info: DropInfo) {
        let fromIndex = likeVM.watchlist.firstIndex{(like) -> Bool in
            //            like.id == likeVM.curr_like.id
            //            like.type == likeVM.curr_like.type
            return (like.id == likeVM.curr_like.id) && (like.type == likeVM.curr_like.type)
        } ?? 0
        
        let toIndex = likeVM.watchlist.firstIndex{(like) -> Bool in
            return like.id == self.like.id
        } ?? 0
        
        if fromIndex != toIndex{
            withAnimation(.default){
                let fromLike  = likeVM.watchlist[fromIndex]
                likeVM.watchlist[fromIndex] = likeVM.watchlist[toIndex]
                likeVM.watchlist[toIndex] = fromLike
            }
        }
    }
    
    
}
 

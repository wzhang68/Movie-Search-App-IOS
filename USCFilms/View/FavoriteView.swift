//
//  FavoriteView.swift
//  USCFilms
//
//  Created by WEI ZHANG on 4/23/21.
//

import SwiftUI

struct FavoriteView: View {
    
    
    @EnvironmentObject var likeVM:LikeViewModel
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        NavigationView{
            if(likeVM.watchlist.count==0){
                Text("Watchlist is Empty")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .opacity(0.5)
                    .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            else{
                FavoriteView_B1()
            }
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        Text("asas").contextMenu(menuItems: {

        })
    }
}

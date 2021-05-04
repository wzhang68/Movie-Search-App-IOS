//
//  TestView2.swift
//  USCFilms
//
//  Created by WEI ZHANG on 4/24/21.
//

import SwiftUI

struct FavoriteView_B1: View {
    @EnvironmentObject var likeVM:LikeViewModel
    let columns = [
        GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())
    ]
    let column = Array(repeating:GridItem(.flexible()),count:3)
    
    var body: some View {
        
        ScrollView(.vertical) {
            LazyVGrid(columns: column, spacing: 10) {
                ForEach(likeVM.watchlist) { item in
                    NavigationLink(destination: DetailView(video_id: item.id, video_type: item.type, poster: item.poster))
                    {
                        VStack {
                            if(item.poster.count > 0 ){
                                RemoteImage(url: "https://image.tmdb.org/t/p/w500"+item.poster)
                                    .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.height * 0.21, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .scaledToFit()
                                    .aspectRatio(contentMode: .fit)
                            }else{
                                Image("movie_placeholder")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.height * 0.21, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .scaledToFit()
                                    .aspectRatio(contentMode: .fit)
                            }
                        }
                        .contextMenu {
                            Button(action:{
                                likeVM.delete(id: item.id,type: item.type, poster:item.poster)
                            }) {
                                Label("Remove from watchList", systemImage: "bookmark.fill")
                                    .foregroundColor(.black)
                            }
                        }
                    }.buttonStyle(PlainButtonStyle())
                    .onDrag({
                        likeVM.curr_like = item
                        return NSItemProvider()
                    })
                    .onDrop(of: [.text], delegate: DropViewDelegate(like: item, likeVM: _likeVM))
                }
            }
            .padding(.horizontal)
        }.navigationTitle("Watchlist")
    }
}

struct FavoriteView_B1_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView_B1()
    }
}

//struct ItemView: View {
//    var url: String
//
//    var body: some View {
//        VStack {
//            RemoteImage(url: url)
//                .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.height * 0.21, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                .scaledToFit()
//                .aspectRatio(contentMode: .fit)
//        }
//    }
//}

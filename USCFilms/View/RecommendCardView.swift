//
//  RecommendCardView.swift
//  USCFilms
//
//  Created by WEI ZHANG on 4/27/21.
//

import SwiftUI

struct RecommendCardView: View {
    @Binding var movies: [Video]
    @EnvironmentObject var likeVM:LikeViewModel
    
    var body: some View {
        ScrollView(.horizontal){
            HStack(alignment: .top,spacing:30){
                ForEach(self.movies){
                    mv in
                    NavigationLink(destination: DetailView(video_id: mv.id, video_type: mv.media_type, poster: mv.poster)) {
                        VStack{
                            if(mv.poster.count>0){
                                let temp = "https://image.tmdb.org/t/p/w500" + mv.poster
                                VStack{
                                    RemoteImage(url: temp)
                                        .aspectRatio(contentMode: .fit)
                                        .scaledToFit()
                                        .cornerRadius(10.0)
                                        .frame(width: UIScreen.main.bounds.width * 0.29, height:UIScreen.main.bounds.height * 0.21,alignment: .top)
                                        .clipped()
                                }.background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                            }else{
                                VStack{
                                    Image("movie_placeholder")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .scaledToFit()
                                        .cornerRadius(10.0)
                                        .frame(width: UIScreen.main.bounds.width * 0.29, height:UIScreen.main.bounds.height * 0.21,alignment: .top)
                                        .clipped()
                                }.background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                            }
                        }
                        .contextMenu {
                            let cc = likeVM.check(id: mv.id,type: mv.media_type, poster:mv.poster)
                            if(!cc){
                                Button (action:{
                                    likeVM.add(id: mv.id,type: mv.media_type, poster:mv.poster)
        
                                }) {
                                    Label("Add to watchList", systemImage: "bookmark")
                                }
                            }else{
                                Button(action:{
                                    likeVM.delete(id: mv.id,type: mv.media_type, poster:mv.poster)
                                }) {
                                    Label("Remove from watchList", systemImage: "bookmark.fill")
                                }
                            }
                            
                            Button {
                                if let content = URL(string: "https://www.facebook.com/sharer/sharer.php?u=" + "https://www.themoviedb.org/" + mv.media_type + "/" + mv.id){
                                    UIApplication.shared.open(content)
                                }
                            } label: {
                                Label("Share on Facebook", image: "facebook-app-symbol")
                            }
                            
                            Button {
                                if let content = URL(string: "https://twitter.com/intent/tweet?text=Check%20out%20this%20link:%20https://www.themoviedb.org/" + mv.media_type + "/" + mv.id + "%20%20%23CSCI571USCFilms"){
                                    UIApplication.shared.open(content)
                                }
                            } label: {
                                Label("Share on Twitter", image: "twitter")
                            }
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: UIScreen.main.bounds.width * 0.29, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
 
                }
            }
        }.padding()
        .edgesIgnoringSafeArea([.top,.bottom])
    }
}

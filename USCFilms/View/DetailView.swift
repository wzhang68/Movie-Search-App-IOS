//
//  DetailView.swift
//  USCFilms
//
//  Created by WEI ZHANG on 4/23/21.
//

import SwiftUI
import Kingfisher
import youtube_ios_player_helper

struct DetailView: View {
    var video_id:String
    var video_type:String
    var poster:String

    @State var detail_B1 = false
    @State var detail_B2 = false
    @State var detail_B3 = false
    @State var detail_B4 = false
    @EnvironmentObject var likeVM:LikeViewModel
//    @State private var showToast = false
//    @ObservedObject var detailMV:DetailViewModel
    
    
    init(video_id:String,video_type:String,poster:String){
        self.video_id = video_id
        self.video_type = video_type
        self.poster = poster
//        self.detailMV = DetailViewModel(id: self.video_id, type: self.video_type)
//        self.detailMV.getDetail()
//        self.detailMV.getYoutube()
//        self.detailMV.getDetail()
//        self.detailMV.getCast()
//        self.detailMV.getReview()
//        if(self.video_type == "movie"){
//            self.detailMV.getRecommendMv()
//        }else{
//            self.detailMV.getRecommendTv()
//        }

    }
    
    var body: some View {
        if(false){
            ProgressView("Fetching Data...")
        }
        else{
            ScrollView(.vertical){
                VStack{
                    DetailView_B1(video_id: self.video_id, video_type: self.video_type)
                }
                
                VStack{
//                    DetailView_B2(casts: $detail.cast)
                    DetailView_B2(video_id: self.video_id, video_type: self.video_type)
                }
                
                
                VStack{
                    DetailView_B3(video_id: self.video_id, video_type: self.video_type)
                }
                
                
                VStack{
                    DetailView_B4(video_id: self.video_id, video_type: self.video_type)
                }
                Spacer()
            }
            .padding(.horizontal)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    HStack{
                        let cc = likeVM.check(id: self.video_id,type: self.video_type, poster: self.poster)
                        if(!cc){
                            Button (action:{
                                likeVM.add(id: self.video_id,type: self.video_type, poster: self.poster)
//                                showToast = true
    
                            }) {
                                Image(systemName: "bookmark")
                            }   
                        }else{
                            Button(action:{
                                likeVM.delete(id: self.video_id,type: self.video_type, poster: self.poster)
//                                showToast = true
                            }) {
                                Image(systemName: "bookmark.fill")
                                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            }
                        }

                        Button(action: {
                            if let content = URL(string: "https://www.facebook.com/sharer/sharer.php?u=" + "https://www.themoviedb.org/" + self.video_type + "/" + self.video_id){
                                UIApplication.shared.open(content)
                            }
                        }) {
                            Image("facebook-app-symbol")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        
                        Button(action: {
                            if let content = URL(string: "https://twitter.com/intent/tweet?text=Check%20out%20this%20link:%20https://www.themoviedb.org/" + self.video_type + "/" + self.video_id + "%20%20%23CSCI571USCFilms"){
                                UIApplication.shared.open(content)
                            }
                        }) {
                            Image("twitter")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                    }.foregroundColor(.black)
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {

    static var previews: some View {
        DetailView(video_id: "429617", video_type: "movie", poster:"https://image.tmdb.org/t/p/w500/x5o8cLZfEXMoZczTYWLrUo1P7UJ.jpg")
    }
}

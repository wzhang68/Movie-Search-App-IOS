//
//  DetailView_B2.swift
//  USCFilms
//
//  Created by WEI ZHANG on 4/24/21.
//

import SwiftUI
import Kingfisher

struct DetailView_B4: View {
    var video_id:String
    var video_type:String
    @ObservedObject var detail: DetailViewModel
    
    init(video_id:String,video_type:String){
        self.video_id = video_id
        self.video_type = video_type
        self.detail = DetailViewModel(id:video_id, type:video_type)
        if(self.video_type == "movie"){
            detail.getRecommendMv()}
        else{
            detail.getRecommendTv()}
//        self.detail = detailVM
    }
    
    var body: some View {
        VStack(alignment: .leading){
            if(self.video_type == "movie" && detail.recommend_MV.count>0){
                HStack{
                Text("Recommended Movies")
                        .font(.title)
                        .bold()
                }
//                SmallCardView(movies: $detail.recommend_MV)
                RecommendCardView(movies: $detail.recommend_MV)
            }else if(self.video_type == "tv" && detail.recommend_TV.count>0) {
                HStack{
                    Text("Recommended TV shows")
                        .font(.title)
                        .bold()
                }
//                SmallCardView(movies: $detail.recommend_TV)
                RecommendCardView(movies: $detail.recommend_TV)
            }
        }.padding()
    }
}

//struct DetailView_B4_Previews: PreviewProvider {
//    static var previews: some View {
////        DetailView_B4(video_id: "429617", video_type: "movie",vm: ( DetailViewModel(id: "429617", type: "movie")))
////        DetailView_B4(video_id: "429617", video_type: "movie")
//    }
//}

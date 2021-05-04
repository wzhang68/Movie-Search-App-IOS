//
//  DetailView_B1.swift
//  USCFilms
//
//  Created by WEI ZHANG on 4/24/21.
//

import SwiftUI
import Kingfisher
import youtube_ios_player_helper

struct DetailView_B1: View {
    var video_id:String
    var video_type:String
    @ObservedObject var detail: DetailViewModel
    @State private var showDetails = false
    
    init(video_id:String,video_type:String){
        self.video_id = video_id
        self.video_type = video_type
        self.detail = DetailViewModel(id:video_id, type:video_type)
        self.detail.getDetail()
        self.detail.getYoutube()
//        self.detail = detailVM

    }
    
    var body: some View {
        VStack(alignment:.leading, spacing: 10){
            if(detail.video_youtube.count > 0){
            VStack{
                YoutubeUI(videoID: "\(detail.video_youtube)")
            }
            .frame(width: UIScreen.main.bounds.width * 0.95, height:250, alignment:.top)
            .aspectRatio(16/9,contentMode: .fit)
            }
            VStack{
                Text(detail.video_name)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .frame(alignment:.leading)
            }
            VStack{
                if(detail.video_release.count>0 && detail.video_genre.count > 0){
                    Text(String(detail.video_release.prefix(4)) + " | " + detail.video_genre.dropLast(2) )
                        .font(.title3)
                        .lineLimit(nil)
                }else if (detail.video_release.count>0 && detail.video_genre.count == 0){
                    Text(String(detail.video_release.prefix(4)) )
                        .font(.title3)
                        .lineLimit(nil)
                }else if (detail.video_release.count==0 && detail.video_genre.count > 0){
                    Text(detail.video_genre.dropLast(2) )
                        .font(.title3)
                        .lineLimit(nil)
                }
            }.frame(alignment:.leading)
            
            HStack{
                Image(systemName: "star.fill")
                    .foregroundColor(.red)
                Text(String(format: "%.1f",detail.video_rate/2) + "/5.0")
                    .font(.title3)
            }
            
            if(self.showDetails == false){
                VStack(alignment: .trailing){
                    Text(detail.video_overview)
                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        .lineLimit(3)
                        .padding(.bottom, 5)
                    Button(action:{
                        showDetails.toggle()
                    }) {
                        
                        Text("Show more..")
                            .foregroundColor(.black)
                            .opacity(0.7)
                    }
                }
            }else{
                VStack(alignment: .trailing){
                    Text(detail.video_overview)
                        .frame(maxHeight: .infinity)
                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        .lineLimit(nil)
                        .padding(.bottom, 5)
                    Button(action:{
                        showDetails.toggle()
                    }) {
                        
                        Text("Show less..")
                            .foregroundColor(.black)
                            .opacity(0.7)
                    }
                }
            }
        }.padding()
    }
}


struct DetailView_B1_Previews: PreviewProvider {
    static var previews: some View {
        DetailView_B1(video_id: "429617", video_type: "movie")
    }
}

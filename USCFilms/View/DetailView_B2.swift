//
//  DetailView_B2.swift
//  USCFilms
//
//  Created by WEI ZHANG on 4/24/21.
//

import SwiftUI
import Kingfisher

struct DetailView_B2: View {
//    @Binding var casts: [Cast]
    var video_id:String
    var video_type:String
    @ObservedObject var detail: DetailViewModel
    
    init(video_id:String,video_type:String){
        self.video_id = video_id
        self.video_type = video_type
        self.detail = DetailViewModel(id:video_id, type:video_type)
        self.detail.getCast()
//        self.detail = detailVM
    } 
    
    var body: some View {
        if(detail.cast.count>0){
        VStack{
            HStack{
            Text("Cast & Crew")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .frame(minWidth:0, maxWidth: .infinity, alignment: .leading)
                
            }.padding()
            ScrollView(.horizontal){
                HStack(alignment: .top){
                    ForEach(detail.cast){
                        cast in
                        VStack{
                            if(cast.pic.count > 0){
                                let temp = "https://image.tmdb.org/t/p/original" + cast.pic
                                VStack{
                                    RemoteImage(url:temp)
                                        .aspectRatio(contentMode: .fit)
                                        .scaledToFit()
                                        .cornerRadius(10.0)
                                        .offset(y: 25)
                                        .frame(width: UIScreen.main.bounds.width * 0.29, height:UIScreen.main.bounds.height * 0.22,alignment: .top)
                                        .clipShape(Circle())
                                    VStack{
                                        Text(cast.name)
                                            .font(.subheadline)
                                            .multilineTextAlignment(.center)
                                            .lineLimit(nil)
                                        Spacer().frame(height: 0)
                                    }.frame(alignment: .top)
                                }
                            }else{
                                VStack{
                                    Image("cast_placeholder")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .scaledToFit()
                                        .cornerRadius(10.0)
                                        .offset(y: 25)
                                        .frame(width: UIScreen.main.bounds.width * 0.29, height:UIScreen.main.bounds.height * 0.22,alignment: .top)
                                        .clipShape(Circle())
                                    VStack{
                                        Text(cast.name)
                                            .font(.subheadline)
                                            .multilineTextAlignment(.center)
                                            .lineLimit(nil)
                                        Spacer().frame(height: 0)
                                    }.frame(alignment: .top)
                                }
                            }
                        }.background(Color.white)
                        .frame(width: UIScreen.main.bounds.width * 0.29, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                }
            }.padding()
        }
    }//here
    }
}

//struct DetailView_B2_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView_B2(casts: $DetailViewModel(id: "429617", type: "movie").cast)
//    }
//}

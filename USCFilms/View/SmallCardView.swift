//
//  SmallCardView.swift
//  USCFilms
//
//  Created by WEI ZHANG on 4/23/21.
//

import SwiftUI
import Kingfisher

struct SmallCardView: View {
    @Binding var movies: [Video]
    @EnvironmentObject var likeVM:LikeViewModel
    
    var body: some View {
        ScrollView(.horizontal){
            HStack(alignment: .top){
                ForEach(self.movies){
                    mv in
                    NavigationLink(destination: DetailView(video_id: mv.id, video_type: mv.media_type, poster: mv.poster)) {
                        VStack{
                            let temp = "https://image.tmdb.org/t/p/w500" + mv.poster
                            VStack{
                                RemoteImage(url: temp)
                                    .aspectRatio(contentMode: .fit)
                                    .scaledToFit()
                                    .cornerRadius(10.0)
                                    .frame(width: UIScreen.main.bounds.width * 0.29, height:UIScreen.main.bounds.height * 0.21,alignment: .top)
                                    .clipped()
                                Group{
                                    Text(mv.name)
                                        .font(.system(size:15))
                                        .bold()
                                        .multilineTextAlignment(.center)
                                        .lineLimit(nil)
                                    Spacer().frame(height: 0)
                                    Text("(\(String(mv.release.prefix(4))))")
                                        .bold()
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.center)
                                    Spacer().frame(height: 0)
                                }.frame(alignment: .top)
                            }.background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
//                        .background(Color.white)
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

//struct SmallCardView_Previews: PreviewProvider {
//    @StateObject var homeVM = HomeViewModel()
//    static var previews: some View {
//        SmallCardView(movies:homeVM.popmv)
//    }
//}

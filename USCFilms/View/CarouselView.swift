//
//  CarouselView.swift
//  USCFilms
//
//  Created by WEI ZHANG on 4/23/21.
//

import SwiftUI
import Kingfisher


struct CarouselView: View {
    @Binding var movies: [Video]
    @State var index = 0
    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: 10) {
                GeometryReader { geometry in
                    ImageCarouselView(numberOfImages: 5) {
                        ForEach(self.movies){
                                mv in
                                let temp = "https://image.tmdb.org/t/p/w500" + mv.poster
//                            KFImage(URL(string: temp)!)
                        NavigationLink(destination: DetailView(video_id: mv.id, video_type: mv.media_type, poster: mv.poster)){
                            ZStack{
                                RemoteImage(url: temp)
                                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                                    .aspectRatio(contentMode: .fit)
                                    .scaledToFit()
                                    .clipped()
                                    .blur(radius: 32,opaque:true)
                                RemoteImage(url: temp)
                                    .frame(width: geometry.size.width * 0.5, height: geometry.size.height, alignment: .center)
                                    .aspectRatio(contentMode: .fit)
                                    .scaledToFit()
                                    .clipped()
                                    .padding(.trailing,30)
                                
                            }
                        }.buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: 300, alignment: .center)
        }.padding()
    }
}

//struct CarouselView_Previews: PreviewProvider {
//    static var previews: some View {
//        CarouselView()
//    }
//}

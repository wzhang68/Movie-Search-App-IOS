//
//  DetailView_B3.swift
//  USCFilms
//
//  Created by WEI ZHANG on 4/24/21.
//

import SwiftUI
import Kingfisher

struct DetailView_B3: View {
    var video_id:String
    var video_type:String
    @ObservedObject var detail: DetailViewModel
    
    init(video_id:String,video_type:String){
        self.video_id = video_id
        self.video_type = video_type
        self.detail = DetailViewModel(id:video_id, type:video_type)
        self.detail.getDetail()
        self.detail.getReview()
//        self.detail = detailVM
    }
    
    var body: some View { 
        if(detail.reviews.count>0){ //here
            VStack(alignment: .leading){
                Text("Reviews")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .frame(minWidth:0, maxWidth: .infinity, alignment: .leading)
                ForEach(detail.reviews){
                    review in
                    NavigationLink(destination: ReviewDetailView(review:review, video_name: detail.video_name)){
                        VStack{
                            VStack(alignment: .leading, spacing: 10){
                                // Username and Date
                                VStack{
                                    Text("A review by " + review.username)
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .frame(minWidth:0, maxWidth: .infinity, alignment: .leading)
                                    Text("Written by \(review.username) on \(review.date)" )
                                        .font(.subheadline)
                                        .foregroundColor(.black)
                                        .opacity(0.6)
                                        .frame(minWidth:0, maxWidth: .infinity, alignment: .leading)
                                }
                                // Rating
                                HStack{
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.red)
                                    Text(String(format: "%.1f",Float(review.rating/2)) + "/5.0")
                                        .font(.title3)
                                        .frame(minWidth:0, maxWidth: .infinity, alignment: .leading)
                                }
                                // Content
                                VStack{
                                    Text(review.content)
                                        .lineLimit(3)
                                    
                                }
                            }.padding()
                        } //VSTACK END
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                                .opacity(0.7)
                        )
                    }//NavLink END
                    .buttonStyle(PlainButtonStyle())
                }
            }.padding()
        }
    } //here
}

//struct DetailView_B3_Previews: PreviewProvider {
//    static var previews: some View {
//        //        DetailView_B3(video_id: "429617", video_type: "movie",vm: ( DetailViewModel(id: "429617", type: "movie")))
//        DetailView_B3(video_id: "429617", video_type: "movie")
//    }
//}

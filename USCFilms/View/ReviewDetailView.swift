//
//  ReviewDetailView.swift
//  USCFilms
//
//  Created by WEI ZHANG on 4/25/21.
//

import SwiftUI

struct ReviewDetailView: View {
    var review :Review
    var video_name:String
    
    var body: some View {
        ScrollView{
        VStack(alignment: .leading, spacing: 10){
            // Video Name
            VStack{
                Text(video_name)
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(minWidth:0, maxWidth: .infinity, alignment: .leading)
            }
            // Written By
            VStack{
                Text("By " + review.username + " on " + review.date)
                    .font(.body)
                    .foregroundColor(.black)
                    .opacity(0.6)
                    .frame(minWidth:0, maxWidth: .infinity, alignment: .leading)
            }
            // Rating
            HStack{
                Image(systemName: "star.fill")
                    .foregroundColor(.red)
                Text(String(format: "%.1f",Float(review.rating/2)) + "/5.0")
                    .font(.body)
                    .frame(minWidth:0, maxWidth: .infinity, alignment: .leading)
            }
            Divider()
            // Content
            VStack{
                Text(review.content)
                    .lineLimit(nil)
            }
            Spacer()
        }.padding()
    }
    }
}

struct ReviewDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewDetailView(review: Review(id: "dasda", username: "dasa", date: "asdasd", rating: 4, content: "sadsasdhaidsaicnaincianciansc"), video_name: "Zack's League")
    }
}

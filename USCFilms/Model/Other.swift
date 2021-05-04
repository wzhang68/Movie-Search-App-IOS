//
//  Other.swift
//  USCFilms
//
//  Created by WEI ZHANG on 4/24/21.
//

import Foundation



//            VStack(alignment:.leading, spacing: 10){
//                VStack{
//                    YoutubeUI(videoID: detail.video_youtube)
//                }
//                .frame(width: UIScreen.main.bounds.width * 0.95, height:250, alignment:.top)
//                .aspectRatio(16/9,contentMode: .fit)
//                VStack{
//                    Text(detail.video_name)
//                        .font(.largeTitle)
//                        .fontWeight(.heavy)
//                        .frame(alignment:.leading)
//                }
//                VStack{
//                    Text(String(detail.video_release.prefix(4)) + "|" + detail.video_genre.dropLast(2) )
//                        .font(.title3)
//                }.frame(alignment:.leading)
//
//                HStack{
//                    Image(systemName: "star.fill")
//                        .foregroundColor(.red)
//                    Text(String(format: "%.1f",detail.video_rate/2) + "/5.0")
//                        .font(.title3)
//                }
//
//                if(self.showDetails == false){
//                    VStack(alignment: .trailing){
//                        Text(detail.video_overview)
//                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
//                            .lineLimit(3)
//                            .padding(.bottom, 5)
//                        Button(action:{
//                            showDetails.toggle()
//                        }) {
//
//                            Text("Show more..")
//                                .foregroundColor(.black)
//                                .opacity(0.7)
//                        }
//                    }
//                }else{
//                    VStack(alignment: .trailing){
//                        Text(detail.video_overview)
//                            .frame(maxHeight: .infinity)
//                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
//                            .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
//                            .padding(.bottom, 5)
//                        Button(action:{
//                            showDetails.toggle()
//                        }) {
//
//                            Text("Show less..")
//                                .foregroundColor(.black)
//                                .opacity(0.7)
//                        }
//
//                    }
//                }
//                VStack(alignment: .leading){
//                    Text("Reviews")
//                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
//                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                    ForEach(detail.reviews){
//                        review in
//                        NavigationLink(destination: TestView()){
//                            VStack{
//                                VStack(alignment: .leading, spacing: 10){
//                                    // Username and Date
//                                    VStack{
//                                        Text("A review by " + review.username)
//                                            .font(.headline)
//                                            .fontWeight(.bold)
//                                            .frame(minWidth:0, maxWidth: .infinity, alignment: .leading)
//                                        Text("Written by " + review.username + " on " + review.date)
//                                            .font(.subheadline)
//                                            .foregroundColor(.black)
//                                            .opacity(0.6)
//                                            .frame(minWidth:0, maxWidth: .infinity, alignment: .leading)
//                                    }
//                                    // Rating
//                                    HStack{
//                                        Image(systemName: "star.fill")
//                                            .foregroundColor(.red)
//                                        Text(String(format: "%.1f",Float(review.rating/2)) + "/5.0")
//                                            .font(.title3)
//                                            .frame(minWidth:0, maxWidth: .infinity, alignment: .leading)
//                                    }
//                                    // Content
//                                    VStack{
//                                        Text(review.content)
//                                            .lineLimit(3)
//
//                                    }
//                                }.padding()
//                            } //VSTACK END
//                            .frame(minWidth: 0, maxWidth: .infinity)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 10)
//                                    .stroke(Color.black, lineWidth: 1)
//                                    .opacity(0.7)
//                            )
//                        }//NavLink END
//                        .buttonStyle(PlainButtonStyle())
//                    }
//                }

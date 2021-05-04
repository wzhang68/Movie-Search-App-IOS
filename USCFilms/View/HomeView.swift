//
//  HomeView.swift
//  USCFilms
//
//  Created by WEI ZHANG on 4/23/21.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeVM = HomeViewModel()
    @EnvironmentObject var likeVM:LikeViewModel
    
    @State var ismv = true
    
    @State var tvbtnhidden = false
    @State var mvbtnhidden = true
    
//    @State var showToast = false
//    @Binding var toastText:String
        
    var body: some View {
        if(self.homeVM.fetched == false){
            ProgressView("Fetching Data...").onAppear{
                self.homeVM.fetchAll()
            }
        }else{
            NavigationView{
                ScrollView(.vertical) {
                    VStack{
                        // NowPlaying OR Trending
                        if(ismv){
                            VStack(alignment: .leading){
                                Text("Now Playing")
                                    .font(.title)
                                    .bold()
                                    .frame(alignment: .leading)
                                    .padding(.horizontal)
                                CarouselView(movies: $homeVM.nowplaying)
                            }
                        }else{
                            VStack(alignment: .leading){
                                Text("Trending")
                                    .font(.title)
                                    .bold()
                                    .frame(alignment: .leading)
                                    .padding(.horizontal)
                                CarouselView(movies: $homeVM.trending)
                            }
                        }
                        
                        Spacer()
                        // TOP RATED
                        if(ismv){
                            VStack(alignment: .leading){
                                HStack{
                                    Text("Top Rated")
                                        .font(.title)
                                        .bold()
                                        .frame(alignment: .leading)
                                        .padding(.horizontal)
                                    Spacer()
                                }
                                SmallCardView(movies: $homeVM.topmv)
                                Spacer()
                            }
                        }else{
                            VStack(alignment: .leading){
                                HStack{
                                    Text("Top Rated")
                                        .font(.title)
                                        .bold()
                                        .frame(alignment: .leading)
                                        .padding(.horizontal)
                                    Spacer()
                                }
                                SmallCardView(movies: $homeVM.toptv)
                                Spacer()
                            }
                        }
                        
                        Spacer()
                        
                        // POPULAR
                        if(ismv){
                            VStack(alignment: .leading){
                                HStack{
                                    Text("Popular")
                                        .font(.title)
                                        .bold()
                                        .frame(alignment: .leading)
                                        .padding(.horizontal)
                                    Spacer()
                                }
                                SmallCardView(movies:$homeVM.popmv)
                                Spacer()
                            }
                        }else{
                            VStack(alignment: .leading){
                                HStack{
                                    Text("Popular")
                                        .font(.title)
                                        .bold()
                                        .frame(alignment: .leading)
                                        .padding(.horizontal)
                                    Spacer()
                                }
                                SmallCardView(movies:$homeVM.poptv)
                                Spacer()
                            }
                        }
                        
                        Spacer()
                        
                        Group{
                            Link("Powered by TMDB", destination: URL(string: "https://www.themoviedb.org/?language=en-US")!)
                            Text("Developed by Wei Zhang")
                        }
                        .font(.system(size:12))
                        .frame(alignment: .bottom)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    }
                }
                .navigationBarTitle("USC Films",displayMode: .large)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing:0 ))
//                .toast(isShowing: $showToast, text: Text(detailMV.video_name))
                .toolbar {
                    ToolbarItem(placement: .primaryAction)
                    {
                        if(!self.tvbtnhidden){
                            Button("TV shows") {
                                self.ismv = false
                                self.tvbtnhidden = true
                                self.mvbtnhidden = false
                            }
                        }
                        if(!self.mvbtnhidden){
                            Button("Movies") {
                                self.ismv = true
                                self.tvbtnhidden = false
                                self.mvbtnhidden = true
                            }
                        }
                        
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

//
//  SearchResults.swift
//  USCFilms
//
//  Created by WEI ZHANG on 4/26/21.
//

import SwiftUI

struct SearchResults: View {
    var query:String
    @ObservedObject var searchVM: SearchViewModel
    
    init(query:String){
        self.query = query
        self.searchVM = SearchViewModel(query:query)
    }
    var body: some View {
        if(self.searchVM.fetched){
            ScrollView(.vertical){
                if(self.searchVM.movies.count == 0){
                    Text("No Results")
                        .font(.title)
                        .foregroundColor(.black)
                        .opacity(0.5)
                }else if(self.searchVM.movies.count > 0) {
                    ForEach(self.searchVM.movies){ mv in
                        Card(result: mv)
                            .cornerRadius(20)
                    }
                }
            }.padding()
        }
    }
}

struct Card: View{
    var result:SearchResult
    
    var body: some View{
        NavigationLink(destination:DetailView(video_id: result.id, video_type: result.media_type, poster: result.poster)){
            ZStack(alignment: .topLeading){
                RemoteImage(url: "https://image.tmdb.org/t/p/w500"+result.backdrop)
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
                
                VStack(alignment: .leading){
                    Text(result.media_type + "(\(String(result.release.prefix(4))))")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                }.offset(x: 20,y: 15)
                
                HStack{
                    Image(systemName: "star.fill")
                        .foregroundColor(.red)
                    Text(String(format: "%.1f",Float(result.rating/2)))
                        .foregroundColor(.white)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }.offset(x: 280,y: 15)
                
                VStack(alignment: .leading){
                    Text(result.name)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }.offset(x: 20,y: 165)
            }
        }
    }
}

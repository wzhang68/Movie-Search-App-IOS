//
//  ContentView.swift
//  USCFilms
//
//  Created by WEI ZHANG on 4/23/21.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 2
    @StateObject var likeVM = LikeViewModel()
    
    var body: some View {
        
        TabView (selection: $selection) {
            SearchView().tabItem
            {
                Image(systemName: "magnifyingglass")
                    .padding()
                Text("Search")
                    .padding()
            }.tag(1)
            HomeView().tabItem
            {
                Image(systemName: "house")
                    .padding()
                Text("Home")
                    .padding()
            }.tag(2)
            FavoriteView().tabItem
            {
                Image(systemName: "heart")
                    .padding()
                Text("Favorite")
                    .padding()
            }.tag(3)
        }.environmentObject(likeVM)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

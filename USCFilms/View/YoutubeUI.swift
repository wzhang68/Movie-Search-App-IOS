//
//  YoutubeUI.swift
//  USCFilms
//
//  Created by WEI ZHANG on 4/26/21.
//

import SwiftUI
import youtube_ios_player_helper

struct YoutubeUI: UIViewRepresentable {
    var videoID : String
    
    func makeUIView(context: Context) -> YTPlayerView {
//        let playvarsDic = ["controls": 1, "playsinline": 1, "autohide": 1, "showinfo": 1, "autoplay": 0, "modestbranding": 1]
        let playerView = YTPlayerView()
//        playerView.load(withVideoId: videoID, playerVars: playvarsDic)
        return playerView
    }
    
    func updateUIView(_ uiView: YTPlayerView, context: Context) {
        let playvarsDic = ["controls": 1, "playsinline": 1, "autohide": 1, "showinfo": 1, "autoplay": 0, "modestbranding": 1]
        uiView.load(withVideoId: videoID,playerVars: playvarsDic)
    } 
}


//
//  SearchBar.swift
//  USCFilms
//
//  Created by WEI ZHANG on 4/23/21.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    @Binding var text:String
    var placeholder:String
    @ObservedObject var searchVM:SearchViewModel
    
    class Coordinator: NSObject, UISearchBarDelegate{
        @Binding var text:String
        @ObservedObject var searchVM:SearchViewModel
        
        init(text: Binding<String>, searchVM:SearchViewModel ) {
            _text = text
            self.searchVM = searchVM
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchBar.setShowsCancelButton(true, animated: true)
        }
        
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        
            self.text = ""
            searchBar.text = nil
            searchVM.movies.removeAll()
            searchBar.setShowsCancelButton(false, animated: true)
            searchBar.endEditing(true)
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
            searchBar.endEditing(true)
            searchBar.showsCancelButton = false
        }
    }
    
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text, searchVM: searchVM)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        searchBar.placeholder = "Search Movies,TVs..."
        return searchBar
    }
    
    
    
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
    
}


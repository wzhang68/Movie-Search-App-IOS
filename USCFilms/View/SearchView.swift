//
//  SearchView.swift
//  USCFilms
//
//  Created by WEI ZHANG on 4/23/21.
//

import SwiftUI

struct SearchView: View {

    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    @State private var log: String = "Logs: "
    @ObservedObject var searchVM = SearchViewModel(query: "")
    

    var body: some View {
            NavigationView {
                VStack { 
                    SearchBar(text: $searchText, placeholder: "Search Movies,TVs...", searchVM: searchVM)
                    SearchResults(query: searchText)
                    Spacer()
                }.navigationBarTitle(Text("Search"))
            }
        }
    

}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}


extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}

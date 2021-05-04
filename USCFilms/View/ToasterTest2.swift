//
//  ToasterTest2.swift
//  USCFilms
//
//  Created by WEI ZHANG on 4/29/21.
//

import SwiftUI

struct ToasterTest2: View {
    @State private var showToast = false

    var body: some View {
//           ZStack {
//               // your view
//           }
//           .popup(presented: $showToast, autohideIn: 2) {
//               HStack {
//                   Text("The popup")
//               }
//               .frame(width: 200, height: 60)
//               .background(Color(red: 0.85, green: 0.8, blue: 0.95))
//               .cornerRadius(30.0)
//           }
        Text("s")
       }
        
}

struct ToasterTest2_Previews: PreviewProvider {
    static var previews: some View {
        ToasterTest2()
    }
}

    struct TVShow: Identifiable {
        var id: String { name }
        let name: String
    }

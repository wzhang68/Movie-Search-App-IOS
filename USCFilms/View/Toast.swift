//
//  Toast.swift
//  USCFilms
//
//  Created by WEI ZHANG on 4/29/21.
//

import SwiftUI

struct Toast<Presenting>: View where Presenting: View {
    
    /// The binding that decides the appropriate drawing in the body.
    @Binding var isShowing: Bool
    /// The view that will be "presenting" this toast
    let presenting: () -> Presenting
    /// The text to show
    let text: Text
    
    var body: some View {
        
//        GeometryReader { geometry in

            ZStack(alignment: .center) {
                self.presenting()
                    .blur(radius: self.isShowing ? 1 : 0)
                Spacer()
                VStack {
                    self.text
                }
                .frame(width: UIScreen.main.bounds.width * 0.6,
                       height: 60, alignment: .center)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(30)
                .transition(.slide)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                      withAnimation {
                        self.isShowing = false
                      }
                    }
                }
                .opacity(self.isShowing ? 1 : 0)
                
            }
            
//        }
        
    }
}
    
    extension View {
        
        func toast(isShowing: Binding<Bool>, text: Text) -> some View {
            Toast(isShowing: isShowing,
                  presenting: { self },
                  text: text)
        }
        
    }

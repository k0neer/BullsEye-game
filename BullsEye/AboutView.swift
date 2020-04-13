//
//  AboutView.swift
//  BullsEye
//
//  Created by Kiryl Beliauski on 4/13/20.
//  Copyright © 2020 Kiryl Beliauski. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    
    //constants
    let beige = Color(red: 1, green: 0.84, blue: 0.7)
    
    
    var body: some View {
        Group {
            VStack {
                Text("🎯 Bullseye 🎯")
                    .modifier(AboutHeadingStyle())
                    .navigationBarTitle("About BullsEye")
                Text("This is Bullseye, the game where you can win points and earn fame by dragging a slider.")
                    .modifier(AboutBodyStyle())
                    .lineLimit(nil)
                Text("Your goal is to place the slider as close as possible to the target value. The closer you are, the more points you score.")
                    .modifier(AboutBodyStyle())
                    .lineLimit(nil)
                Text("Enjoy!")
                    .modifier(AboutBodyStyle())
            }
            .background(beige)
        }
    .background(Image("Background"))

    }
}

//view modifiers
//============

struct AboutHeadingStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Arial Rounded MT Bold", size: 30))
                  .foregroundColor(Color.black)
                  .padding(.top, 20)
                  .padding(.bottom, 20)
    }
}

struct AboutBodyStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(Font.custom("Arial Rounded MT Bold", size: 16))
      .foregroundColor(Color.black)
      .padding(.leading, 60)
      .padding(.trailing, 60)
      .padding(.bottom, 20)
  }
}


struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}

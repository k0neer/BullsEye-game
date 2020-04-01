//
//  ContentView.swift
//  BullsEye
//
//  Created by Kiryl Beliauski on 3/29/20.
//  Copyright © 2020 Kiryl Beliauski. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    //properties
    //==========
    
    //User interface views
    @State var alertIsVisible: Bool = false
    @State var sliderValue: Double = 50
    
    //User interface content and layout
    var body: some View {
        VStack {
            Spacer()
            
            //Target row
            HStack {
                Text("Pull the bulls eye as close as you can to:")
                Text("100")
            }
            
            Spacer()
            
            //Slider row
            HStack {
                Text("1")
                Slider(value: self.$sliderValue, in: 1...100)
                Text("100")
            }
            
            Spacer()
            
            //button row
            Button(action: {
                print("Button pressed!")
                self.alertIsVisible = true
            }) {
                Text("Hit me!")
            }
            .alert(isPresented: self.$alertIsVisible) {
                Alert(title: Text("Hello there!"),
                      message: Text("The slider's value is \(Int(self.sliderValue.rounded()))."),
                    dismissButton: .default(Text("Awesome!")))
            }
            
            Spacer()
            
            //score row
            HStack {
                Button(action: {}) {
                    Text("Start Over")
                }
                Spacer()
                Text("Score:")
                Text("999999")
                
                Spacer()
                Text("Round:")
                Text("999")
                
                Spacer()
                Button(action: {}) {
                    Text("Info")
                }
            }
            .padding(.bottom, 20)
        }
    }
    
    //Methods
    //=======
}

//preview
//=======

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

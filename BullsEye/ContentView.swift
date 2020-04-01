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
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    
    var sliderValueRounded: Int {
        Int(self.sliderValue.rounded())
    }
    
    //User interface content and layout
    var body: some View {
        //User interface views
        VStack {
            Spacer()
            
            //Target row
            HStack {
                Text("Pull the bulls eye as close as you can to:")
                Text("\(self.target)")
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
                      message: Text(self.scoringMessage()),
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
    func pointsForCurrentRound() -> Int {
        let difference: Int
        if sliderValueRounded > self.target {
          difference = sliderValueRounded - self.target
        } else if self.target > sliderValueRounded {
          difference = self.target - sliderValueRounded
        } else {
          difference = 0
        }
        
        return 100 - difference
    }
    
    func scoringMessage() -> String {
        return  "The slider's value is \(self.sliderValueRounded).\n" +
                "The target value is \(self.target).\n" +
                "You scored \(self.pointsForCurrentRound()) points this round."
    }
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

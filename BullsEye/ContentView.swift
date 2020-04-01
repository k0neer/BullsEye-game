//
//  ContentView.swift
//  BullsEye
//  version 1.0
//
//  Created by Kiryl Beliauski on 3/29/20.
//  Copyright © 2020 Kiryl Beliauski. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    //properties
    //==========
    
    //User interface views
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 1
    
    var sliderValueRounded: Int {
        Int(self.sliderValue.rounded())
    }
    
    //User interface content and layout
    var body: some View {
        
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
                      dismissButton: .default(Text("Awesome!")) {
                        self.score += self.pointsForCurrentRound()
                        self.target = Int.random(in: 1...100)
                    }
                )
            }
            
            Spacer()
            
            //score row
            HStack {
                Button(action: {}) {
                    Text("Start Over")
                }
                Spacer()
                Text("Score:")
                Text("\(self.score)")
                
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
        let maximumScore = 100
        let difference = abs(sliderValueRounded - self.target)
        return maximumScore - difference
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

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
        Int(sliderValue.rounded())
    }
    var sliderTargetDifference: Int {
        abs(sliderValueRounded - target)
    }
    
    //User interface content and layout
    var body: some View {
        
        VStack {
            Spacer()
            
            //Target row
            HStack {
                Text("Pull the bulls eye as close as you can to:")
                    .font(Font.custom("Arial Rounded MT Bold", size: 18))
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 5, x: 2, y: 2)
                Text("\(target)")
                    .font(Font.custom("Arial Rounded MT Bold", size: 24))
                    .foregroundColor(.yellow)
                    .shadow(color: .black, radius: 5, x: 2, y: 2)
            }
            
            Spacer()
            
            //Slider row
            HStack {
                Text("1")
                Slider(value: $sliderValue, in: 1...100)
                Text("100")
            }
            
            Spacer()
            
            //button row
            Button(action: {
                print("Button pressed!")
                self.alertIsVisible = true
            }) {
                Text("Hit me!")
                    .font(Font.custom("Arial Rounded MT Bold", size: 18))
                    .foregroundColor(.black)
            }
            .background(Image("Button"))
            .shadow(color: .black, radius: 5, x: 2, y: 2)
            .alert(isPresented: $alertIsVisible) {
                Alert(title: Text(alertTitle()),
                      message: Text(scoringMessage()),
                      dismissButton: .default(Text("Awesome!")) {
                        self.startNewRound()
                    }
                )
            }
            
            Spacer()
            
            //score row
            HStack {
                Button(action: {
                    self.startNewGame()
                }) {
                    Text("Start Over")
                }
                Spacer()
                Text("Score:")
                    .font(Font.custom("Arial Rounded MT Bold", size: 18))
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 5, x: 2, y: 2)
                Text("\(score)")
                    .font(Font.custom("Arial Rounded MT Bold", size: 24))
                    .foregroundColor(.yellow)
                    .shadow(color: .black, radius: 5, x: 2, y: 2)
                Spacer()
                Text("Round:")
                    .font(Font.custom("Arial Rounded MT Bold", size: 18))
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 5, x: 2, y: 2)
                Text("\(round)")
                    .font(Font.custom("Arial Rounded MT Bold", size: 24))
                    .foregroundColor(.yellow)
                    .shadow(color: .black, radius: 5, x: 2, y: 2)
                Spacer()
                Button(action: {}) {
                    Text("Info")
                }
            }
            .padding(.bottom, 20)
        }
        .onAppear() {
            self.startNewGame()
        }
        .background(Image("Background"))
    }
    
    //Methods
    func pointsForCurrentRound() -> Int {
        let maximumScore = 100
        let points: Int
        if sliderTargetDifference == 0 {
            points = 200
        } else if sliderTargetDifference == 1 {
            points = 150
        } else {
            points = maximumScore - sliderTargetDifference
        }
        return points
    }
    
    func scoringMessage() -> String {
        return  "The slider's value is \(sliderValueRounded).\n" +
                "The target value is \(target).\n" +
                "You scored \(pointsForCurrentRound()) points this round."
    }
    
    func alertTitle() -> String {
        let title: String
        if sliderTargetDifference == 0 {
            title = "Perfect!"
        } else if sliderTargetDifference < 5 {
            title = "You almost had it!"
        } else if sliderTargetDifference <= 10 {
            title = "Not bad."
        } else {
            title = "Are you even trying?"
        }
        return title
    }
    func startNewGame() {
        score = 0
        round = 1
        resetSliderAndTarget()
    }
    func startNewRound() {
        score += self.pointsForCurrentRound()
        round += 1
        resetSliderAndTarget()
    }
    func resetSliderAndTarget() {
        sliderValue = Double.random(in: 1...100)
        target = Int.random(in: 1...100)
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

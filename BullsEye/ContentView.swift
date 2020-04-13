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
    
    //colors
    let midnightBlue = Color(red: 0, green: 0.2, blue: 0.4)
    
    //game stats
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
        NavigationView {
            VStack {
                Spacer().navigationBarTitle("🎯 Bullseye 🎯")
                
                //Target row
                HStack {
                    Text("Pull the bulls eye as close as you can to:")
                        .modifier(LabelStyle())
                    Text("\(target)")
                        .modifier(ValueStyle())
                }
                
                Spacer()
                
                //Slider row
                HStack {
                    Text("1")
                        .modifier(LabelStyle())
                    Slider(value: $sliderValue, in: 1...100)
                        .accentColor(.green)
                        .animation(.easeOut)
                    Text("100")
                        .modifier(LabelStyle())
                }
                
                Spacer()
                
                //button row
                Button(action: {
                    print("Button pressed!")
                    self.alertIsVisible = true
                }) {
                    Text("Hit me!")
                        .modifier(ButtonLargeTextStyle())
                }
                .background(Image("Button")
                    .modifier(Shadow())
                )
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
                        HStack {
                            Image("StartOverIcon")
                            Text("Start Over")
                                .modifier(ButtonSmallTextStyle())
                        }
                        
                    }
                    .background(Image("Button")
                        .modifier(Shadow())
                    )
                    Spacer()
                    Text("Score:")
                        .modifier(LabelStyle())
                    Text("\(score)")
                        .modifier(ValueStyle())
                    Spacer()
                    Text("Round:")
                        .modifier(LabelStyle())
                    Text("\(round)")
                        .modifier(ValueStyle())
                    Spacer()
                    NavigationLink(destination: AboutView()) {
                        HStack {
                            Image("InfoIcon")
                            Text("Info")
                                .modifier(ButtonSmallTextStyle())
                        }
                    }
                    .background(Image("Button")
                        .modifier(Shadow())
                    )
                }
                .accentColor(midnightBlue)
                .padding(.bottom, 20)
            }
            .onAppear() {
                self.startNewGame()
            }
            .background(Image("Background"))
        }
        .navigationViewStyle(StackNavigationViewStyle())
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

//View Modifiers
//==============

struct LabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Arial Rounded MT Bold", size: 18))
            .foregroundColor(.white)
            .modifier(Shadow())
    }
}

struct ValueStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Arial Rounded MT Bold", size: 24))
            .foregroundColor(.yellow)
            .modifier(Shadow())
    }
}

struct Shadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .black, radius: 5, x: 2, y: 2)
    }
}

struct ButtonLargeTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Arial Rounded MT Bold", size: 18))
            .foregroundColor(.black)
    }
}

struct ButtonSmallTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Arial Rounded MT Bold", size: 12))
            .foregroundColor(.black)
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

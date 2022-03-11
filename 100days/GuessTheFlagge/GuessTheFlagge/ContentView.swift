//
//  ContentView.swift
//  GuessTheFlagge
//
//  Created by markd on 3/10/22.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria",
                                    "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)

    @State private var showingScore = false
    @State private var scoreTitle = ""

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Very Incorrect"
        }
        showingScore = true
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
        
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                             .init(color: Color(red: 0.1, green: 0.2, blue: 0.45),  location: 0.3),
                             .init(color: Color(red: 0.76, green: 0.15, blue: 0.26),  location: 0.3),
                           ], center: .top, startRadius: 200, endRadius: 400)
              .ignoresSafeArea()

            VStack {
                Text("Guess the Flag")
                  .font(.largeTitle.weight(.bold))
                  .foregroundColor(.white)

                VStack(spacing: 15) {
                    VStack {
                        Text("Tappy the flag of")
                          .font(.subheadline.weight(.heavy))
                          .foregroundColor(.white)
                        Text(countries[correctAnswer])
                          .font(.largeTitle.weight(.semibold))
                          .foregroundColor(.white)
                    }
                    VStack {
                        ForEach(0..<3) { number in
                            Button {
                                flagTapped(number)
                            } label: {
                                Image(countries[number])
                                  .renderingMode(.original)
                                  .clipShape(Capsule())
                                  .shadow(radius: 5)
                            }
                        }
                    }
                }
                  .frame(maxWidth: .infinity)
                  .padding(.vertical, 20)
                  .background(.regularMaterial)
                  .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is _wat_")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

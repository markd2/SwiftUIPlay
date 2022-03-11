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
    @State private var scoreSubtitle = ""
    @State private var score: Int = 0

    @State private var showingFinale = false
    @State private var questionCount = 5

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreSubtitle = "Good on you"
            score += 1
        } else {
            scoreTitle = "Very Incorrect"
            scoreSubtitle = "That's the flag of \(countries[number])"
            score -= 1
        }

        questionCount -= 1
        if questionCount < 0 {
            showingFinale = true
            showingScore = false
        } else {
            showingScore = true
        }
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }

    func reset() {
        countries = countries.shuffled()
        score = 0
        questionCount = 5
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
                Spacer()

                VStack(spacing: 15) {
                    VStack {
                        Text("Tappy the flag of")
                          .font(.subheadline.weight(.heavy))
                          .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                          .font(.largeTitle.weight(.semibold))
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

                Spacer()
                Spacer()

                Text("Score: \(score)")
                  .foregroundColor(.white)
                  .font(.title.bold())

                Spacer()
            }.padding()
        }

        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(scoreSubtitle)
        }

        .alert("All Done!!", isPresented: $showingFinale) {
            Button("WHOOP WHOOP") {
                print("SNORGLE")
                reset()
            }
        } message: {
            Text(scoreSubtitle)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

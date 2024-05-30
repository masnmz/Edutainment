//
//  ContentView.swift
//  Edutainment
//
//  Created by Mehmet Alp Sönmez on 29/05/2024.
//

import SwiftUI

struct Question {
    var firstPart = 0
    var secondPart = 0
    
    var trueAnswer: Int {
          firstPart * secondPart
    }
    
    var question: String {
        return ("What is \(firstPart) x \(secondPart) ?")
    }
        
    
}


struct ContentView: View {
    @State private var multiplicationTable = Question(firstPart: 2, secondPart: 2)
    @State private var numbersOfQuestions = 2
    @State private var questions = [(text: String, answer: Int)]()
    @State private var currentQuestionIndex = 0
    @State private var userAnswer = Int()
    @State private var userScore = 0
    @State private var startGame = false
    @State private var gameAlert = false
    @State private var answerAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
        
    var body: some View {
        VStack {
            List {
                Section("Game Setup") {
                    Text("Choose Multiplication Table")
                        .font(.title3)
                    Stepper("Multiplication Table", value: $multiplicationTable.firstPart, in: 2...12)
                        .onChange(of: multiplicationTable.firstPart) {
                            generateQuestions()
                        }
                    
                    Text("Selected table: \(multiplicationTable.firstPart)")
                    
                    Picker("Number of Questions:", selection: $numbersOfQuestions) {
                        ForEach(2..<11, id: \.self){
                            Text("\($0)")
                        }
                        .onChange(of: numbersOfQuestions) {
                            generateQuestions()
                        }
                    }
                }
                VStack {
                    Button("Start Game") {
                        startGame = true
                        generateQuestions()
                        userScore = 0
                    }.buttonBorderShape(.capsule)
                        .background()
                }

                if startGame {
                    Section("Game") {
                        Text(questions[currentQuestionIndex].text)
                        TextField("Enter your answer here", value: $userAnswer, format: .number)
                            .keyboardType(.numberPad)
                            .onSubmit() {
                                checkAnswer()
                            }
                    }
                    
                    Section{
                        Text("Your Score:")
                        Text("\(userScore)")
                    }
                }
            }
            .alert(alertTitle, isPresented: $answerAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
            .alert("End of the Game", isPresented: $gameAlert) {
                Button("Ok", role:.cancel) {}
            } message: {
                Text("You finished the game. Your score: \(userScore)" )
            }

        }
        .scrollContentBackground(.hidden)
        .background(LinearGradient(colors: [.yellow, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing))
    }
    
    func generateQuestions() {
        questions.removeAll()
        var secondPart = [Int]()
        for j in 1...12 {
            secondPart.append(j)
        }
        for _ in 2..<(numbersOfQuestions + 2) {
            let question = Question(firstPart: multiplicationTable.firstPart, secondPart: secondPart.randomElement() ?? 2)
            questions.append((question.question, question.trueAnswer))
        }
        currentQuestionIndex = 0
    }
    
    func checkAnswer() {
            if userAnswer == questions[currentQuestionIndex].answer {
                userScore += 1
                alert(title: "Correct Answer", message: "Score: +1")
            } else {
                alert(title: "Wrong Answer", message: "Ooopss. You need to calculate carefully")
                
            }
        if currentQuestionIndex < questions.count - 1 {
                currentQuestionIndex += 1
            } else {
                generateQuestions()
                startGame = false
                gameAlert = true
                
            }
            userAnswer = 0
        }
    
    func alert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        answerAlert = true
        
    }
}

#Preview {
    ContentView()
}

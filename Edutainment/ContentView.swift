//
//  ContentView.swift
//  Edutainment
//
//  Created by Mehmet Alp Sönmez on 29/05/2024.
//

import SwiftUI

struct Question {
    
    
    
        
    
}

struct ContentView: View {
    @State private var multiplicationTable = 2
    @State private var numbersOfQuestions = 2
    @State private var questionList = [String]()
    
    
    
    var body: some View {
        VStack {
            List {
                Section("Question Setup") {
                    Text("Choose Multiplication Table")
                        .font(.title3)
                    Stepper("Multiplication Table", value: $multiplicationTable, in: 2...12)
                    Text("Selected table: \(multiplicationTable)")
                    
                    Picker("Number of Questions:", selection: $numbersOfQuestions) {
                        ForEach(2..<11){
                            Text("\($0)")
                        }
                    }
                }
                Section {
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

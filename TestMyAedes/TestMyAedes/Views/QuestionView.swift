//
//  QuestionView.swift
//  TestMyAedes
//
//  Created by Riccardo Di Stefano on 20/04/24.
//

import SwiftUI

struct QuestionView: View {
    @Binding var currentQuestion: Question
    @Binding var currentQuestionIndex: Int
    @StateObject var questionsVM: QuestionViewModel
    
    
    @State var canColorButtons: Bool = false
    @State var hasTimeElapsed: Bool = false
    @State var canShowAlert: Bool = false
    
    private func selectAnswer(_ answer: String) -> Bool {
        return answer == currentQuestion.correctAnswer
    }
    
    private func delayAlert() async {
        try? await Task.sleep(nanoseconds: 2000000000)
        hasTimeElapsed = true
    }
    
    private func delayCorrect() async {
        try? await Task.sleep(nanoseconds: 1000000000)
        
    }
    
    var body: some View {
        
        NavigationStack(path: $questionsVM.path) {
            VStack {
                Text("punteggio: \(questionsVM.currentScore)")
                    .padding()
                    .font(.headline)
                
                ZStack {
                    RoundedRectangle(cornerSize: CGSize(width: 20, height: 10))
                        .frame(width: 350, height: 300)
                        .foregroundStyle(.cyan)
                        .shadow(radius: 5)
                    
                    VStack {
                        Image(currentQuestion.imageString ?? "placeHolder")
                            .resizable()
                            .frame(width: 100, height: 100)
                        
                            .padding()
                        Text(currentQuestion.question)
                    }
                    Spacer()
                }
                
                Spacer()
                
                ForEach(currentQuestion.answers, id: \.self) { answer in
                    Button (action: {
                        
                        $currentQuestion.selectedAnswer.wrappedValue = answer
                        
                        if(answer != $currentQuestion.correctAnswer.wrappedValue) {
                            canShowAlert.toggle()
                        }else {
                            questionsVM.addToScore(currentQuestion.point)
                            Task {
                                await delayCorrect()
                                
                                
                                currentQuestionIndex += 1
                                
                                
                            }
                            
                        }
                        
                        canColorButtons = true
                        
                    }, label: {
                        ZStack {
                            
                            if(canColorButtons) {
                                if(answer == currentQuestion.correctAnswer && answer == currentQuestion.selectedAnswer) {
                                    RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                                        .frame(width: 350, height: 50)
                                        .foregroundStyle(Color(uiColor: .systemGreen))
                                }else if (answer != currentQuestion.correctAnswer && answer == currentQuestion.selectedAnswer) {
                                    RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                                        .frame(width: 350, height: 50)
                                        .foregroundStyle(Color(uiColor: .systemRed))
                                }else {
                                    RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                                        .frame(width: 350, height: 50)
                                        .foregroundStyle(Color(uiColor: .systemGray))
                                }
                            }else {
                                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                                    .frame(width: 350, height: 50)
                                    .foregroundStyle(Color(uiColor: .systemGray))
                            }
                            Text(answer)
                                .foregroundStyle(.black)
                        }
                    })
                }
                
                Spacer()
                
                    .onChange(of: canShowAlert) { oldValue, newValue in
                        Task {
                            await delayAlert()
                        }
                    }
                
                    .alert("Risposta Errata", isPresented: $hasTimeElapsed) {
                        Button {
                            currentQuestionIndex += 1
                        } label: {
                            Text("OK")
                        }
                        
                    } message: {
                        Text("la domanda corretta era \(currentQuestion.correctAnswer)")
                    }
                
                    .gesture(DragGesture())
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    QuestionView(currentQuestion: .constant(Question.mockData[0]), currentQuestionIndex: .constant(0), questionsVM: QuestionViewModel())
    
}

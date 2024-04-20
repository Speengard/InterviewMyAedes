//
//  EndTestView.swift
//  TestMyAedes
//
//  Created by Riccardo Di Stefano on 20/04/24.
//

import SwiftUI

struct EndTestView: View {
    @Binding var highScore: Int
    @Binding var tagSelection: Int
    @ObservedObject var questionsVM: QuestionViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    RoundedRectangle(cornerSize: CGSize(width: 20, height: 10))
                        .frame(width: 350, height: 350)
                        .foregroundStyle(.green)
                        .shadow(radius: 10)
                    VStack {
                        Text("congratulazioni! hai effettuato")
                        Text(String(questionsVM.currentScore) + " punti!")
                    }
                }
                
                NavigationLink {
                    StartGameView()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerSize: CGSize(width: 50, height: 50))
                            .frame(width: 300,height: 50)
                        Text("Torna al menu iniziale")
                            .foregroundStyle(.black)
                    }
                }

            }
        }
        .onAppear(perform: {
            questionsVM.saveScore()
        })
    }
    
}

#Preview {
    EndTestView(highScore: .constant(0), tagSelection: .constant(0), questionsVM: QuestionViewModel())
}

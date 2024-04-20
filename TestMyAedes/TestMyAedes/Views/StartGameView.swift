//
//  ContentView.swift
//  TestMyAedes
//
//  Created by Riccardo Di Stefano on 20/04/24.
//

import SwiftUI

struct StartGameView: View {
    
    @State private var path = NavigationPath()
    @StateObject private var questionsVM = QuestionViewModel()
    @Environment(\.scenePhase) private var scenePhase
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("placeHolder")
                    .resizable()
                    .frame(width: 100, height: 100)
                    
                    .foregroundStyle(.tint)
                
                Text("High score: " + String(questionsVM.highScore))
                    .padding()
                NavigationLink {
                    ViewManager(questionsVM: questionsVM)
                } label: {
                    ZStack {
                        RoundedRectangle(cornerSize: CGSize(width: 50, height: 50))
                            .frame(width: 300,height: 50)
                        Text("Start a new test!")
                            .foregroundStyle(.black)
                    }
                }
                
            }
        }
        .navigationBarBackButtonHidden()

    }
}


#Preview {
    StartGameView()
}

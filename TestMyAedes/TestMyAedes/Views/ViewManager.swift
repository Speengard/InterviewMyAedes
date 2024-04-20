//
//  ViewManager.swift
//  TestMyAedes
//
//  Created by Riccardo Di Stefano on 20/04/24.
//

import SwiftUI

struct ViewManager: View {
    @StateObject var questionsVM: QuestionViewModel
    @State var tabSelection = 0
    
    var body: some View {
        TabView(selection: $tabSelection) {
            ForEach($questionsVM.questions.indices, id: \.self) { q in
                QuestionView(currentQuestion: $questionsVM.questions[q], currentQuestionIndex: $tabSelection, questionsVM: questionsVM)
                    .tag(q)
            }
            
            EndTestView(highScore: $questionsVM.currentScore, tagSelection: $tabSelection, questionsVM: questionsVM)
                .tag($questionsVM.questions.count)
                
        }.tabViewStyle(.page)
    }
}
#Preview {
    ViewManager(questionsVM: QuestionViewModel())
}

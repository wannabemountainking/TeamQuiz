//
//  MainView.swift
//  TeamQuiz
//
//  Created by yoonie on 4/14/26.
//

import SwiftUI


struct MainView: View {
    @State private var vm: TeamQuizViewModel = .init()
    
    var body: some View {
        NavigationStack {
            List {
                HStack {
                    VStack {
                        Text("현재 총점")
                            .font(.caption)
                        Text("\(vm.totalScore)점")
                            .font(.largeTitle)
                    }
                    Spacer()
                    Text(vm.hasPassed ? "통과" : "계속")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(vm.hasPassed ? Color.teal : Color.purple)
                        .padding(10)
                        .padding(.horizontal, 10)
                        .background(vm.hasPassed ? Color.green.opacity(0.3) : Color.red.opacity(0.3))
                        .clipShape(Capsule(style: .circular))
                }
                
                Divider()
                
                
            }
            .navigationTitle("TeamQuiz")
            .navigationBarTitleDisplayMode(.inline)
            .navigationSubtitle("합산 10점 이상이면 다음 라운드")
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
        .padding(20)
    }
}

#Preview {
    MainView()
}

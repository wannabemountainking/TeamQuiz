//
//  MainView.swift
//  TeamQuiz
//
//  Created by yoonie on 4/14/26.
//

import SwiftUI
import Combine


struct MainView: View {
    @State private var vm: TeamQuizViewModel = .init()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    HStack {
                        VStack {
                            Text("현재 총점")
                                .font(.caption)
                            Text("\(vm.totalScore)점")
                                .font(.largeTitle)
                        }
                        Spacer()
                        
                        let passedText = vm.hasPassed ? "통과" : "실패"
                        let passedColor = vm.hasPassed ? Color.teal : Color.purple
                        let passedBackground: Color = vm.hasPassed ? Color.green.opacity(0.3) : Color.red.opacity(0.3)
                        
                        Text(passedText)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(passedColor)
                            .padding(10)
                            .padding(.horizontal, 10)
                            .background(passedBackground)
                            .clipShape(Capsule(style: .circular))
                    } //:VSTACK
                    
                    Divider()
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 20) {
                            Text("P1")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.blue)
                                .padding(15)
                                .background(Color.white.mix(with: .blue, by: 0.2))
                                .clipShape(Circle())
                            Text("플레이어 1")
                                .font(.title2)
                            Text("\(vm.scoreP1)")
                                .font(.largeTitle)
                            
                            VStack(alignment: .center) {
                                Button("+1점") {
                                    vm.p1Publisher.send(vm.scoreP1 + 1)
                                }
                                .font(.title2)
                                .foregroundStyle(.blue)
                                .frame(height: 45)
                                .frame(maxWidth: .infinity)
                                .background(Color.white.mix(with: .blue, by: 0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                                Button("오류 입력") {
                                    vm.p1Publisher.send(-1)
                                }
                                .font(.title3)
                                .foregroundStyle(.orange.opacity(0.8))
                                .frame(height: 45)
                                .frame(maxWidth: .infinity)
                                .background(Color.red.opacity(0.5))
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 10)
                                )
                            } //:VSTACK
                        } //:VSTACK
                        .padding(20)
                        .background(Color.black.opacity(0.4))
                        .clipShape(RoundedRectangle(cornerRadius: 10))

                        VStack(alignment: .leading, spacing: 20) {
                            Text("P2")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.red)
                                .padding(15)
                                .background(Color.white.mix(with: .red, by: 0.2))
                                .clipShape(Circle())
                            Text("플레이어 2")
                                .font(.title2)
                            Text("\(vm.scoreP2)")
                                .font(.largeTitle)
                            
                            VStack(alignment: .center) {
                                Button("+1점") {
                                    vm.p2Publisher.send(vm.scoreP2 + 1)
                                }
                                .font(.title2)
                                .foregroundStyle(.red)
                                .frame(height: 45)
                                .frame(maxWidth: .infinity)
                                .background(Color.white.mix(with: .red, by: 0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                                Button("오류 입력") {
                                    vm.p2Publisher.send(-1)
                                }
                                .font(.title3)
                                .foregroundStyle(.orange.opacity(0.8))
                                .frame(height: 45)
                                .frame(maxWidth: .infinity)
                                .background(Color.red.opacity(0.5))
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 10)
                                )
                            } //:VSTACK
                        } //:VSTACK
                        .padding(20)
                        .background(Color.black.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    } //:HSTACK
                }
            } //:VStack
            .navigationTitle("TeamQuiz")
            .navigationBarTitleDisplayMode(.inline)
            .navigationSubtitle("합산 10점 이상이면 다음 라운드")
            .clipShape(RoundedRectangle(cornerRadius: 15))
        } //:NAVIGATION
        .padding(20)
    }//:body
}

#Preview {
    MainView()
}

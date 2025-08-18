//
//  ArchiveView.swift
//  TalkQ
//
//  Created by Enoch on 4/15/25.
//

import SwiftUI
import SwiftData

struct ArchiveView: View {
    let role: String
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @Query private var assignedQuestions: [AssignedQuestion]
    
    // 멘토 기준 그룹핑 (러너일 때 사용)
    private var mentorDict: [Mentor: [AssignedQuestion]] {
        let nonNil = assignedQuestions.compactMap { aq -> (Mentor, AssignedQuestion)? in
            guard let mentor = aq.mentor else { return nil }
            return (mentor, aq)
        }
        return Dictionary(grouping: nonNil, by: { $0.0 }).mapValues { $0.map { $0.1 } }
    }
    
    // 러너 기준 그룹핑 (멘토일 때 사용)
    private var learnerDict: [Learner: [AssignedQuestion]] {
        let nonNil = assignedQuestions.compactMap { aq -> (Learner, AssignedQuestion)? in
            guard let learner = aq.learner else { return nil }
            return (learner, aq)
        }
        return Dictionary(grouping: nonNil, by: { $0.0 }).mapValues { $0.map { $0.1 } }
    }
    
    var body: some View {
        ScrollView {
            if role == "멘토", learnerDict.isEmpty {
                Text("아직 질문을 받은 러너가 없습니다.")
                    .foregroundColor(.gray)
                    .padding()
            } else if role == "러너", mentorDict.isEmpty {
                Text("아직 질문을 받은 멘토가 없습니다.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                LazyVGrid(columns: columns, spacing: 20) {
                    if role == "멘토" {
                        ForEach(Array(learnerDict.keys), id: \.id) { learner in
                            learnerCard(for: learner)
                        }
                    } else if role == "러너" {
                        ForEach(Array(mentorDict.keys), id: \.id) { mentor in
                            mentorCard(for: mentor)
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("보관함")
    }
    
    // 멘토 카드
    @ViewBuilder
    private func mentorCard(for mentor: Mentor) -> some View {
        let questions = mentorDict[mentor] ?? []
        let hasUnanswered = questions.contains { $0.memo == nil }
        
        ZStack(alignment: .topTrailing) {
            NavigationLink {
                DetailView(mentor: mentor, learner: nil, questions: mentorDict[mentor] ?? [], itemTitle: mentor.name, itemSub: mentor.field)
            } label: {
                ZStack {
                    Group {
                        if mentor.field == "Tech" {
                            Image("Tech")
                                .resizable()
                        } else if mentor.field == "Design" {
                            Image("Design")
                                .resizable()
                        } else if mentor.field == "Domain" {
                            Image("Domain")
                                .resizable()
                        } else {
                            Image("Etc")
                                .resizable()
                        }
                    }
                    .frame(width: 100, height: 100)
                    .cornerRadius(8)
                    
                    Text(mentor.name)
                        .font(Font.custom("UhBee Se_hyun Bold", size: 14))
                        .multilineTextAlignment(.center)
                        .foregroundColor(TalkQApp.TextPrimary)
                        .padding(.bottom, 20)
                }
            }
            .buttonStyle(PlainButtonStyle())
            
            if hasUnanswered {
                Image("NewIcon")
                    .resizable()
                    .frame(width: 21, height: 21)
                    .offset(x: -3, y: 7)
            }
        }
    }
    
    // 러너 카드
    @ViewBuilder
    private func learnerCard(for learner: Learner) -> some View {
        let questions = learnerDict[learner] ?? []
        let hasUnanswered = questions.contains { $0.memo == nil }
        
        ZStack(alignment: .topTrailing) {
            NavigationLink {
                DetailView(mentor: nil, learner: learner, questions: learnerDict[learner] ?? [], itemTitle: learner.name, itemSub: learner.field)
            } label: {
                ZStack {
                    Group {
                        if learner.field == "Tech" {
                            Image("Tech")
                                .resizable()
                        } else if learner.field == "Design" {
                            Image("Design")
                                .resizable()
                        } else if learner.field == "Domain" {
                            Image("Domain")
                                .resizable()
                        } else {
                            Image("Etc")
                                .resizable()
                        }
                    }
                    .frame(width: 100, height: 100)
                    .cornerRadius(8)
                    
                    Text(learner.name)
                        .font(Font.custom("UhBee Se_hyun Bold", size: 14))
                        .multilineTextAlignment(.center)
                        .foregroundColor(TalkQApp.TextPrimary)
                        .padding(.bottom, 20)
                }
            }
            .buttonStyle(PlainButtonStyle())
            
            if hasUnanswered {
                Image("NewIcon")
                    .resizable()
                    .frame(width: 21, height: 21)
                    .offset(x: -3, y: 7)
            }
        }
    }
}

//
//  LoginView.swift
//  TalkQ
//
//  Created by Enoch on 4/15/25.
//

import SwiftUI
import SwiftData

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @Binding var selectedRole: String
    @Binding var userId: String
    
    @State private var selectedField: String = ""
    
    var body: some View {
        ZStack {
            Color.backgroundColor
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
            // MARK: - Logo (개발자 모드 _ 빠른 로그인 기능)
                Button(action: {
                    userId = "Enoch"
                    selectedRole = "러너"
                    selectedField = "테크"
                }) {
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 132.95)
                        .clipped()
                }
                
            // MARK: - 닉네임 입력
                inputNickname(userId: $userId)
                
            // MARK: - 러너/멘토 선택
                HStack {
                    roleButton(title: "러너", tag: "러너", selectedRole: $selectedRole)
                    roleButton(title: "멘토", tag: "멘토", selectedRole: $selectedRole)
                }
                
            // MARK: - 분야 picker
                inputField(selectedField: $selectedField)
            
            // MARK: - login button
                Button(action: {
                    isLoggedIn = true
                }) {
                    ZStack {
                        InnerShadow(buttonColor: isLoginEnabled ? Color.mainColor : Color.lightgrayColor)
                            .frame(width: 259, height: 48)
                        
                        Text("로그인")
                            .padding()
                            .font(Font.custom("SUIT-ExtraBold", size: 20))
                            .frame(maxWidth: .infinity)
                            .foregroundColor(C2App.TextPrimary)
                            .cornerRadius(10)
                    }
                }
                .disabled(!isLoginEnabled)
            }
            .padding(.horizontal, 70)
        }
    }
    
    // MARK: - inputNickname
    struct inputNickname: View {
        @Binding var userId: String
        
        var body: some View {
            ZStack {
                InnerShadow(buttonColor: Color.mainColor.opacity(0.4))
                    .frame(width: 259, height: 48)
                
                TextField("닉네임 (영문)", text: $userId)
                    .font(Font.custom("SUIT-ExtraBold", size: 20))
                    .multilineTextAlignment(.center)
                    .foregroundColor(userId.isEmpty ? Color.lightgrayColor : Color.primaryTextColor)
                    .keyboardType(.alphabet)
            }
        }
    }
    
    // MARK: - inputField
    struct inputField: View {
        @Binding var selectedField: String
        
        var body: some View {
            Menu {
                Picker("분야", selection: $selectedField) {
                    Text("탐색 중").tag("탐색 중")
                    Text("도메인").tag("도메인")
                    Text("디자인").tag("디자인")
                    Text("테크").tag("테크")
                }
            } label: {
                ZStack{
                    InnerShadow(buttonColor: Color.mainColor.opacity(0.4))
                    
                    Text(selectedField.isEmpty ? "분야" : selectedField)
                        .font(Font.custom("SUIT-ExtraBold", size: 20))
                        .foregroundColor(selectedField.isEmpty ? Color.lightgrayColor : Color.primaryTextColor)
                        .multilineTextAlignment(.center)
                    
                    HStack {
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(Color.lightgrayColor)
                    }
                    .padding(.horizontal, 20)
                }
                .frame(width: 259, height: 48)
            }
        }
    }
    
    // MARK: - roleButton
    struct roleButton: View {
        var title: String
        var tag: String
        @Binding var selectedRole: String

        var isSelected: Bool {
            selectedRole == tag
        }

        var imageName: String {
            switch tag {
            case "러너":
                return isSelected ? "learner_selected" : "learner_unselected"
            case "멘토":
                return isSelected ? "mentor_selected" : "mentor_unselected"
            default:
                return ""
            }
        }

        var body: some View {
            Button(action: {
                selectedRole = tag
            }) {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 129.5, height: 48)
            }
            .buttonStyle(PlainButtonStyle()) // 기본 버튼 스타일 제거
            .animation(.easeInOut(duration: 0.5), value: isSelected)
        }
    }
    
    // MARK: - isLoginEnabled
    var isLoginEnabled: Bool {
        !userId.trimmingCharacters(in: .whitespaces).isEmpty &&
        !selectedRole.isEmpty &&
        !selectedField.isEmpty
    }

}


//
//  CreatePostView.swift
//  VKClient
//
//  Created by Matsulenko on 26.12.2023.
//

import SwiftUI

struct CreatePostView: View {
    @Environment(\.dismiss) var dismiss
    
    var token: String
    @State var newPostText: String = ""
    
    var body: some View {
        VStack {
            Text("Create a new post")
                .font(.title2)
            VStack {
                TextField("New post", text: $newPostText, axis: .vertical)
                    .lineLimit(5...10)
                    .padding(10)
            }
            .background(Color.gray.opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(16)
            
            Button(action: {
                buttonTapped()
            }, label: {
                Text("Publish")
            })
            .buttonStyle(
                DefaultButton(backgroundColor: newPostText == "" ? Color.gray : nil)
            )
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .shadow(radius: 5)
        }
    }
    
    private func buttonTapped() {
        if newPostText != "" {
            let guid = UUID().uuidString
            
            Responses.shared.createPost(token: token, message: newPostText, guid: guid) { result in
                switch result {
                case .success(_):
                    dismiss()
                case .failure(let error):
                    print("Something went wrong during profile data setting: \(error.localizedDescription)")
                }
            }
            dismiss()
        }
    }
}

#Preview {
    CreatePostView(token: "")
}

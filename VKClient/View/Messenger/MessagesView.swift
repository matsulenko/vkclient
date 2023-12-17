//
//  MessagesView.swift
//  VKClient
//
//  Created by Matsulenko on 07.12.2023.
//

import SwiftUI

struct MessagesView: View {
    @State var messages: [Message]
    @State var newMessage: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        let avatar: Image = {
            if messages.first!.profile.avatar != nil {
                return messages.first!.profile.avatar!
            } else {
                return Image("VKClient")
            }
        }()
        
        NavigationStack {
            ZStack {
                HStack {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .frame(width: 13, height: 20)
                        .padding()
                        .onTapGesture {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        .foregroundStyle(.accent)
                    Spacer()
                }
                NavigationLink {
                    ProfileView(profile: messages.first!.profile, isMyProfile: false)
                } label: {
                    HStack {
                        avatar
                            .resizable()
                            .scaledToFill()
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .frame(width: 30, height: 30)
                            .shadow(radius: 5)
                            .padding(.trailing, 8)
                        Text(messages.first!.profile.name + " " + messages.first!.profile.surname)
                            .foregroundStyle(Color.text)
                            .font(.headline)
                    }
                }
            }
            
            ScrollViewReader { proxy in
                ScrollView {
                    ForEach(messages) { message in
                        MessagesRow(message: message)
                            .id(message)
                    }
                }
                .navigationBarTitleDisplayMode(.large)
                .toolbar(.hidden, for: .navigationBar)
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                }
                .onAppear {
                    withAnimation { proxy.scrollTo(messages.last) }
                }
                .onChange(of: messages) {
                    withAnimation { proxy.scrollTo(messages.last) }
                }
                
            }
            .border(edges: [.top, .bottom])
            ZStack {
                TextField("Your message", text: $newMessage, axis: .vertical)
                    .lineLimit(1...5)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 10, trailing: 51))
                HStack {
                    Spacer()
                    Image(systemName: "arrowtriangle.right.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(newMessage == "" ? Color.gray : Color.accentColor)
                        .padding(10)
                        .onTapGesture {
                            submitMessage()
                        }
                }
            }
        }
    }
    
    private func submitMessage() {
        if newMessage != "" {
            let message = Message(id: Int.random(in: 10000...99999), profile: Mocks.shared.profile, text: newMessage, postDate: "Now", isMyMessage: true)
            messages.append(message)
            newMessage = ""
        }
    }
    
}

#Preview {
    MessagesView(messages: Mocks.shared.messages)
}

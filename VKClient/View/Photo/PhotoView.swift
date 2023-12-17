//
//  PhotoView.swift
//  VKClient
//
//  Created by Matsulenko on 30.11.2023.
//

import SwiftUI

struct PhotoView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showingComments = false
    
    @State var photo: Photo
    
    var body: some View {
        
        ZStack {
            photo.image
                .resizable()
                .scaledToFit()
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(.accent)
                        .padding(20)
                        .onTapGesture {
                            dismiss()
                        }
                }
                Spacer()
                HStack {
                    Text(photo.description)
                        .foregroundStyle(.gray)
                        .padding(20)
                    Spacer()
                }
                VStack {
                    HStack {
                        HStack {
                            Image(systemName: photo.liked ? "heart.fill" : "heart")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(photo.liked ? .red : .gray)
                                .padding(.leading, 100)
                                .onTapGesture {
                                    if photo.liked {
                                        photo.liked = false
                                        photo.likes -= 1
                                    } else {
                                        photo.liked = true
                                        photo.likes += 1
                                    }
                                }
                            Text(String(photo.likes))
                                .foregroundStyle(.gray)
                        }
                        Spacer()
                        HStack {
                            Image(systemName: "message.fill")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(.gray)
                            Text(String(photo.comments))
                                .foregroundStyle(.gray)
                                .padding(.trailing, 100)
                        }
                        .onTapGesture {
                            showingComments = true
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showingComments) {
            NavigationStack {
                CommentsView(comments: Mocks.shared.comments)
            }
        }
    }
}

let rawValue = 0
#Preview {
    PhotoView(photo: Mocks.shared.photos[rawValue])
}

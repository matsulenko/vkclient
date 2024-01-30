//
//  PhotoView.swift
//  VKClient
//
//  Created by Matsulenko on 30.11.2023.
//

import SwiftUI
import Zoomable

struct PhotoView: View {
    @State var hasError = false
    @Environment(\.dismiss) var dismiss
    var token: String
    var photoId: ProfilePhotosViewItem?
    var photoIdString: String?
    @State var canComment: Bool = false
    @State private var showingComments = false
    @State var photo: PhotoById?
    @State var isHidden: Bool = false

    var body: some View {
        let photoLongId: String = {
            if photoId != nil {
                if photoId!.webViewToken != nil {
                    return String(photoId!.ownerId) + "_" + String(photoId!.id) + "_" + photoId!.webViewToken!
                } else {
                    return String(photoId!.ownerId) + "_" + String(photoId!.id)
                }
            } else if photoIdString != nil {
                return photoIdString!
            } else {
                hasError = true
                return ""
            }
        }()
        
        if hasError == false {
            ZStack {
                if photo != nil {
                    AsyncImage(url: URL(string: photo!.origPhoto.url)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .zoomable()
                            .onTapGesture {
                                isHidden.toggle()
                            }
                        
                    } placeholder: {
                        ProgressView()
                    }
                    
                    if !isHidden {
                        VStack {
                            Spacer()
                            VStack {
                                HStack {
                                    Text(photo!.text)
                                        .foregroundStyle(.text)
                                        .padding(20)
                                        .lineLimit(0...5)
                                    Spacer()
                                }
                                VStack {
                                    HStack {
                                        HStack {
                                            Image(systemName: photo!.likes.userLikes == 1 ? "heart.fill" : "heart")
                                                .resizable()
                                                .frame(width: 25, height: 25)
                                                .foregroundStyle(photo!.likes.userLikes == 1 ? .red : .gray)
                                                .padding(.leading, 100)
                                                .onTapGesture {
                                                    var isAlreadyLiked = false
                                                    
                                                    if photo!.likes.userLikes == 1 {
                                                        photo!.likes.userLikes = 0
                                                        isAlreadyLiked = true
                                                    } else if photo!.likes.userLikes == 0 {
                                                        photo!.likes.userLikes = 1
                                                    }
                                                    
                                                    Responses.shared.like(isAlreadyLiked: isAlreadyLiked, token: token, type: .photo, itemId: photo!.id, userId: photo!.ownerId, accessKey: nil) { result in
                                                        switch result {
                                                        case .success(let likes):
                                                            photo!.likes.count = likes
                                                        case .failure(let error):
                                                            print("Photo with id \(photo!.id) is NOT \(isAlreadyLiked ? "dis": "")liked because of an Error: \(error.localizedDescription)")
                                                            hasError = true
                                                        }
                                                    }
                                                }
                                            Text(String(photo!.likes.count))
                                                .foregroundStyle(.text)
                                        }
                                        Spacer()
                                        HStack {
                                            Image(systemName: "message.fill")
                                                .resizable()
                                                .frame(width: 25, height: 25)
                                                .foregroundStyle(.gray)
                                            Text(String(photo!.comments.count))
                                                .foregroundStyle(.text)
                                                .padding(.trailing, 100)
                                        }
                                        .onTapGesture {
                                            showingComments = true
                                        }
                                    }
                                }
                            }
                            .background(LinearGradient(gradient: Gradient(colors: [Color.clear, Color("BgColor")]), startPoint: .top, endPoint: .bottom))
                        }
                    }
                }
                if !isHidden {
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
                    }
                }
            }
            .sheet(isPresented: $showingComments) {
                NavigationStack {
                    let canComment: Bool = {
                        if photo!.canComment == 1 {
                            return true
                        } else {
                            return false
                        }
                    }()
                    
                    CommentsView(token: token, commentedType: .photo, objectId: photo!.id, canComment: canComment, userId: photo!.ownerId)
                }
            }
            .onAppear {
                Responses.shared.getPhotosById(token: token, photos: photoLongId) { result in
                    switch result {
                    case .success(let photos): 
                        self.photo = photos[0]
                    case .failure(let error):
                        print("Something went wrong: \(error.localizedDescription)")
                        hasError = true
                    }
                }
            }
        } else {
            ZStack {
                Text("Something went wrong")
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
                }
            }
        }
    }
}

//let rawValue = 0
#Preview {
    PhotoView(token: InfoPlist.tokenForPreviews, photoId: ProfilePhotosViewItem(id: 456239440, ownerId: 220458, webViewToken: "3fbd8a20bd6a19dd02"))
}

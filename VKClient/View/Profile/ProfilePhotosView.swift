//
//  ProfilePhotosView.swift
//  VKClient
//
//  Created by Matsulenko on 05.12.2023.
//

import SwiftUI

struct ProfilePhotosView: View {
    
    var token: String
    var userId: Int?
    let limit = 5
    let photoSize: PhotoSizes = .small
    
    @State var allPhotos: AllPhotos?
    @State var selectedPhoto: ProfilePhotosViewItem?
    
    var body: some View {
        VStack {
            if allPhotos != nil {
                if allPhotos!.count > 0 {
                    NavigationLink {
                        PhotoGalleryView(token: token, userId: userId)
                    } label: {
                        VStack {
                            Divider()
                            HStack {
                                Text("Photos")
                                    .foregroundStyle(Color("Text"))
                                    .font(.headline)
                                Text(String(allPhotos!.count))
                                    .foregroundStyle(.gray)
                                    .font(.headline)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.primary)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    ScrollView(.horizontal) {
                        HStack(spacing: 5) {
                            ForEach(allPhotos!.items.indices, id: \.self) { index in
                                let url: String = {
                                    if let item = allPhotos!.items[index].sizes.first(where: { $0.type == photoSize.rawValue }) {
                                        return item.url
                                    } else {
                                        return allPhotos!.items[index].sizes.last?.url ?? ""
                                    }
                                }()
                                
                                Color.clear
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 130, height: 87)
                                    .overlay(
                                        AsyncImage(url: URL(string: url))
                                            .scaledToFill()
                                    ).clipped()
                                    .onTapGesture {
                                        let photoId = allPhotos!.items[index].id
                                        let ownerId = allPhotos!.items[index].ownerId
                                        let webViewToken = allPhotos!.items[index].webViewToken
                                        selectedPhoto = ProfilePhotosViewItem(id: photoId, ownerId: ownerId, webViewToken: webViewToken)
                                    }
                                    .clipShape(.rect(cornerRadius: 15))
                                    .padding(.bottom, 10)
                            }
                            if allPhotos!.count > limit {
                                NavigationLink {
                                    PhotoGalleryView(token: token, userId: userId)
                                } label: {
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(
                                            LinearGradient(gradient: Gradient(colors: [Color.accentColor, Color.additionalColor1, Color.additionalColor2]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                        .frame(width: 130, height: 87)
                                        .overlay(
                                            Text("All photos")
                                                .font(.headline)
                                                .foregroundStyle(Color.white)
                                        )
                                        .padding(.bottom, 10)
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        .fullScreenCover(item: $selectedPhoto) { photo in
                            PhotoView(token: token, photoId: photo)
                        }
                    }
                }
            }
        }
        .onAppear {
            Responses.shared.getAllPhotos(token: token, userId: userId, offset: 0, count: limit) { result in
                switch result {
                case .success(let allPhotos): self.allPhotos = allPhotos
                case .failure(let error): print("Something went wrong: \(error.localizedDescription)")
                }
            }
        }
    }
}

struct ProfilePhotosViewItem: Identifiable {
    var id: Int
    var ownerId: Int
    var webViewToken: String?
}

#Preview {
    ProfilePhotosView(token: InfoPlist.tokenForPreviews)
}


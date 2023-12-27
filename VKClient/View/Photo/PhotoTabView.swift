//
//  PhotoTabView.swift
//  VKClient
//
//  Created by Matsulenko on 03.12.2023.
//

import SwiftUI

struct PhotoTabView: View {
    
    @State var hasError = false
    var token: String
    var userId: Int?
    var albumId: Int?
    let limit = 21
    let photoSize: PhotoSizes = .large
    @State var photosLoaded: Int = 0
    
    @State var photos: AllPhotos?
    @State var selectedPhoto: ProfilePhotosViewItem?
    
    let columns = [
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible(), spacing: 1)
    ]
    
    var body: some View {
        
        if hasError {
            Text("Something went wrong")
        } else {
            ScrollView {
                if photos != nil {
                    if photos!.count > 0 {
                        LazyVGrid(columns: columns, spacing: 1) {
                            ForEach(photos!.items.indices, id: \.self) { index in
                                let url: String = {
                                    if let item = photos!.items[index].sizes.first(where: { $0.type == photoSize.rawValue }) {
                                        return item.url
                                    } else {
                                        return photos!.items[index].sizes.last?.url ?? ""
                                    }
                                }()
                                
                                Color.clear
                                    .aspectRatio(contentMode: .fill)
                                    .overlay(
                                        AsyncImage(url: URL(string: url)) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                    ).clipped()
                                    .onTapGesture {
                                        let photoId = photos!.items[index].id
                                        let ownerId = photos!.items[index].ownerId
                                        let webViewToken = photos!.items[index].webViewToken
                                        selectedPhoto = ProfilePhotosViewItem(id: photoId, ownerId: ownerId, webViewToken: webViewToken)
                                    }
                            }
                        }
                        if photosLoaded < photos!.count {
                            Button(
                                action: {
                                    loadMorePhotos()
                                }, label: {
                                    Text("Load more")
                                })
                            .buttonStyle(DefaultButton())
                            .padding(.horizontal, 26)
                        }
                    } else {
                        Text("There are no photos")
                    }
                }
            }
            .onAppear {
                loadAllPhotos()
            }
            .fullScreenCover(item: $selectedPhoto) { photo in
                PhotoView(token: token, photoId: photo)
            }
        }
    }
    
    private func loadAllPhotos() {
        if albumId != nil {
            Responses.shared.getPhotos(token: token, userId: userId, albumId: albumId!, offset: 0, count: limit) { result in
                switch result {
                case .success(let allPhotos):
                    self.photos = allPhotos
                    photosLoaded += limit
                case .failure(let error):
                    print("Something went wrong: \(error.localizedDescription)")
                    hasError = true
                }
            }
        } else {
            Responses.shared.getAllPhotos(token: token, userId: userId, offset: 0, count: limit) { result in
                switch result {
                case .success(let allPhotos):
                    self.photos = allPhotos
                    photosLoaded += limit
                case .failure(let error):
                    print("Something went wrong: \(error.localizedDescription)")
                    hasError = true
                }
            }
        }
    }
    
    private func loadMorePhotos() {
        if albumId != nil {
            Responses.shared.getPhotos(token: token, userId: userId, albumId: albumId!, offset: photosLoaded, count: limit) { result in
                switch result {
                case .success(let newPhotos):
                    self.photos!.items.append(contentsOf: newPhotos.items)
                    print(self.photos!.items.count)
                    photosLoaded += limit
                case .failure(let error):
                    print("Something went wrong: \(error.localizedDescription)")
                    hasError = true
                }
            }
        } else {
            Responses.shared.getAllPhotos(token: token, userId: userId, offset: photosLoaded, count: limit) { result in
                switch result {
                case .success(let newPhotos):
                    self.photos!.items.append(contentsOf: newPhotos.items)
                    print(self.photos!.items.count)
                    photosLoaded += limit
                case .failure(let error):
                    print("Something went wrong: \(error.localizedDescription)")
                    hasError = true
                }
            }
        }
    }
}

#Preview {
    PhotoTabView(token: InfoPlist.tokenForPreviews)
}

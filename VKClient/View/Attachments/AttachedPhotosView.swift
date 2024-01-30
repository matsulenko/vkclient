//
//  AttachedPhotosView.swift
//  VKClient
//
//  Created by Matsulenko on 07.12.2023.
//

import SwiftUI

struct AttachedPhotosView: View {
    
    var token: String
    
    let columns = [
        GridItem(.fixed(50), spacing: 1, alignment: .leading),
        GridItem(.fixed(50), spacing: 1, alignment: .leading),
        GridItem(.fixed(50), spacing: 1, alignment: .leading),
        GridItem(.fixed(50), spacing: 1, alignment: .leading)
    ]
    
    @State var photoAttachments: [PhotoAttachment]
    
    @State var selectedPhoto: ProfilePhotosViewItem?
    
    var body: some View {
        VStack {
            HStack {
                let url: String = {
                    if let item = photoAttachments.first!.sizes.first(where: { $0.type == PhotoSizes.medium.rawValue }) {
                        return item.url
                    } else {
                        return photoAttachments.first!.sizes.last?.url ?? ""
                    }
                }()
                
                AsyncImage(url: URL(string: url)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 350)
                        .onTapGesture {
                            let photoId = photoAttachments.first!.id
                            let ownerId = photoAttachments.first!.ownerId
                            let webViewToken = photoAttachments.first!.accessKey
                            selectedPhoto = ProfilePhotosViewItem(id: photoId, ownerId: ownerId, webViewToken: webViewToken)
                        }
                } placeholder: {
                    ProgressView()
                }
                Spacer()
            }
            
            if photoAttachments.count > 1 {
                HStack {
                    LazyVGrid(columns: columns) {
                        ForEach(photoAttachments.suffix(photoAttachments.count - 1).indices, id: \.self) { index in
                            let imageUrl: String = {
                                if let url = photoAttachments[index].sizes.first(where: { $0.type == PhotoSizes.extraSmall.rawValue })?.url {
                                    return url
                                } else {
                                    return photoAttachments[index].sizes.last?.url ?? ""
                                    }
                            }()
                            
                            Color.clear
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                                .overlay(
                                    AsyncImage(url: URL(string: imageUrl)) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                ).clipped()
                                .onTapGesture {
                                    let photoId = photoAttachments[index].id
                                    let ownerId = photoAttachments[index].ownerId
                                    let webViewToken = photoAttachments[index].accessKey
                                    selectedPhoto = ProfilePhotosViewItem(id: photoId, ownerId: ownerId, webViewToken: webViewToken)
                                }
                                .clipShape(.rect(cornerRadius: 15))
                        }
                    }
                    .frame(minWidth: 50, maxWidth: 203)
                    Spacer()
                }
            }
        }
        .fullScreenCover(item: $selectedPhoto) { photo in
            PhotoView(token: token, photoId: photo)
        }
    }
}

#Preview {
    AttachedPhotosView(token: InfoPlist.tokenForPreviews, photoAttachments: [PhotoAttachment(id: 456239440, ownerId: 220458, accessKey: "ed0e15f16d31a612c2", sizes: [AllPhotosItemSize(type: "q", url: "https://sun9-36.userapi.com/impf/c846521/v846521403/b4f51/VNYR1Tyl7-s.jpg?size=320x426&quality=96&sign=ab86c02dd36fb1c4cb9d68c9d354ed7b&c_uniq_tag=3XSKL916QMQXRXKYdrzFIepTWdTIXe9gGScPDGIuNZk&type=album"), AllPhotosItemSize(type: "s", url: "https://sun9-36.userapi.com/impf/c846521/v846521403/b4f51/VNYR1Tyl7-s.jpg?size=56x75&quality=96&sign=d995ecadbb8cb4923d1914d76c037dd2&c_uniq_tag=Ue6QpSh-63hg0hC2m2EneFRoaqmn3LB8YdFgfvwughE&type=album")]), PhotoAttachment(id: 456239440, ownerId: 220458, accessKey: "ed0e15f16d31a612c2", sizes: [AllPhotosItemSize(type: "q", url: "https://sun9-36.userapi.com/impf/c846521/v846521403/b4f51/VNYR1Tyl7-s.jpg?size=320x426&quality=96&sign=ab86c02dd36fb1c4cb9d68c9d354ed7b&c_uniq_tag=3XSKL916QMQXRXKYdrzFIepTWdTIXe9gGScPDGIuNZk&type=album"), AllPhotosItemSize(type: "s", url: "https://sun9-36.userapi.com/impf/c846521/v846521403/b4f51/VNYR1Tyl7-s.jpg?size=56x75&quality=96&sign=d995ecadbb8cb4923d1914d76c037dd2&c_uniq_tag=Ue6QpSh-63hg0hC2m2EneFRoaqmn3LB8YdFgfvwughE&type=album")]), PhotoAttachment(id: 456239440, ownerId: 220458, accessKey: "ed0e15f16d31a612c2", sizes: [AllPhotosItemSize(type: "q", url: "https://sun9-36.userapi.com/impf/c846521/v846521403/b4f51/VNYR1Tyl7-s.jpg?size=320x426&quality=96&sign=ab86c02dd36fb1c4cb9d68c9d354ed7b&c_uniq_tag=3XSKL916QMQXRXKYdrzFIepTWdTIXe9gGScPDGIuNZk&type=album"), AllPhotosItemSize(type: "s", url: "https://sun9-36.userapi.com/impf/c846521/v846521403/b4f51/VNYR1Tyl7-s.jpg?size=56x75&quality=96&sign=d995ecadbb8cb4923d1914d76c037dd2&c_uniq_tag=Ue6QpSh-63hg0hC2m2EneFRoaqmn3LB8YdFgfvwughE&type=album")]), PhotoAttachment(id: 456239440, ownerId: 220458, accessKey: "ed0e15f16d31a612c2", sizes: [AllPhotosItemSize(type: "q", url: "https://sun9-36.userapi.com/impf/c846521/v846521403/b4f51/VNYR1Tyl7-s.jpg?size=320x426&quality=96&sign=ab86c02dd36fb1c4cb9d68c9d354ed7b&c_uniq_tag=3XSKL916QMQXRXKYdrzFIepTWdTIXe9gGScPDGIuNZk&type=album"), AllPhotosItemSize(type: "s", url: "https://sun9-36.userapi.com/impf/c846521/v846521403/b4f51/VNYR1Tyl7-s.jpg?size=56x75&quality=96&sign=d995ecadbb8cb4923d1914d76c037dd2&c_uniq_tag=Ue6QpSh-63hg0hC2m2EneFRoaqmn3LB8YdFgfvwughE&type=album")]), PhotoAttachment(id: 456239440, ownerId: 220458, accessKey: "ed0e15f16d31a612c2", sizes: [AllPhotosItemSize(type: "q", url: "https://sun9-36.userapi.com/impf/c846521/v846521403/b4f51/VNYR1Tyl7-s.jpg?size=320x426&quality=96&sign=ab86c02dd36fb1c4cb9d68c9d354ed7b&c_uniq_tag=3XSKL916QMQXRXKYdrzFIepTWdTIXe9gGScPDGIuNZk&type=album"), AllPhotosItemSize(type: "s", url: "https://sun9-36.userapi.com/impf/c846521/v846521403/b4f51/VNYR1Tyl7-s.jpg?size=56x75&quality=96&sign=d995ecadbb8cb4923d1914d76c037dd2&c_uniq_tag=Ue6QpSh-63hg0hC2m2EneFRoaqmn3LB8YdFgfvwughE&type=album")]), PhotoAttachment(id: 456239440, ownerId: 220458, accessKey: "ed0e15f16d31a612c2", sizes: [AllPhotosItemSize(type: "q", url: "https://sun9-36.userapi.com/impf/c846521/v846521403/b4f51/VNYR1Tyl7-s.jpg?size=320x426&quality=96&sign=ab86c02dd36fb1c4cb9d68c9d354ed7b&c_uniq_tag=3XSKL916QMQXRXKYdrzFIepTWdTIXe9gGScPDGIuNZk&type=album"), AllPhotosItemSize(type: "s", url: "https://sun9-36.userapi.com/impf/c846521/v846521403/b4f51/VNYR1Tyl7-s.jpg?size=56x75&quality=96&sign=d995ecadbb8cb4923d1914d76c037dd2&c_uniq_tag=Ue6QpSh-63hg0hC2m2EneFRoaqmn3LB8YdFgfvwughE&type=album")])])
}

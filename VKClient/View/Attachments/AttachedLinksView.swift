//
//  AttachedLinksView.swift
//  VKClient
//
//  Created by Matsulenko on 24.12.2023.
//

import SwiftUI

struct AttachedLinksView: View {
    
    @State var token: String
    @State var links: [LinkAttachment]
    
    var body: some View {
        VStack {
            ForEach(links.indices, id: \.self) { index in
                
                let imageUrl: String? = {
                    if links[index].photo?.sizes?.count ?? 0 > 0 {
                        return links[index].photo!.sizes!.first!.url
                    } else {
                        return nil
                    }
                }()
                
                Link(destination: URL(string: links[index].url)!) {
                    VStack {
                        if imageUrl != nil {
                            HStack {
                                AsyncImage(url: URL(string: imageUrl!)) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                        if let caption = links[index].caption {
                            HStack {
                                Text(caption)
                                    .font(.subheadline)
                                    .frame(alignment: .leading)
                                    .foregroundStyle(Color.accentColor)
                                    .lineLimit(nil)
                                    .multilineTextAlignment(.leading)
                                    .padding(.horizontal, 16)
                                Spacer()
                            }
                        }
                        if let title = links[index].title {
                            HStack {
                                Text(title)
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .frame(alignment: .leading)
                                    .foregroundStyle(Color.text)
                                    .lineLimit(nil)
                                    .multilineTextAlignment(.leading)
                                    .padding(.horizontal, 16)
                                Spacer()
                            }
                        }
                        if let description = links[index].description {
                            HStack {
                                Text(description)
                                    .font(.caption)
                                    .frame(alignment: .leading)
                                    .foregroundStyle(Color.text.opacity(0.8))
                                    .lineLimit(0...30)
                                    .multilineTextAlignment(.leading)
                                    .padding(.horizontal, 16)
                                Spacer()
                            }
                        }
                        Button(action: {
                            openUrl(urlString: links[index].url)
                        }, label: {
                            Text("Open link")
                        })
                        .buttonStyle(
                            DefaultButton()
                        )
                        .padding(16)
                        .shadow(radius: 5)
                        
                        
                    }
                    .background(Color.gray.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .onTapGesture {
                        openUrl(urlString: links[index].url)
                    }
                    Spacer()
                }
            }
        }
    }
    
    private func openUrl(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }
}

#Preview {
    AttachedLinksView(
        token: InfoPlist.tokenForPreviews,
        links: [LinkAttachment(url: "https://youtu.be", caption: "youtu.be", description: "Tets", photo: LinkAttachmentPhoto(sizes: [AllPhotosItemSize(type: "l", url: "https://sun9-54.userapi.com/impg/hH42i4-RsQ1b_CNyiOGJBmNcB404Pig2k1f4_Q/_p0EdXoln-4.jpg?size=537x240&quality=96&sign=dc41d067fcfc5a9b790ad8ce3219fa8a&c_uniq_tag=eneBGj4VeY7j124jkPsymS1Np9vf4In98Q8_ZN6bh9A&type=share")], text: ""), title: "Test")]
        )
}

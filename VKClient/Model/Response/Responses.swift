//
//  Responses.swift
//  VKClient
//
//  Created by Matsulenko on 11.12.2023.
//

import Foundation
import Alamofire
import KeychainSwift
import SwiftUI

enum FetchDataError: Error {
    case custom(reason: String)
}

enum ListOfProfilesType: String {
    case friends = "Friends"
    case followers = "Followers"
    case subscriptions = "Subscriptions"
}

enum PhotoSizes: String {
    case small = "o"
    case medium = "q"
    case large = "r"
    case extraSmall = "s"
    case extraLarge = "x"
}

enum ObjectType: String {
    case post = "post"
    case comment = "comment"
    case photo = "photo"
    case audio = "audio"
    case video = "video"
    case note = "note"
    case market = "market"
    case photoComment = "photo_comment"
    case videoComment = "video_comment"
    case topicComment = "topic_comment"
    case marketComment = "market_comment"
}

public final class Responses {
    
    @AppStorage("isHidden") var isHidden = true
    
    static let shared: Responses = {
        let instance = Responses()
        
        return instance
    }()
    
    func setOnlineStatus(token: String) {
        if isHidden == false {
            let url = "https://api.vk.com/method/account.setOnline"
            
            let params: Parameters = [
                "access_token": token,
                "v": "5.199"
            ]
            
            AF.request(url, method: .post, parameters: params).response { result in
                if let data = result.data {
                    
                    do {
                        let _ = try JSONDecoder().decode(SetOnlineResponse.self, from: data).response
                    } catch {
                        print("Impossible to set Online status")
                    }
                }
            }
        }
    }
    
    func getFriends(token: String, type: ListOfProfilesType, userId: Int?, count: Int, offset: Int?, completion: @escaping (Result<[Friend], FetchDataError>) -> Void) {
        var url = ""
        
        switch type {
        case .friends:
            url = "https://api.vk.com/method/friends.get"
        case .followers:
            url = "https://api.vk.com/method/users.getFollowers"
        case .subscriptions:
            url = "https://api.vk.com/method/users.getSubscriptions"
        }
        
        var params: Parameters = [
            "access_token": token,
            "order": "hints",
            "count": count,
            "fields": "photo_50,city",
            "v": "5.199"
        ]
        
        if userId != nil {
            params["user_id"] = userId
        }
        
        if offset != nil {
            params["offset"] = offset
        }
        
        AF.request(url, method: .get, parameters: params).response { result in
            if let data = result.data {
                
                do {
                    let responseResult = try JSONDecoder().decode(FriendsResponse.self, from: data).response.items
                    completion(.success(responseResult))
                } catch {
                    completion(.failure(.custom(reason: error.localizedDescription)))
                }
            }
        }
    }
    
    func getFriendsCount(token: String, type: ListOfProfilesType, userId: Int?, completion: @escaping (Result<Int, FetchDataError>) -> Void) {
        var url = ""
        
        switch type {
        case .friends:
            url = "https://api.vk.com/method/friends.get"
        case .followers:
            url = "https://api.vk.com/method/users.getFollowers"
        case .subscriptions:
            url = "https://api.vk.com/method/users.getSubscriptions"
        }
        
        var params: Parameters = [
            "access_token": token,
            "v": "5.199"
        ]
        
        if userId != nil {
            params["user_id"] = userId
        }
        
        AF.request(url, method: .get, parameters: params).response { result in
            if let data = result.data {
                
                do {
                    let responseResult = try JSONDecoder().decode(CountResponse.self, from: data).response.count
                    completion(.success(responseResult))
                } catch {
                    completion(.failure(.custom(reason: error.localizedDescription)))
                }
            }
        }
    }
    
    func getSubscriptions(token: String, userId: Int?, count: Int, offset: Int?, completion: @escaping (Result<[SubscriptionGroup], FetchDataError>) -> Void) {
        let url = "https://api.vk.com/method/users.getSubscriptions"
        
        var params: Parameters = [
            "access_token": token,
            "fields": "photo_50",
            "count": count,
            "v": "5.199",
            "extended": 1
        ]
        
        if userId != nil {
            params["user_id"] = userId
        }
        
        if offset != nil {
            params["offset"] = offset
        }
        
        AF.request(url, method: .get, parameters: params).response { result in
            if let data = result.data {
                
                do {
                    let subscriptions = try JSONDecoder().decode(SubscriptionsResponse.self, from: data).response.items
                    completion(.success(subscriptions))
                } catch {
                    completion(.failure(.custom(reason: error.localizedDescription)))
                }
            }
        }
    }
    
    func getSubscriptionsCount(token: String, userId: Int?, completion: @escaping (Result<Int, FetchDataError>) -> Void) {
        let url = "https://api.vk.com/method/users.getSubscriptions"
        
        var params: Parameters = [
            "access_token": token,
            "v": "5.199",
            "extended": 1
        ]
        
        if userId != nil {
            params["user_id"] = userId
        }
        
        AF.request(url, method: .get, parameters: params).response { result in
            if let data = result.data {
                
                do {
                    let subscriptions = try JSONDecoder().decode(CountResponse.self, from: data).response.count
                    completion(.success(subscriptions))
                } catch {
                    completion(.failure(.custom(reason: error.localizedDescription)))
                }
            }
        }
    }
    
    func getGroupsOfUser(token: String, count: Int, offset: Int?, completion: @escaping (Result<GroupsList, FetchDataError>) -> Void) {
        let url = "https://api.vk.com/method/groups.get"
        
        var params: Parameters = [
            "access_token": token,
            "fields": "photo_50",
            "count": count,
            "v": "5.199",
            "extended": 1
        ]
        
        if offset != nil {
            params["offset"] = offset
        }
        
        AF.request(url, method: .get, parameters: params).response { result in
            if let data = result.data {
                
                do {
                    let subscriptions = try JSONDecoder().decode(GroupsListResponse.self, from: data).response
                    completion(.success(subscriptions))
                } catch {
                    completion(.failure(.custom(reason: error.localizedDescription)))
                }
            }
        }
    }
    
    func getAllPhotos(token: String, userId: Int?, offset: Int, count: Int, completion: @escaping (Result<AllPhotos, FetchDataError>) -> Void) {
        let url = "https://api.vk.com/method/photos.getAll"
        
        var params: Parameters = [
            "access_token": token,
            "offset": offset,
            "count": count,
            "photo_sizes": 1,
            "no_service_albums": 1,
            "v": "5.199"
        ]
        
        if userId != nil {
            params["owner_id"] = userId
        }
        
        AF.request(url, method: .get, parameters: params).response { result in
            if let data = result.data {
                
                do {
                    let allPhotos = try JSONDecoder().decode(AllPhotosResponse.self, from: data).response
                    completion(.success(allPhotos))
                } catch {
                    completion(.failure(.custom(reason: error.localizedDescription)))
                }
            }
        }
    }
    
    func getPhotosById(token: String, photos: String, completion: @escaping (Result<[PhotoById], FetchDataError>) -> Void) {
        let url = "https://api.vk.com/method/photos.getById"
        
        let params: Parameters = [
            "access_token": token,
            "photos": photos,
            "extended": 1,
            "v": "5.199"
        ]
        
        AF.request(url, method: .get, parameters: params).response { result in
            if let data = result.data {
                
                do {
                    let photoById = try JSONDecoder().decode(PhotoByIdResponse.self, from: data).response
                    completion(.success(photoById))
                } catch {
                    completion(.failure(.custom(reason: error.localizedDescription)))
                }
            }
        }
    }
    
    func getComments(token: String, commentedType: ObjectType, objectId: Int, userId: Int, offset: Int?, count: Int?, startCommentId: Int?, completion: @escaping (Result<Comments, FetchDataError>) -> Void) {
        let url: String = {
            switch commentedType {
            case .post:
                "https://api.vk.com/method/wall.getComments"
            case .photo:
                "https://api.vk.com/method/photos.getComments"
            case .video:
                "https://api.vk.com/method/video.getComments"
            default:
                "https://api.vk.com/method/photos.getComments"
            }
        }()
        
        var params: Parameters = [
            "access_token": token,
            "need_likes": 1,
            "sort": "desc",
            "fields": "photo_50",
            "owner_id": userId,
            "extended": 1,
            "v": "5.199"
        ]
        
        switch commentedType {
        case .post:
            params["post_id"] = objectId
        case .photo:
            params["photo_id"] = objectId
        case .video:
            params["video_id"] = objectId
        default:
            params["photo_id"] = objectId
        }
        
        if offset != nil {
            params["offset"] = offset
        }
        
        if count != nil {
            params["count"] = count
        }
        
        if startCommentId != nil {
            params["start_comment_id"] = startCommentId
        }
        
        AF.request(url, method: .get, parameters: params).response { result in
            if let data = result.data {
                
                do {
                    let comments = try JSONDecoder().decode(CommentsResponse.self, from: data).response
                    completion(.success(comments))
                    print("Success")
                } catch {
                    completion(.failure(.custom(reason: error.localizedDescription)))
                }
            }
        }
    }
    
    func like(isAlreadyLiked: Bool, token: String, type: ObjectType, itemId: Int, userId: Int?, accessKey: String?, completion: @escaping (Result<Int, FetchDataError>) -> Void) {
        let url: String = {
            if isAlreadyLiked {
                return "https://api.vk.com/method/likes.delete"
            } else {
                return "https://api.vk.com/method/likes.add"
            }
        }()
        
        var params: Parameters = [
            "access_token": token,
            "type": type.rawValue,
            "item_id": itemId,
            "v": "5.199"
        ]
        
        if userId != nil {
            params["owner_id"] = userId
        }
        
        if accessKey != nil {
            params["access_key"] = accessKey
        }
        
        AF.request(url, method: .post, parameters: params).response { result in
            if let data = result.data {
                do {
                    let likes = try JSONDecoder().decode(LikesResponse.self, from: data).response.likes
                    completion(.success(likes))
                    print("\(type.rawValue) with id \(itemId) is \(isAlreadyLiked ? "dis": "")liked")
                } catch {
                    completion(.failure(.custom(reason: "\(type.rawValue) with id \(itemId) is NOT \(isAlreadyLiked ? "dis": "")liked because of an Error")))
                }
            }
        }
    }
    
    func createComment(token: String, commentedType: ObjectType, userId: Int?, objectId: Int, message: String, replyToComment: Int?, guid: String, completion: @escaping (Result<Bool, FetchDataError>) -> Void) {
        let url: String = {
            switch commentedType {
            case .post:
                "https://api.vk.com/method/photos.createComment"
            case .photo:
                "https://api.vk.com/method/photos.createComment"
            case .video:
                "https://api.vk.com/method/video.createComment"
            default:
                "https://api.vk.com/method/photos.createComment"
            }
        }()
        
        var params: Parameters = [
            "access_token": token,
            "message": message,
            "guid": guid,
            "v": "5.199"
        ]
        
        switch commentedType {
        case .post:
            params["photo_id"] = objectId
        case .photo:
            params["photo_id"] = objectId
        case .video:
            params["video_id"] = objectId
        default:
            params["photo_id"] = objectId
        }
        
        if userId != nil {
            params["owner_id"] = userId
        }
        
        if replyToComment != nil {
            params["reply_to_comment"] = replyToComment
        }
        
        AF.request(url, method: .post, parameters: params).response { result in
            if let data = result.data {
                
                do {
                    let newCommentId = try JSONDecoder().decode(CreateCommentResponse.self, from: data).response
                    if newCommentId > 0 {
                        completion(.success(true))
                    } else {
                        completion(.success(false))
                    }
                } catch {
                    completion(.failure(.custom(reason: error.localizedDescription)))
                }
            }
        }
    }
    
    func deleteComment(token: String, commentedType: ObjectType, userId: Int?, commentId: Int, completion: @escaping (Result<Bool, FetchDataError>) -> Void) {
        let url: String = {
            switch commentedType {
            case .post:
                "https://api.vk.com/method/wall.deleteComment"
            case .photo:
                "https://api.vk.com/method/photos.deleteComment"
            case .video:
                "https://api.vk.com/method/video.deleteComment"
            default:
                "https://api.vk.com/method/photos.deleteComment"
            }
        }()
                
        var params: Parameters = [
            "access_token": token,
            "comment_id": commentId,
            "v": "5.199"
        ]
        
        if userId != nil {
            params["owner_id"] = userId
        }
        
        AF.request(url, method: .post, parameters: params).response { result in
            if let data = result.data {
                
                do {
                    let deleteCommentResult = try JSONDecoder().decode(DeleteCommentResponse.self, from: data).response
                    if deleteCommentResult == 1 {
                        completion(.success(true))
                    } else {
                        completion(.success(false))
                    }
                } catch {
                    completion(.failure(.custom(reason: error.localizedDescription)))
                }
            }
        }
    }
    
    func getAlbums(token: String, userId: Int?, needSystem: Bool, completion: @escaping (Result<Albums, FetchDataError>) -> Void) {
        let url = "https://api.vk.com/method/photos.getAlbums"
        
        var params: Parameters = [
            "access_token": token,
            "need_system": needSystem ? 1 : 0,
            "need_covers": 1,
            "photo_sizes": 1,
            "v": "5.199"
        ]
        
        if userId != nil {
            params["owner_id"] = userId
        }
        
        AF.request(url, method: .get, parameters: params).response { result in
            if let data = result.data {
                
                do {
                    let albums = try JSONDecoder().decode(AlbumsResponse.self, from: data).response
                    completion(.success(albums))
                } catch {
                    completion(.failure(.custom(reason: error.localizedDescription)))
                }
            }
        }
    }
    
    func getPhotos(token: String, userId: Int?, albumId: Int, offset: Int, count: Int, completion: @escaping (Result<AllPhotos, FetchDataError>) -> Void) {
        let url = "https://api.vk.com/method/photos.get"
        
        var params: Parameters = [
            "access_token": token,
            "album_id": albumId,
            "offset": offset,
            "count": count,
            "photo_sizes": 1,
            "rev": 1,
            "v": "5.199"
        ]
        
        if userId != nil {
            params["owner_id"] = userId
        }
        
        AF.request(url, method: .get, parameters: params).response { result in
            if let data = result.data {
                
                do {
                    let allPhotos = try JSONDecoder().decode(AllPhotosResponse.self, from: data).response
                    completion(.success(allPhotos))
                } catch {
                    completion(.failure(.custom(reason: error.localizedDescription)))
                }
            }
        }
    }
    
    func getVideo(token: String, userId: Int?, video: Int?, albumId: Int?, offset: Int?, count: Int, completion: @escaping (Result<Videos, FetchDataError>) -> Void) {
        let url = "https://api.vk.com/method/video.get"
        
        var params: Parameters = [
            "access_token": token,
            "count": count,
            "extended": 1,
            "fields": "photo_50",
            "v": "5.199"
        ]
        
        if userId != nil {
            params["owner_id"] = userId
            
            if video != nil {
                let videoId = String(userId!) + "_" + String(video!)
                params["videos"] = videoId
            }
        }
        
        if albumId != nil {
            params["album_id"] = albumId
        }
        
        if offset != nil {
            params["offset"] = offset
        }
        
        AF.request(url, method: .get, parameters: params).response { result in
            if let data = result.data {
                
                do {
                    let videos = try JSONDecoder().decode(VideosResponse.self, from: data).response
                    completion(.success(videos))
                } catch {
                    completion(.failure(.custom(reason: error.localizedDescription)))
                }
            }
        }
    }
    
    func getVideoAlbums(token: String, userId: Int?, offset: Int?, count: Int, completion: @escaping (Result<VideoAlbums, FetchDataError>) -> Void) {
        let url = "https://api.vk.com/method/video.getAlbums"
        
        var params: Parameters = [
            "access_token": token,
            "count": count,
            "extended": 1,
            "v": "5.199"
        ]
        
        if userId != nil {
            params["owner_id"] = userId
        }
        
        if offset != nil {
            params["offset"] = offset
        }
        
        AF.request(url, method: .get, parameters: params).response { result in
            if let data = result.data {
                
                do {
                    let videoAlbums = try JSONDecoder().decode(VideoAlbumsResponse.self, from: data).response
                    completion(.success(videoAlbums))
                } catch {
                    completion(.failure(.custom(reason: error.localizedDescription)))
                }
            }
        }
    }
    
    func addOrDeleteVideo(token: String, videoId: Int, userId: Int, isAddedBefore: Bool, completion: @escaping (Result<Bool, FetchDataError>) -> Void) {
        let url: String = {
            if isAddedBefore {
                "https://api.vk.com/method/video.delete"
            } else {
                "https://api.vk.com/method/video.add"
            }
        }()
        
        let params: Parameters = [
            "access_token": token,
            "video_id": videoId,
            "owner_id": userId,
            "v": "5.199"
        ]
        
        AF.request(url, method: .post, parameters: params).response { result in
            if let data = result.data {
                
                do {
                    let addOrDeleteResponse = try JSONDecoder().decode(AddOrDeleteResponse.self, from: data).response
                    if addOrDeleteResponse == 1 {
                        completion(.success(true))
                    } else {
                        completion(.success(false))
                    }
                } catch {
                    completion(.failure(.custom(reason: error.localizedDescription)))
                }
            }
        }
    }
    
    func getMyId(token: String, completion: @escaping (Result<Int, FetchDataError>) -> Void) {
        let url = "https://api.vk.com/method/users.get"
        
        let params: Parameters = [
            "access_token": token,
            "v": "5.199"
        ]
        
        AF.request(url, method: .get, parameters: params).response { result in
            if let data = result.data {
                
                do {
                    if let myData = try JSONDecoder().decode(UsersResponse.self, from: data).response.first {
                        completion(.success(myData.id))
                    } else {
                        completion(.failure(.custom(reason: "No user data fetched")))
                    }
                } catch {
                    completion(.failure(.custom(reason: error.localizedDescription)))
                }
            }
        }
    }
    
    func getUserData(token: String, userId: Int?, completion: @escaping (Result<User, FetchDataError>) -> Void) {
        let url = "https://api.vk.com/method/users.get"
        
        var params: Parameters = [
            "access_token": token,
            "fields": "career, city, country, has_photo, occupation, photo_100, photo_id, status",
            "v": "5.199"
        ]
        
        if userId != nil {
            params["user_ids"] = String(userId!)
        }
        
        AF.request(url, method: .get, parameters: params).response { result in
            if let data = result.data {
                
                do {
                    if let userData = try JSONDecoder().decode(UsersResponse.self, from: data).response.first {
                        completion(.success(userData))
                    } else {
                        completion(.failure(.custom(reason: "No user data fetched")))
                    }
                } catch {
                    completion(.failure(.custom(reason: error.localizedDescription)))
                }
            }
        }
    }
    
    func getFriendStatus(token: String, userId: Int, completion: @escaping (Result<Int, FetchDataError>) -> Void) {
        let url = "https://api.vk.com/method/friends.areFriends"
        
        let params: Parameters = [
            "access_token": token,
            "user_ids": String(userId),
            "v": "5.199"
        ]
        
        AF.request(url, method: .get, parameters: params).response { result in
            if let data = result.data {
                
                do {
                    if let friendStatus = try JSONDecoder().decode(AreFriendsResponse.self, from: data).response.first {
                        completion(.success(friendStatus.friendStatus))
                    } else {
                        completion(.failure(.custom(reason: "No friend data fetched")))
                    }
                } catch {
                    completion(.failure(.custom(reason: error.localizedDescription)))
                }
            }
        }
    }
    
    func getWall(token: String, userId: Int?, offset: Int?, count: Int, completion: @escaping (Result<Wallposts, FetchDataError>) -> Void) {
        let url = "https://api.vk.com/method/wall.get"
        
        var params: Parameters = [
            "access_token": token,
            "count": count,
            "extended": 1,
            "v": "5.199"
        ]
        
        if userId != nil {
            params["owner_id"] = userId
        }
        
        if offset != nil {
            params["offset"] = offset
        }
        
        AF.request(url, method: .get, parameters: params).response { result in
            if let data = result.data {
                
                do {
                    let wall = try JSONDecoder().decode(WallResponse.self, from: data).response
                    completion(.success(wall))
                } catch {
                    completion(.failure(.custom(reason: error.localizedDescription)))
                }
            }
        }
    }
    
    func deletePost(token: String, userId: Int?, postId: Int, completion: @escaping (Result<Bool, FetchDataError>) -> Void) {
        let url = "https://api.vk.com/method/wall.delete"
                
        var params: Parameters = [
            "access_token": token,
            "post_id": postId,
            "v": "5.199"
        ]
        
        if userId != nil {
            params["owner_id"] = userId
        }
        
        AF.request(url, method: .post, parameters: params).response { result in
            if let data = result.data {
                
                do {
                    let deleteCommentResult = try JSONDecoder().decode(DeleteCommentResponse.self, from: data).response
                    if deleteCommentResult == 1 {
                        completion(.success(true))
                    } else {
                        completion(.success(false))
                    }
                } catch {
                    completion(.failure(.custom(reason: error.localizedDescription)))
                }
            }
        }
    }
    
    func repost(token: String, ownerId: Int, postId: Int, completion: @escaping (Result<Int, FetchDataError>) -> Void) {
        let url = "https://api.vk.com/method/wall.repost"
        
        let object = "wall" + String(ownerId) + "_" + String(postId)
                
        let params: Parameters = [
            "access_token": token,
            "object": object,
            "v": "5.199"
        ]
        
        AF.request(url, method: .post, parameters: params).response { result in
            if let data = result.data {
                
                do {
                    let repostResult = try JSONDecoder().decode(RepostResponse.self, from: data).response
                    if repostResult.success == 1 {
                        completion(.success(repostResult.repostsCount))
                    } else {
                        completion(.failure(.custom(reason: "It's impossible to make a repost")))
                    }
                } catch {
                    completion(.failure(.custom(reason: error.localizedDescription)))
                }
            }
        }
    }
    
    func setStatus(token: String, text: String, completion: @escaping (Result<Bool, FetchDataError>) -> Void) {
        let url = "https://api.vk.com/method/status.set"
                
        let params: Parameters = [
            "access_token": token,
            "text": text,
            "v": "5.199"
        ]
        
        AF.request(url, method: .post, parameters: params).response { result in
            if let data = result.data {
                
                do {
                    let setNewStatusResponse = try JSONDecoder().decode(NewStatusResponse.self, from: data).response
                    if setNewStatusResponse == 1 {
                        completion(.success(true))
                    } else {
                        completion(.success(false))
                    }
                } catch {
                    completion(.failure(.custom(reason: error.localizedDescription)))
                }
            }
        }
    }
    
    func getGroupById(token: String, groupId: Int, completion: @escaping (Result<Group, FetchDataError>) -> Void) {
        let url = "https://api.vk.com/method/groups.getById"
        
        let groupIdString: String = {
            if groupId < 0 {
                return String(groupId * (-1))
            } else {
                return String(groupId)
            }
        }()
        
        let params: Parameters = [
            "access_token": token,
            "group_id": groupIdString,
            "fields": "description, members_count, status",
            "v": "5.199"
        ]
        
        AF.request(url, method: .get, parameters: params).response { result in
            if let data = result.data {
                
                do {
                    if let group = try JSONDecoder().decode(GroupsResponse.self, from: data).response.groups.first {
                        completion(.success(group))
                    } else {
                        completion(.failure(.custom(reason: "No groups found")))
                    }
                } catch {
                    completion(.failure(.custom(reason: error.localizedDescription)))
                }
            }
        }
    }
        
    func addFriend(token: String, userId: Int, completion: @escaping (Result<Int, FetchDataError>) -> Void) {
        let url = "https://api.vk.com/method/friends.add"
        
        let params: Parameters = [
            "access_token": token,
            "user_id": userId,
            "v": "5.199"
        ]
        
        AF.request(url, method: .post, parameters: params).response { result in
            if let data = result.data {
                
                do {
                    let addFriendResult = try JSONDecoder().decode(AddToFriendsResponse.self, from: data).response
                    completion(.success(addFriendResult))
                } catch {
                    completion(.failure(.custom(reason: error.localizedDescription)))
                }
            }
        }
    }
    
    func deleteFriend(token: String, userId: Int, completion: @escaping (Result<Bool, FetchDataError>) -> Void) {
        let url = "https://api.vk.com/method/friends.delete"
        
        let params: Parameters = [
            "access_token": token,
            "user_id": userId,
            "v": "5.199"
        ]
        
        AF.request(url, method: .post, parameters: params).response { result in
            if let data = result.data {
                
                do {
                    let deleteFriendResult = try JSONDecoder().decode(DeleteFriendResponse.self, from: data).response.success
                    if deleteFriendResult == 1 {
                        completion(.success(true))
                    } else {
                        completion(.success(false))
                    }
                } catch {
                    completion(.failure(.custom(reason: error.localizedDescription)))
                }
            }
        }
    }
    
    func joinGroup(token: String, groupId: Int, completion: @escaping (Result<Bool, FetchDataError>) -> Void) {
        let url = "https://api.vk.com/method/groups.join"
        
        let groupIdParameter: Int = {
            if groupId < 0 {
                return groupId * (-1)
            } else {
                return groupId
            }
        }()
        
        let params: Parameters = [
            "access_token": token,
            "group_id": groupIdParameter,
            "v": "5.199"
        ]
        
        AF.request(url, method: .post, parameters: params).response { result in
            if let data = result.data {
                
                do {
                    let joinGroupResult = try JSONDecoder().decode(JoinGroupResponse.self, from: data).response
                    if joinGroupResult == 1 {
                        completion(.success(true))
                    } else {
                        completion(.success(false))
                    }
                } catch {
                    completion(.failure(.custom(reason: error.localizedDescription)))
                }
            }
        }
    }
    
    func leaveGroup(token: String, groupId: Int, completion: @escaping (Result<Bool, FetchDataError>) -> Void) {
        let url = "https://api.vk.com/method/groups.leave"
        
        let groupIdParameter: Int = {
            if groupId < 0 {
                return groupId * (-1)
            } else {
                return groupId
            }
        }()
        
        let params: Parameters = [
            "access_token": token,
            "group_id": groupIdParameter,
            "v": "5.199"
        ]
        
        AF.request(url, method: .post, parameters: params).response { result in
            if let data = result.data {
                
                do {
                    let leaveGroupResult = try JSONDecoder().decode(LeaveGroupResponse.self, from: data).response
                    if leaveGroupResult == 1 {
                        completion(.success(true))
                    } else {
                        completion(.success(false))
                    }
                } catch {
                    completion(.failure(.custom(reason: error.localizedDescription)))
                }
            }
        }
    }
    
    func checkMembership(token: String, groupId: Int, completion: @escaping (Result<Bool, FetchDataError>) -> Void) {
        let url = "https://api.vk.com/method/groups.isMember"
        
        let groupIdParameter: Int = {
            if groupId < 0 {
                return groupId * (-1)
            } else {
                return groupId
            }
        }()
        
        let params: Parameters = [
            "access_token": token,
            "group_id": groupIdParameter,
            "v": "5.199"
        ]
        
        AF.request(url, method: .post, parameters: params).response { result in
            if let data = result.data {
                
                do {
                    let isMemberResult = try JSONDecoder().decode(CheckMembershipResponse.self, from: data).response
                    if isMemberResult == 1 {
                        completion(.success(true))
                    } else {
                        completion(.success(false))
                    }
                } catch {
                    completion(.failure(.custom(reason: error.localizedDescription)))
                }
            }
        }
    }
    
    func createPost(token: String, message: String, guid: String, completion: @escaping (Result<Bool, FetchDataError>) -> Void) {
        let url = "https://api.vk.com/method/wall.post"
        
        let params: Parameters = [
            "access_token": token,
            "message": message,
            "guid": guid,
            "v": "5.199"
        ]
        
        AF.request(url, method: .post, parameters: params).response { result in
            if let data = result.data {
                
                do {
                    let newPost = try JSONDecoder().decode(CreatePostResponse.self, from: data).response
                    if newPost.postId != nil {
                        completion(.success(true))
                    } else {
                        completion(.failure(.custom(reason: "It's impossible to create a new post")))
                    }
                } catch {
                    completion(.failure(.custom(reason: error.localizedDescription)))
                }
            }
        }
    }
    
    func getFeed(token: String, startFrom: String?, count: Int, completion: @escaping (Result<Wallposts, FetchDataError>) -> Void) {
        let url = "https://api.vk.com/method/newsfeed.get"
        
        var params: Parameters = [
            "access_token": token,
            "filters": "post",
            "count": count,
            "v": "5.199"
        ]
        
        if startFrom != nil {
            params["start_from"] = startFrom
        }
        
        AF.request(url, method: .get, parameters: params).response { result in
            if let data = result.data {
                
                do {
                    let wall = try JSONDecoder().decode(WallResponse.self, from: data).response
                    completion(.success(wall))
                } catch {
                    completion(.failure(.custom(reason: error.localizedDescription)))
                }
            }
        }
    }
    
    func searchVideo(token: String, q: String, offset: Int?, count: Int, completion: @escaping (Result<Videos, FetchDataError>) -> Void) {
        let url = "https://api.vk.com/method/video.search"
        
        var params: Parameters = [
            "access_token": token,
            "q": q,
            "count": count,
            "extended": 1,
            "fields": "photo_50",
            "v": "5.199"
        ]
        
        if offset != nil {
            params["offset"] = offset
        }
        
        AF.request(url, method: .get, parameters: params).response { result in
            if let data = result.data {
                
                do {
                    let videos = try JSONDecoder().decode(VideosResponse.self, from: data).response
                    completion(.success(videos))
                } catch {
                    completion(.failure(.custom(reason: error.localizedDescription)))
                }
            }
        }
    }
    
    func searchUsers(token: String, q: String, count: Int, offset: Int?, completion: @escaping (Result<Friends, FetchDataError>) -> Void) {
        let url = "https://api.vk.com/method/users.search"
        
        var params: Parameters = [
            "access_token": token,
            "q": q,
            "count": count,
            "fields": "photo_50,city",
            "v": "5.199"
        ]
        
        if offset != nil {
            params["offset"] = offset
        }
        
        AF.request(url, method: .get, parameters: params).response { result in
            if let data = result.data {
                
                do {
                    let responseResult = try JSONDecoder().decode(FriendsResponse.self, from: data).response
                    completion(.success(responseResult))
                } catch {
                    completion(.failure(.custom(reason: error.localizedDescription)))
                }
            }
        }
    }
}

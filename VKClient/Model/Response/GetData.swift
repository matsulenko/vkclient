//
//  GetData.swift
//  VKClient
//
//  Created by Matsulenko on 11.12.2023.
//

import Foundation
import Alamofire
import KeychainSwift

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
    case medium = "r"
    case large = "z"
}

public final class GetData {
    
    static let shared: GetData = {
        let instance = GetData()
        
        return instance
    }()
    
    func getFriends(token: String, type: ListOfProfilesType, userId: Int?, completion: @escaping (Result<[Friend], FetchDataError>) -> Void) {
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
            "fields": "photo_50",
            "v": "5.199"
        ]
        
        if userId != nil {
            params["user_id"] = userId
        }
        
        AF.request(url, method: .get, parameters: params).response { result in
            if let data = result.data {
                
                do {
                    let friends = try JSONDecoder().decode(FriendsResponse.self, from: data).response.items
                    completion(.success(friends))
                } catch {
                    completion(.failure(.custom(reason: error.localizedDescription)))
                }
            }
        }
    }
    
    func getSubscriptions(token: String, userId: Int?, completion: @escaping (Result<[SubscriptionGroup], FetchDataError>) -> Void) {
        let url = "https://api.vk.com/method/users.getSubscriptions"
        
        var params: Parameters = [
            "access_token": token,
            "fields": "photo_50",
            "v": "5.199",
            "extended": 1,
        ]
        
        if userId != nil {
            params["user_id"] = userId
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
    
    func getAllPhotos(token: String, userId: Int?, offset: Int, count: Int, size: PhotoSizes, completion: @escaping (Result<[SubscriptionGroup], FetchDataError>) -> Void) {
        let url = "https://api.vk.com/method/photos.getAll"
        
        var params: Parameters = [
            "access_token": token,
            "count": 9,
            "no_service_albums": 1,
            "v": "5.199",
            "extended": 1,
        ]
        
        if userId != nil {
            params["user_id"] = userId
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
}

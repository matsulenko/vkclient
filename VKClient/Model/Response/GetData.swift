//
//  FriendsViewModel.swift
//  VKClient
//
//  Created by Matsulenko on 11.12.2023.
//

import Foundation
import Alamofire

public final class GetData {
    
    static let shared: GetData = {
        let instance = GetData()
        
        return instance
    }()
    
    func getFriends(token: String, completion: @escaping ([Friend]) -> ()) {
        let url = "https://api.vk.com/method/friends.get"
        
        let params: Parameters = [
            "access_token": token,
            "fields": "photo_50",
            "v": "5.199",
            "count": 200
        ]
        
        AF.request(url, method: .get, parameters: params).response { result in
            if let data = result.data {
                if let friends = try? JSONDecoder().decode(FriendsResponse.self, from: data).response.items {
                    completion(friends)
                }
            }
        }
    }
    
}

//
//  InfoPlstData.swift
//  VKClient
//
//  Created by Matsulenko on 09.12.2023.
//

import Foundation

enum InfoPlist {
    static var clientId: String? {
        Bundle.main.infoDictionary?["CLIENT_ID"] as? String
    }
    
    static var tokenForPreviews: String = "vk1.a.1nDNkAWCp9czwCe-UkgUawc59KnO_hEkHbwcpuNd7aC1Bu_GXMh1wBHnwlfiYnYRA-qFaSiooRMSRHhx1aNAXKa5ZzVrnCa9S4qLwnU8ciE0HiwKjQXtNR5vIY2d-Ur4lAmb5uOqn7KIrRbmoUHzjqTHZYxQoi2dr-_6dWGKJ8AqAZC2eojUu3-TlHO1mbuEp_n7umi0kWWSdhUy_89aiA"
}

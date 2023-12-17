//
//  Mocks.swift
//  VKClient
//
//  Created by Matsulenko on 01.12.2023.
//

import Foundation
import SwiftUI

class Mocks {
    
    private var video1 = Video(
        id: 31,
        title: "Катя взлетает",
        description: "Настоящее волшебство от Кати!",
        fileName: "video1",
        preview: Image("preview1"),
        views: 123,
        likes: 12,
        postDate: "3 hours ago",
        authorName: "Andrey Matsulenko",
        authorAvatar: Image("cats19"),
        authorSubscribers: 4998,
        length: "00:10",
        liked: false
    )
    
    private var video2 = Video(
        id: 32,
        title: "Бабушка Лариса",
        description: "Прогноз от бабушки Ларисы",
        fileName: "video2",
        preview: Image("preview2"),
        views: 281,
        likes: 25,
        postDate: "3 hours ago",
        authorName: "Andrey Matsulenko",
        authorAvatar: Image("cats19"),
        authorSubscribers: 4998,
        length: "00:17",
        liked: false
    )
    
    private var video3 = Video(
        id: 33,
        title: "Бабушка Наташа",
        description: "Прогноз от бабушки Наташи",
        fileName: "video3",
        preview: Image("preview3"),
        views: 211,
        likes: 24,
        postDate: "3 hours ago",
        authorName: "Andrey Matsulenko",
        authorAvatar: Image("cats19"),
        authorSubscribers: 4998,
        length: "00:13",
        liked: false
    )
    
    public lazy var videos: [Video] = [video1, video2, video3]
    
    public var photos: [Photo] = [
        Photo(
            id: 1,
            description: "Лютик",
            image: Image("cats1"),
            album: "Коты",
            likes: 38,
            postDate: Date(),
            authorName: "Andrey Matsulenko",
            authorAvatar: Image("cats19"),
            comments: 10,
            liked: true
        ), Photo(
            id: 2,
            description: "Персик",
            image: Image("cats2"),
            album: "Коты",
            likes: 12,
            postDate: Date(),
            authorName: "Andrey Matsulenko",
            authorAvatar: Image("cats19"),
            comments: 0,
            liked: false
        ), Photo(
            id: 3,
            description: "Пуся",
            image: Image("cats3"),
            album: "Коты",
            likes: 13,
            postDate: Date(),
            authorName: "Andrey Matsulenko",
            authorAvatar: Image("cats19"),
            comments: 0,
            liked: false
        ), Photo(
            id: 4,
            description: "Лютик",
            image: Image("cats4"),
            album: "Коты",
            likes: 41,
            postDate: Date(),
            authorName: "Andrey Matsulenko",
            authorAvatar: Image("cats19"),
            comments: 0,
            liked: false
        ), Photo(
            id: 5,
            description: "Персик",
            image: Image("cats5"),
            album: "Коты",
            likes: 11,
            postDate: Date(),
            authorName: "Andrey Matsulenko",
            authorAvatar: Image("cats19"),
            comments: 0,
            liked: false
        ), Photo(
            id: 6,
            description: "Лютик",
            image: Image("cats6"),
            album: "Коты",
            likes: 18,
            postDate: Date(),
            authorName: "Andrey Matsulenko",
            authorAvatar: Image("cats19"),
            comments: 0,
            liked: false
        ), Photo(
            id: 7,
            description: "Лютик",
            image: Image("cats7"),
            album: "Коты",
            likes: 15,
            postDate: Date(),
            authorName: "Andrey Matsulenko",
            authorAvatar: Image("cats19"),
            comments: 0,
            liked: false
        ), Photo(
            id: 8,
            description: "Маркиз",
            image: Image("cats8"),
            album: "Коты",
            likes: 20,
            postDate: Date(),
            authorName: "Andrey Matsulenko",
            authorAvatar: Image("cats19"),
            comments: 0,
            liked: false
        ), Photo(
            id: 9,
            description: "Лютик",
            image: Image("cats9"),
            album: "Коты",
            likes: 11,
            postDate: Date(),
            authorName: "Andrey Matsulenko",
            authorAvatar: Image("cats19"),
            comments: 0,
            liked: false
        ), Photo(
            id: 10,
            description: "Персик",
            image: Image("cats10"),
            album: "Коты",
            likes: 12,
            postDate: Date(),
            authorName: "Andrey Matsulenko",
            authorAvatar: Image("cats19"),
            comments: 0,
            liked: false
        ), Photo(
            id: 11,
            description: "Пуся",
            image: Image("cats11"),
            album: "Коты",
            likes: 28,
            postDate: Date(),
            authorName: "Andrey Matsulenko",
            authorAvatar: Image("cats19"),
            comments: 0,
            liked: false
        ), Photo(
            id: 12000,
            description: "Марс",
            image: Image("cats12"),
            album: "Коты",
            likes: 9,
            postDate: Date(),
            authorName: "Andrey Matsulenko",
            authorAvatar: Image("cats19"),
            comments: 0,
            liked: false
        )
    ]
    
    public lazy var photoGalleries: [PhotoGallery] = [
        PhotoGallery(
            id: 41,
            title: "Коты",
            description: "Все наши котики!",
            photos: photos,
            dateOfUpdate: Date()
        ), PhotoGallery(
            id: 42,
            title: "Cats",
            description: "Все наши котики!!",
            photos: photos,
            dateOfUpdate: Date()
        )
    ]
    
    public lazy var videoPlaylists: [VideoPlaylist] = [
        VideoPlaylist(
            id: 51,
            title: "Бабушки",
            image: Image("preview2"),
            videos: [video2, video3],
            dateOfUpdate: Date()
        ), VideoPlaylist(
            id: 52,
            title: "Акробатика",
            image: Image("preview1"),
            videos: [video1],
            dateOfUpdate: Date()
        )
    ]
    
    public lazy var posts: [Post] = [
        Post(
            id: 61,
            profile: profile,
            description: "Max Verstappen (1st): “It was a good race! In the beginning I tried to avoid trouble, and everything went well, I overtook the rival cars one after another, after which I was able to complete many laps on one set of hard tires - I think we were able to succeed because of this.",
            likes: 30,
            views: 1201,
            attachedPhotos: [verstappen, horner, marko],
            postDate: "2 days ago",
            liked: true,
            comments: 10
        ),
        Post(
            id: 62,
            profile: profile2,
            description: "Helmut Marko: “We saw Max at his best. Just a sight to see, how he overtook Kevin Magnussen and Charles Leclerc. Max taught everyone a lesson. No one can take care of the tires like him to set the best time in the last laps.”",
            likes: 12,
            views: 313,
            attachedPhotos: [marko],
            postDate: "November 15",
            liked: false,
            comments: 10
        ),
        Post(
            id: 63,
            profile: profile3,
            description: "Christian Horner: “Nothing has been decided yet. Until the championship title is mathematically assured, anything can happen. We have a great car, a great team, we have two great drivers. But there is still a long way to go. Let's reserve judgment until we see what they faced in Imola and Barcelona”",
            likes: 23,
            views: 425,
            attachedPhotos: [horner],
            postDate: "October 15",
            liked: false,
            comments: 10
        ),
        Post(
            id: 64,
            profile: profile4,
            description: "Fernando Alonso (3rd): “I liked it, although I spent most of the race alone. There were two Red Bull cars ahead, which we can’t fight, and there wasn’t much pressure behind either. In the end I finished third. Fourth podium in five races. Good result.”",
            likes: 26,
            views: 1108,
            attachedPhotos: [alonso],
            postDate: "August 1",
            liked: false,
            comments: 10
        ),
        Post(
            id: 65,
            profile: profile5,
            description: "Бабушки делают свои прогнозы!!!",
            likes: 33,
            views: 105,
            attachedVideos: [video2, video3],
            postDate: "December 20, 2022",
            liked: false,
            comments: 10
        ),
    ]
        
    private var verstappen = Photo(
        id: 101,
        description: "Max Verstappen",
        image: Image("Verstappen"),
        likes: 0,
        postDate: Date(),
        authorName: "Max Verstappen",
        authorAvatar: Image("Verstappen"),
        comments: 0,
        liked: false
    )
    
    private var marko = Photo(
        id: 102,
        description: "Helmut Marko",
        image: Image("Verstappen"),
        likes: 0,
        postDate: Date(),
        authorName: "Helmut Marko",
        authorAvatar: Image("Marko"),
        comments: 0,
        liked: false
    )
    
    private var horner = Photo(
        id: 103,
        description: "Christian Horner",
        image: Image("Horner"),
        likes: 0,
        postDate: Date(),
        authorName: "Christian Horner",
        authorAvatar: Image("Horner"),
        comments: 0,
        liked: false
    )
    
    private var alonso = Photo(
        id: 104,
        description: "Fernando Alonso",
        image: Image("Alonso"),
        likes: 0,
        postDate: Date(),
        authorName: "Fernando Alonso",
        authorAvatar: Image("Alonso"),
        comments: 0,
        liked: false
    )
    
    public var profile = Profile(
        id: 2014,
        name: "Andrey",
        surname: "Matsulenko",
        gender: .male,
        birthday: Date(),
        country: "Russia",
        city: "Moscow",
        numberOfPosts: 15,
        subscriptions: 160,
        subscribers: 435,
        avatar: Image("cats19"),
        status: "Всем привет!"
    )
    
    public var profile2 = Profile(
        id: 2015,
        name: "Max",
        surname: "Verstappen",
        gender: .male,
        birthday: Date(),
        country: "Netherlands",
        city: "Amsterdam",
        numberOfPosts: 15,
        subscriptions: 160,
        subscribers: 435,
        avatar: Image("Verstappen")
    )
    
    public var profile3 = Profile(
        id: 2016,
        name: "Christian",
        surname: "Horner",
        gender: .male,
        birthday: Date(),
        country: "UK",
        city: "Milton Keynes",
        numberOfPosts: 15,
        subscriptions: 160,
        subscribers: 435,
        avatar: Image("Horner")
    )
    
    public var profile4 = Profile(
        id: 2017,
        name: "Helmut",
        surname: "Marko",
        gender: .male,
        birthday: Date(),
        country: "Austria",
        city: "Vienna",
        numberOfPosts: 15,
        subscriptions: 160,
        subscribers: 435,
        avatar: Image("Marko")
    )
    
    public var profile5 = Profile(
        id: 2018,
        name: "Fernando",
        surname: "Alonso",
        gender: .male,
        birthday: Date(),
        country: "Spain",
        city: "Barcelona",
        numberOfPosts: 15,
        subscriptions: 160,
        subscribers: 435,
        avatar: Image("Alonso")
    )
        
    public lazy var feed = Feed(
        id: 81,
        profiles: [profile2, profile, profile3, profile4, profile5, profile2, profile, profile3, profile4, profile5, profile2, profile, profile3, profile4, profile5, profile2, profile, profile3, profile4, profile5],
        posts: posts
    )
    
    public lazy var comments: [Comment] = [comment, commentWithPhoto, commentWithVideo, commentWithPhotos, commentWithVideos]
    
    public var comment = Comment(
        id: 71,
        authorName: "Max Verstappen",
        authorAvatar: Image("Verstappen"),
        text: "Очень-очень круто! Очень-очень круто! Очень-очень круто! Очень-очень круто! Очень-очень круто! Очень-очень круто! Очень-очень круто! Очень-очень круто! Очень-очень круто! Очень-очень круто! Очень-очень круто! Очень-очень круто!",
        likes: 0,
        postDate: "July 25",
        liked: false,
        isReply: false
    )
    
    public lazy var commentWithPhoto = Comment(
        id: 72,
        authorName: "Max Verstappen",
        authorAvatar: Image("Verstappen"),
        text: "Очень-очень круто! Великолепно!",
        likes: 0,
        postDate: "1 day ago",
        liked: false,
        isReply: true,
        attachedPhotos: [horner]
    )
    
    public lazy var commentWithPhotos = Comment(
        id: 73,
        authorName: "Max Verstappen",
        authorAvatar: Image("Verstappen"),
        text: "Очень-очень круто! Великолепно!",
        likes: 0,
        postDate: "1 day ago",
        liked: false,
        isReply: true,
        attachedPhotos: [verstappen, horner, marko, verstappen, horner, marko, verstappen, horner, marko]
    )
    
    public lazy var commentWithVideo = Comment(
        id: 74,
        authorName: "Max Verstappen",
        authorAvatar: Image("Verstappen"),
        text: "Очень-очень круто! Феноменально!",
        likes: 0,
        postDate: "November 15",
        liked: false,
        isReply: false,
        attachedVideos: [video1]
    )
    
    public lazy var commentWithVideos = Comment(
        id: 75,
        authorName: "Max Verstappen",
        authorAvatar: Image("Verstappen"),
        text: "Очень-очень круто! Феноменально!",
        likes: 0,
        postDate: "November 15",
        liked: false,
        isReply: false,
        attachedVideos: [video2, video3]
    )
    
    public lazy var message = Message(
        id: 91,
        profile: profile2,
        text: "Очень-очень круто!",
        postDate: "July 25",
        isMyMessage: false
    )
    
    public lazy var messageWithPhoto = Message(
        id: 92,
        profile: profile2,
        text: "Очень-очень круто!",
        postDate: "1 day ago",
        attachedPhotos: [verstappen],
        isMyMessage: false
        
    )
    
    public lazy var messageWithVideos = Message(
        id: 93,
        profile: profile2,
        text: "Очень-очень круто!",
        postDate: "November 15",
        attachedVideos: [video2, video3],
        isMyMessage: true
    )
    
    public lazy var message2 = Message(
        id: 94,
        profile: profile2,
        text: "В четверг вечером в FIA выпустили заявление о прекращении официального расследования в отношении Сьюзи и Тото Вольффа. Двое суток назад федерация выпустила заявление о расследовании в отношении неназванного руководителя команды Формулы 1 и сотрудника FOM, в которых гоночная общественность быстро распознала Тото Вольффа и его супругу Сьюзи. В рамках расследования в FIA хотели выяснить, не сообщает ли Сьюзи своему супругу конфиденциальную информацию о работе FOM, которая могла дать конкурентное преимущество Mercedes.",
        postDate: "July 25",
        isMyMessage: false
    )
    
    public lazy var message3 = Message(
        id: 95,
        profile: profile2,
        text: "Команда Mercedes, как и Сьюзи Вольфф, оперативно отреагировали на подозрения и довольно резко их опровергли. В среду вечером оставшиеся девять команд выпустили одинаковые официальные заявления со словами поддержки Сьюзи, а в четверг вечером в FIA опубликовали сообщение, из которого следует, что у федерации нет ни к кому претензий. «После проверки Кодекса поведения FOM и Политики в отношении конфликта интересов в Формуле 1, были получены подтверждения наличия соответствующих защитных мер для смягчения любых потенциальных конфликтов, – говорится в заявлении федерации. – FIA удовлетворена тем, что система соблюдения требований FOM достаточно надёжна, чтобы предотвратить любое несанкционированное раскрытие конфиденциальной информации. FIA может подтвердить, что не ведётся никаких этических или дисциплинарных расследований в отношении каких-либо лиц. В качестве регулирующего органа FIA обязана поддерживать целостность мирового автоспорта. FIA подтверждает свою приверженность честности и справедливости».",
        postDate: "July 25",
        isMyMessage: false
    )
    
    public lazy var message4 = Message(
        id: 96,
        profile: profile2,
        text: "Ох",
        postDate: "July 25",
        isMyMessage: true
    )
    
    public lazy var messages: [Message] = [message, messageWithPhoto, messageWithVideos, message2, message4, message3]
        
    static let shared: Mocks = {
        let instance = Mocks()
        return instance
    }()
        
    init() {}
    
}


//
//  ProfileView.swift
//  VKClient
//
//  Created by Matsulenko on 30.11.2023.
//

import KeychainSwift
import SwiftUI

enum ProfileType {
    case my
    case friend
    case notFriend
    case friendRequestIsSent
    case group
}

struct ProfileView: View {
    
    @State var hasError = false
    var token: String
    @State var myId: Int? = {
        if KeychainSwift().get("myId") == nil {
            return nil
        } else {
            return Int(KeychainSwift().get("myId")!)
        }
    }()
    @State var profile: User?
    @State var group: Group?
    @State var userId: Int?
    @State var title: String = ""
    @State var isShowingAvatar = false
    @State var deactivated = false
    @State var friendsCount: Int?
    @State var followersCount: Int?
    @State var subscriptionsCount: Int?
    @State var statusText: String = ""
    @State var newStatusText: String = ""
    @State var membersCount: Int?
    @State var isMember = false
    @State var createNewPost = false
    
    @State var profileType: ProfileType = .notFriend
        
    var body: some View {
        NavigationStack {
            if hasError {
                Text("Something went wrong")
                Button(
                    action: {
                        if myId == nil {
                            setMyId()
                        } else {
                            checkProfileType()
                        }
                        setData()
                    }, label: {
                        Text("Try to reload data")
                    })
                .buttonStyle(DefaultButton())
                .padding(.horizontal, 26)
                
            } else {
                ScrollView {
                    if profile != nil || group != nil {
                        let hasAccess = hasAccess()
                        let nameOfUser: String? = nameOfUserForDetails()
                        
                        VStack {
                            HStack {
                                VStack {
                                    AsyncImage(url: URL(string: getAvatarUrl())) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                            .frame(width: 100, height: 100)
                                            .clipped()
                                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                            .onTapGesture {
                                                if profileType != .group {
                                                    showAvatar()
                                                }
                                            }
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    Spacer()
                                }
                                if profileType != .group {
                                    if hasAccess {
                                        Spacer()
                                        if friendsCount != nil {
                                            NavigationLink {
                                                ProfilesView(token: token, userId: userId, nameOfUser: nameOfUser, typeOfProfiles: .friends, profilesTotalCount: friendsCount)
                                            } label: {
                                                VStack {
                                                    Text(String(friendsCount!))
                                                        .fontWeight(.semibold)
                                                        .foregroundStyle(.text)
                                                    Text(String.localizedStringWithFormat(NSLocalizedString("friends_", comment: ""), friendsCount!))
                                                        .font(.footnote)
                                                        .foregroundStyle(.text)
                                                }
                                            }
                                            Spacer()
                                        }
                                        if followersCount != nil {
                                            NavigationLink {
                                                ProfilesView(token: token, userId: userId, nameOfUser: nameOfUser, typeOfProfiles: .followers, profilesTotalCount: followersCount)
                                            } label: {
                                                VStack {
                                                    Text(String(followersCount!))
                                                        .fontWeight(.semibold)
                                                        .foregroundStyle(.text)
                                                    Text(String.localizedStringWithFormat(NSLocalizedString("followers_", comment: ""), followersCount!))
                                                        .font(.footnote)
                                                        .foregroundStyle(.text)
                                                }
                                            }
                                            Spacer()
                                        }
                                        if subscriptionsCount != nil {
                                            NavigationLink {
                                                ProfilesView(token: token, userId: userId, nameOfUser: nameOfUser, typeOfProfiles: .subscriptions, profilesTotalCount: subscriptionsCount)
                                            } label: {
                                                VStack {
                                                    Text(String(subscriptionsCount!))
                                                        .fontWeight(.semibold)
                                                        .foregroundStyle(.text)
                                                    Text(String.localizedStringWithFormat(NSLocalizedString("subscriptions_", comment: ""), subscriptionsCount!))
                                                        .font(.footnote)
                                                        .foregroundStyle(.text)
                                                }
                                            }
                                            Spacer()
                                        }
                                    }
                                }
                                if profileType == .group {
                                    if let description = group!.description {
                                        if description != "" {
                                            HStack {
                                                Text(description)
                                                    .lineLimit(nil)
                                                    .multilineTextAlignment(.leading)
                                                    .font(.footnote)
                                                    .padding(16)
                                                Spacer()
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(16)
                            
                            if profileType != .group {
                                if hasAccess {
                                    VStack {
                                        HStack {
                                            Text(geoField())
                                                .font(.subheadline)
                                            Spacer()
                                        }
                                        if let jobTitle = getJobTitle() {
                                            HStack {
                                                Text(jobTitle)
                                                    .font(.subheadline)
                                                    .lineLimit(nil)
                                                    .multilineTextAlignment(.leading)
                                                    .padding(.top, 10)
                                                Spacer()
                                            }
                                        }
                                    }
                                    .padding(.horizontal, 16)
                                }
                            }
                            
                            if profileType == .my {
                                HStack {
                                    if profileType == .my {
                                        Image(systemName: "pencil.line")
                                            .padding(.leading, 16)
                                        TextField("Set status", text: $newStatusText, axis: .vertical)
                                            .lineLimit(nil)
                                            .padding(10)
                                            .italic()
                                        Image(systemName: "checkmark.circle.fill")
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                            .padding(.trailing, 5)
                                            .foregroundStyle(statusText == newStatusText ? Color.clear : Color.accentColor)
                                            .onTapGesture {
                                                changeStatus()
                                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                        
                                            }
                                    }
                                    Spacer()
                                }
                                .background(Color.gray.opacity(0.3))
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .padding(.horizontal, 16)
                            }
                            
                            if statusText != "" && profileType != .my {
                                HStack {
                                    Text(statusText)
                                        .lineLimit(nil)
                                        .multilineTextAlignment(.leading)
                                        .padding(.top, 10)
                                        .italic()
                                    Spacer()
                                }
                                .padding(.horizontal, 16)
                            }
                            
                            // hidden because of security settings
                            if deactivated == false && profileType != .group {
                                Button(action: {
                                    buttonTapped()
                                }, label: {
                                    Text(buttonText())
                                })
                                .buttonStyle(
                                    DefaultButton(
                                        backgroundColor: buttonBackgroundColor(),
                                        textColor: buttonTextColor()
                                    )
                                )
                                .padding(16)
                                .shadow(radius: 5)
                            }
                            
                            if deactivated {
                                Text("This account is deactivated")
                            }
                            
                            if profileType == .group && membersCount != nil {
                                VStack {
                                    Divider()
                                    HStack {
                                        Text("Members")
                                            .foregroundStyle(Color("Text"))
                                            .font(.headline)
                                        Text(String(membersCount!))
                                            .foregroundStyle(.gray)
                                            .font(.headline)
                                        Spacer()
                                    }
                                }
                                .padding(.horizontal, 16)
                            }
                            
                            if profileType == .my {
                                VStack {
                                    Divider()
                                    NavigationLink {
                                        GroupsView(token: token)
                                    } label: {
                                        HStack {
                                            Text("My groups")
                                                .foregroundStyle(Color("Text"))
                                                .font(.headline)
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                                .foregroundStyle(.primary)
                                        }
                                    }
                                    .padding(.horizontal, 16)
                                }
                            }
                            
                            if hasAccess && deactivated == false {
                                ProfilePhotosView(token: token, userId: userId)
                                ProfileVideosView(token: token, userId: userId)
                                
                                VStack {
                                    Divider()
                                    HStack {
                                        Text("Posts")
                                            .foregroundStyle(Color("Text"))
                                            .font(.headline)
                                        Spacer()
                                    }
                                }
                                .padding(.horizontal, 16)
                                
                                PostView(createNewPost: $createNewPost, token: token, userId: userId)
                            }
                        }
                    }
                }
                .navigationBarTitle(title, displayMode: .inline)
                .onAppear {
                    if myId == nil {
                        setMyId()
                    } else {
                        checkProfileType()
                    }
                    setData()
                }
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                }
                .fullScreenCover(isPresented: $isShowingAvatar) {
                    PhotoView(token: token, photoIdString: profile!.photoId)
                }
                
            }
        }
        .onAppear()
    }
    
    private func setData() {
        if userId ?? 0 < 0 {
            setGroupData()
        } else {
            setProfileData()
            setCounts()
        }
    }
    
    private func showAvatar() {
        if profileType == .group {
            isShowingAvatar = true
        } else {
            if profile!.hasPhoto == 1 {
                isShowingAvatar = true
            }
        }
    }
    
    private func setProfileData() {
        Responses.shared.getUserData(token: token, userId: userId) { result in
            switch result {
            case .success(let profile): 
                self.profile = profile
                setTitle()
                if profile.deactivated != nil {
                    self.deactivated = true
                }
                setStatus()
                setOnlineStatus()
                self.hasError = false
            case .failure(let error):
                print("Something went wrong during profile data setting: \(error.localizedDescription)")
                self.hasError = true
            }
        }
    }
    
    private func setGroupData() {
        guard let userId else { return }
        Responses.shared.getGroupById(token: token, groupId: userId) { result in
            switch result {
            case .success(let group):
                self.group = group
                checkMembership()
                setTitle()
                setStatus()
                if group.deactivated != nil {
                    self.deactivated = true
                }
                self.membersCount = group.membersCount
                setOnlineStatus()
                self.hasError = false
            case .failure(let error):
                print("Something went wrong during profile data setting: \(error.localizedDescription)")
                self.hasError = true
            }
        }
    }
    
    private func changeStatus() {
        if profileType == .my {
            Responses.shared.setStatus(token: token, text: newStatusText) { result in
                switch result {
                case .success(let isSet):
                    if isSet {
                        statusText = newStatusText
                        profile!.status = newStatusText
                    } else {
                        print("Status has NOT been changed")
                    }
                case .failure(let error):
                    print("Something went wrong: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func setCounts() {
        if profileType != .group && deactivated == false {
            Responses.shared.getFriendsCount(token: token, type: .friends, userId: userId) { result in
                switch result {
                case .success(let count):
                    self.friendsCount = count
                case .failure(let error):
                    print("Something went wrong during profile data setting: \(error.localizedDescription)")
                }
            }
            Responses.shared.getFriendsCount(token: token, type: .followers, userId: userId) { result in
                switch result {
                case .success(let count):
                    self.followersCount = count
                case .failure(let error):
                    print("Something went wrong during profile data setting: \(error.localizedDescription)")
                }
            }
            Responses.shared.getSubscriptionsCount(token: token, userId: userId) { result in
                switch result {
                case .success(let count):
                    self.subscriptionsCount = count
                case .failure(let error):
                    print("Something went wrong during profile data setting: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func hasAccess() -> Bool {
        if profileType != .group {
            guard let profile else { return false }
            if profile.isClosed == nil {
                return true
            } else {
                if profile.isClosed! == false {
                    return true
                } else if profile.canAccessClosed == nil {
                    return false
                } else if profile.canAccessClosed == false {
                    return false
                } else {
                    return true
                }
            }
        } else {
            return true
        }
    }
    
    private func setMyId() {
        Responses.shared.getMyId(token: token) { result in
            switch result {
            case .success(let id):
                myId = id
                KeychainSwift().set(String(id), forKey: "myId")
                checkProfileType()
                
            case .failure(let error):
                print("Something went wrong: \(error.localizedDescription)")
                hasError = true
            }
        }
    }
    
    private func getAvatarUrl() -> String {
        let defaultImageUrl = "https://vk.com/images/camera_100.png"
        if profileType != .group {
            guard let avatarUrl = profile?.photo else { return defaultImageUrl }
            return avatarUrl
        } else {
            guard let groupAvatarUrl = group?.photo else { return defaultImageUrl }
            return groupAvatarUrl
        }
    }
    
    private func checkProfileType() {
        if myId == userId || userId == nil {
            self.profileType = .my
        } else if userId ?? 0 > 0 {
            Responses.shared.getFriendStatus(token: token, userId: userId!) { result in
                switch result {
                case .success(let friendStatus):
                    switch friendStatus {
                    case 1: self.profileType = .friendRequestIsSent
                    case 3: self.profileType = .friend
                    default: self.profileType = .notFriend
                    }
                case .failure(let error):
                    print("Something went wrong: \(error.localizedDescription)")
                    hasError = true
                }
            }
        } else {
            self.profileType = .group
        }
    }
    
    private func setStatus() {
        if profileType != .group {
            guard let profile else { return }
            if let status = profile.status {
                statusText = status
                if profileType == .my {
                    newStatusText = status
                }
            }
        } else {
            guard let group else { return }
            if let status = group.status {
                statusText = status
            }
        }
    }
    
    private func buttonText() -> String {
        switch profileType {
        case .my:
            return String(localized: "New post")
        case .friend:
            return String(localized: "Remove from friends")
        case .notFriend:
            return String(localized: "Add to friends")
        case .group:
            if isMember {
                return String(localized: "Leave the group")
            } else {
                return String(localized: "Join the group")
            }
        case .friendRequestIsSent:
            return String(localized: "Cancel friend request")
        }
    }
    
    private func setTitle() {
        if profileType != .group {
            guard let profile else { return }
            title = profile.firstName + " " + profile.lastName
        } else {
            guard let group else { return }
            title = group.name
        }
    }
    
    private func buttonBackgroundColor() -> Color {
        switch profileType {
        case .my:
            return Color.accentColor
        case .friend:
            return Color("BgButtonColor")
        case .notFriend:
            return Color.accentColor
        case .group:
            if isMember {
                return Color("BgButtonColor")
            } else {
                return Color.accentColor
            }
        case .friendRequestIsSent:
            return Color("BgColor")
        }
    }
    
    private func buttonTextColor() -> Color {
        switch profileType {
        case .my:
            return Color.white
        case .friend:
            return Color.red
        case .notFriend:
            return Color.white
        case .group:
            if isMember {
                return Color.red
            } else {
                return Color.white
            }
        case .friendRequestIsSent:
            return Color.accentColor
        }
    }
    
    private func geoField() -> String {
        if profileType != .group {
            guard let profile else { return "" }
            if profile.country != nil {
                if profile.city != nil {
                    return profile.country!.title + ", " + profile.city!.title
                } else {
                    return profile.country!.title
                }
            } else if profile.city != nil {
                return profile.city!.title
            } else {
                return ""
            }
        } else {
            return ""
        }
    }
    
    private func getJobTitle() -> String? {
        var jobTitle: String?
        
        if let career = profile?.career {
            if let currentJob = career.last(where: { $0.until == nil }) {
                if let position = currentJob.position {
                    if let company = currentJob.company {
                        jobTitle = position + ", " + company
                    } else {
                        if let occupationCompany = profile?.occupation?.name {
                            if profile?.occupation?.type == "work" {
                                jobTitle = position + ", " + occupationCompany
                            } else {
                                jobTitle = position
                            }
                        } else {
                            jobTitle = position
                        }
                    }
                } else {
                    jobTitle = currentJob.company
                }
            }
        }
        if jobTitle == nil {
            if let occupationCompany = profile?.occupation?.name {
                return occupationCompany
            } else {
                return nil
            }
        } else {
            return jobTitle
        }
    }
    
    private func nameOfUserForDetails() -> String? {
        if profileType == .my || title == "" {
            return nil
        } else {
            return title
        }
    }
    
    private func buttonTapped() {
        switch profileType {
        case .my:
            createNewPost = true
        case .friend:
            guard let userId else { return }
            Responses.shared.deleteFriend(token: token, userId: userId) { result in
                switch result {
                case .success(let wasDeleted):
                    if wasDeleted {
                        profileType = .notFriend
                    }
                case .failure(let error):
                    print("Something went wrong: \(error.localizedDescription)")
                }
            }
        case .notFriend:
            guard let userId else { return }
            Responses.shared.addFriend(token: token, userId: userId) { result in
                switch result {
                case .success(let success):
                    if success == 2 {
                        profileType = .friend
                    } else if success == 1 {
                        profileType = .friendRequestIsSent
                    }
                case .failure(let error):
                    print("Something went wrong: \(error.localizedDescription)")
                }
            }
        case .friendRequestIsSent:
            guard let userId else { return }
            Responses.shared.deleteFriend(token: token, userId: userId) { result in
                switch result {
                case .success(let wasDeleted):
                    if wasDeleted {
                        profileType = .notFriend
                    }
                case .failure(let error):
                    print("Something went wrong: \(error.localizedDescription)")
                }
            }
        case .group:
            guard let userId else { return }
            let groupId: Int = {
                if userId < 0 {
                    return userId * (-1)
                } else {
                    return userId
                }
            }()
            
            if isMember {
                Responses.shared.leaveGroup(token: token, groupId: groupId) { result in
                    switch result {
                    case .success(let hasLeft):
                        if hasLeft {
                            isMember = false
                        }
                    case .failure(let error):
                        print("Something went wrong: \(error.localizedDescription)")
                    }
                }
            } else {
                Responses.shared.joinGroup(token: token, groupId: groupId) { result in
                    switch result {
                    case .success(let hasJoined):
                        if hasJoined {
                            isMember = true
                        }
                    case .failure(let error):
                        print("Something went wrong: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    private func checkMembership() {
        guard let userId else { return }
        let groupId: Int = {
            if userId < 0 {
                return userId * (-1)
            } else {
                return userId
            }
        }()
        
        Responses.shared.checkMembership(token: token, groupId: groupId) { result in
            switch result {
            case .success(let isMemberResult):
                if isMemberResult {
                    isMember = true
                } else {
                    isMember = false
                }
            case .failure(let error):
                print("Something went wrong: \(error.localizedDescription)")
            }
        }
    }
    
    private func setOnlineStatus() {
        Responses.shared.setOnlineStatus(token: token)
    }
}

#Preview {
    ProfileView(token: InfoPlist.tokenForPreviews)
}

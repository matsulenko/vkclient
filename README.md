<img src="https://github.com/matsulenko/vkclient/assets/127790743/a08dd38e-8b6c-4abd-b170-9a82bf10b31b" height="250">

# VK Client for iOS
VK Client is an alternative client for social media VK for iOS.
I have made its UI with SwiftUI.
Local data saving works on SwiftData for "Saved posts" tab and on KeychainSwift for tokens.

# Features
## Login
<img src="https://github.com/matsulenko/vkclient/assets/127790743/66cdd775-62d0-4693-873e-cf94c4e7eb15" height="250">

Login screen is a webview. It uses UIViewRepresentable protocol.
Login screen opens Oauth VK link: https://oauth.vk.com/blank.html
On success App saves token via KeychainSwift and opens main screen.

## Feed
<img src="https://github.com/matsulenko/vkclient/assets/127790743/266dbfd3-8a86-4320-9492-51a5a82ecdc0" height="250">

The main screen of the app is "Feed". You can see posts of your friends and groups you are subscribed to.

### Like, share, comment and save.
<img src="https://github.com/matsulenko/vkclient/assets/127790743/a70ca582-4556-4cfb-8da1-f83ee9b76889">

There are special buttons in the bottom of every shown post:
- Like. You can like posts tapping this icon.
- Share. Tap this icon to repost content.
- Comments. If you want to read comments or to write a new one you can tap "comments" icon.
- Save. Tap this icon to save the post and read it offline. You can read this post later even if it has been deleted. This feature saves text and links only.

## Profile
<img src="https://github.com/matsulenko/vkclient/assets/127790743/d43025e2-099f-4ab5-9d5e-ff4358e5e011" height="250">

"Profile" screen shows opened account information:
- number of friends (tap this number to open friends list);
- number of followers (tap this number to see followers list);
- number of subscriptions (tap this number to open subscriptions list);
- photos;
- videos;
- posts;
- action button.

Action button depends on the type of your relationships with the opened profile. This feature helps you to add a person to your friends, to unfriend, to cancel friend request or to add a new post if you opened your own profile.

### My profile
<img src="https://github.com/matsulenko/vkclient/assets/127790743/1409544b-0e54-46a1-83c8-6a153da2fbe5" height="250">

"My profile" tab shows your account information and adds some additional features to the default profile screen:
- add a new post;
- change or set your status;
- delete posts.

## Group information
<img src="https://github.com/matsulenko/vkclient/assets/127790743/9e68d175-7720-479d-868b-31fd98934fb6" height="250">

Group information screen looks like profile. The only differences are:
- you can see the number of members;
- there is no action button;
- you can see group description instead of numbers of friends, followers and subscriptions.

## Search
<img src="https://github.com/matsulenko/vkclient/assets/127790743/4068a7c1-54d0-4d81-94ac-5b91e968b54a" height="250">
<img src="https://github.com/matsulenko/vkclient/assets/127790743/424120c0-57b6-4de6-b262-f07e6ab1a73c" height="250">
<img src="https://github.com/matsulenko/vkclient/assets/127790743/09f5d376-9f30-463e-a58f-93a85348b0d4" height="250">

Tap the "Search" tab to find videos and friends.

## Media
### Video
<img src="https://github.com/matsulenko/vkclient/assets/127790743/a3f8b659-6552-4630-be2f-6ee5bfd4d8f8" height="250">
<img src="https://github.com/matsulenko/vkclient/assets/127790743/9a64f129-b731-478a-beb4-1be52ca0d0f4" height="250">

Tap the video you want to watch and the video screen will be opened.
I used UIViewRepresentable (webview) to implement standard VK player.
There are some other features on the screen:
- number of views;
- the author information;
- comments;
- likes.

### Photo
<img src="https://github.com/matsulenko/vkclient/assets/127790743/55f47113-6d12-45a7-81af-c836192fc602" height="250">
<img src="https://github.com/matsulenko/vkclient/assets/127790743/a0b28f92-3718-485a-babd-2d4891181387" height="250">

Open a photo to enlarge it and to see its description, comments and likes.
Tap the photo once to hide action buttons and other information to see full photo.
Double tap scales photo via Zoomable.

## Comments
<img src="https://github.com/matsulenko/vkclient/assets/127790743/aec372b1-0eca-4c7e-988b-b806437b3180" height="250">

You can read and write comments to photos, videos and posts. You also can delete your own comments and other users' comments to your own content.

## Saved posts
<img src="https://github.com/matsulenko/vkclient/assets/127790743/5e48fcaa-3665-4645-94dc-ded525948a90" height="250">

Open the "Saved posts" tab to read the posts you saved before. This feature saves text and links only.

## Settings
<img src="https://github.com/matsulenko/vkclient/assets/127790743/98e8043b-dae1-483c-a80a-8ea600784f19" height="250">

### Hide your status
"Hide your status" feature hides your "Online" status. By default this setting is enabled.

### Appearance
<img src="https://github.com/matsulenko/vkclient/assets/127790743/50530fe0-201a-4bae-b17b-84a8a3ad02ee" height="250">

There are three appearance options:
- System (default);
- Light;
- Dark.

### Log out
You can log out tapping the "Log out" button.

# VK API usage
The app uses the following API VK methods:
- account.setOnline
- friends.add
- friends.areFriends
- friends.delete
- friends.get
- groups.get
- groups.getById
- groups.isMember
- newsfeed.get
- photos.get
- photos.getAlbums
- photos.getAll
- photos.getById
- status.set
- users.get
- users.getFollowers
- users.getSubscriptions
- users.search
- video.get
- video.getAlbums
- video.search
- wall.delete
- wall.get
- wall.post
- wall.repost

# Minimum Deployments
iOS 17.0

# Dependencies
- Alamofire
- KeychainSwift
- Zoomable

# Localization
WeatherApp has English and Russian localizations

# Developed by
WeatherApp is developed by Andrey Matsulenko during the Netology Swift course in 2023.

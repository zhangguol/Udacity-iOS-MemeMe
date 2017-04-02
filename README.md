# Udacity-iOS-MemeMe

MemeMe is a meme-generating app that enables a user to attach a caption to a picture from their phone.
After adding text to an image chosen from the Photo Album or Camera, the user can share it with friends.

This is a course project of Udacity iOS Nondegree class.

## Requirements

- Xcode 8.2.1
- Swift 3.0.2

## Run the project

```sh
$ git clone https://github.com/zhangguol/Udacity-iOS-MemeMe
$ cd Udacity-iOS-MemeMe
$ open MemeMe.xcworkspace
```

## Test

```sh
xcodebuild clean test \
  -workspace MemeMe.xcworkspace \
  -scheme MemeMe \
  -destination 'platform=iOS Simulator,name=iPhone 7'
```


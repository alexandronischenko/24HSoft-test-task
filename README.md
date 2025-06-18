# 24HSoft-test-task
## Overview

iOS app that displays photos from Unsplash API with two screens:

- Photo list
- Photo details

#### Key Features

- Fetches photos from Unsplash API
- Caches images and data (Kingfisher + CoreData)
- Works in portrait and landscape
- Error handling and loading states

#### Requirements

- Xcode 16+
- iOS 16+
- Unsplash API key

#### Setup

1. Get API key from [Unsplash Developers](https://unsplash.com/developers)
2. Add to `Secrets.swift`:
```swift
struct SecretKey {
    static let key = ""
}
```
3. Clone repo:
```
git clone https://github.com/alexandronischenko/24HSoft-test-task
cd 24HSoft-test-task
```
4. Open 24HSoft.xcodeproj
5. cmd + R


#### Architecture

- MVVM pattern
- UIKit with XIB
- Alamofire for networking
- Kingfisher



# VFlair - My Social Media Platform for Talent Sharing

<p align="center">
  <img src="icon/SVG/App Icon Main - 1024x1024.svg" alt="VFlair Logo" width="200"/>
</p>

## About My Project

I built VFlair in 2018 as a social media platform that enables talented individuals to share their work and gain recognition through a credit-based system. I designed it as a full-fledged iOS application with custom UI elements and branding that I created myself. Although I never completed the final deployment due to a pivot in my business direction and the intense competition in the social media space, the app reached an advanced stage of development.

## My Journey

I developed this application in 2018 while I was still in school. It was an ambitious project that taught me a lot about iOS development, Firebase integration, and UI/UX design. I implemented most of the core functionality, but eventually decided to pivot to other projects. The app now requires modernization to work with current iOS versions and frameworks, as it was built for an older iOS ecosystem.

## Key Features I Implemented

- **Custom Authentication System**: I built a complete email-based signup and login system using Firebase Authentication with custom UI
- **Dynamic Social Feed**: I created a home feed that dynamically displays posts from followed users with real-time updates
- **Creative Post Creation**: I implemented a photo sharing system with custom camera integration and caption support
- **Innovative Reaction System**: Instead of traditional likes, I designed a multi-reaction system (happy, sad, angry, cool, boring) to provide more nuanced feedback
- **Interactive Comments**: I built a complete comment system allowing users to engage with posts
- **Personalized User Profiles**: I designed profiles showing a user's posts, follower counts, and personal information
- **Social Graph**: I implemented a follow/unfollow system with Firebase Realtime Database
- **Smart Search**: I created a user search functionality with real-time results
- **Activity Notifications**: I built a notification system for social interactions (follows, comments, reactions)
- **Real-time Updates**: All interactions update in real-time using Firebase's real-time capabilities

## Technical Stack I Used

- **Primary Language**: Swift 4 with iOS 11/12 target
- **Architecture Pattern**: Model-View-Controller (MVC)
- **Backend Infrastructure**: Firebase suite of services
  - Firebase Authentication for user management
  - Firebase Realtime Database for data storage and real-time updates
  - Firebase Storage for media content (images)
  - Firebase Messaging for push notifications
  - Firebase Performance for monitoring
  - Firebase DynamicLinks for deep linking
- **Dependency Management**: CocoaPods
- **Key Dependencies**:
  - **SDWebImage**: I used this for efficient image loading and caching
  - **RAMAnimatedTabBarController**: Implemented for beautiful animated tab transitions
  - **Expanding Collection**: Integrated for card-based UI components
  - **RAMPaperSwitch**: Used for custom toggle switches throughout the app
  - **Fabric/Crashlytics**: Implemented for crash reporting and analytics
  - **JGProgressHUD**: Used for creating custom loading indicators
- **Custom Components**: I created several custom UI components for a unique look and feel

## How I Structured My Project

- **Model Layer**: I organized my data models and API services into a clean structure
  - User models with Firebase integration
  - Post and content models with reaction tracking
  - Comment system with threading support
  - Notification models for activity tracking
  - API service classes for each data type (UserApi, PostApi, etc.)
  - Helper services for common functionality

- **View Controllers**: I implemented numerous view controllers for different screens
  - Authentication flow (Login/Signup with validation)
  - Main feed with custom table cells and reaction buttons
  - Profile views (both personal and other users)
  - Camera and post creation interface
  - Comment viewing and creation
  - Search functionality with filters
  - Settings and configuration
  - Onboarding experience

- **Custom Views**: I designed several reusable UI components
  - Custom table cells for different content types
  - Reaction buttons with animations
  - Profile headers and footers
  - Custom navigation elements
  - Loading indicators and progress HUDs
  - Profile views
  - Camera/Post creation
  - Comments
  - Search
  - And more
- **Views**: Custom UI components and cells
- **Assets**: Contains all image assets, icons, and design resources

## Current State of My Project

I brought the app to an advanced stage of development with most core features fully implemented and working:

- **Authentication**: The complete login/signup flow works with Firebase
- **Content Creation**: Users can create posts with images and captions
- **Social Interactions**: The reaction system, comments, and follow functionality all work
- **Profiles**: User profiles display posts and follower information
- **Feed System**: The home feed pulls content from followed users
- **Search**: Users can find other users through the search feature
- **Notifications**: Activity notifications work for social interactions

Since I built this in 2018, the app now needs modernization in several areas:

- **Swift Language**: Needs updating from Swift 4 to the latest Swift version
- **iOS Compatibility**: Needs adaptation for newer iOS versions and screen sizes (including notched devices)
- **Firebase SDK**: Requires updating to the latest Firebase implementation
- **Deprecated APIs**: Several APIs used are now deprecated and need replacement
- **UI Refresh**: Some UI elements could benefit from a refresh to match current iOS design language

## How to Run My Project

### Prerequisites You'll Need

- Xcode 14+ (though it was built with a much older version)
- CocoaPods package manager
- iOS device or simulator (iOS 12.0 or higher recommended)
- Firebase account (if you want to set up your own backend)

### Installation Steps

1. Clone this repository to your local machine
2. Navigate to the `vFlair` directory in Terminal
3. Run `pod install` to install all dependencies
4. Open `vFlair.xcworkspace` in Xcode (not the .xcodeproj file)
5. You may need to update the Firebase configuration in GoogleService-Info.plist
6. Update the Bundle Identifier and signing certificates if you want to run on a physical device
7. Build and run the project

### Potential Issues

- You might encounter Swift version compatibility warnings
- Some dependencies may be outdated and require updates
- The Firebase configuration may need to be regenerated for your own Firebase project

## My Modernization Plans

If I were to continue developing VFlair today, here's what I would update:

1. **Swift Language Update**: Migrate from Swift 4 to Swift 5.9+
   - Update syntax and adopt new language features
   - Implement async/await for asynchronous operations
   - Use Swift Package Manager alongside or instead of CocoaPods

2. **Architecture Improvements**:
   - Refactor from MVC to MVVM architecture for better testability
   - Implement Combine framework for reactive programming
   - Add proper dependency injection

3. **UI Modernization**:
   - Support for all modern iPhone screen sizes
   - Implement Dark Mode support
   - Add dynamic type and improve accessibility
   - Consider migrating key views to SwiftUI
   - Update to use SF Symbols where appropriate

4. **Firebase Update**:
   - Update to the latest Firebase SDK
   - Implement Firebase Cloud Functions for server-side operations
   - Add Firebase Analytics for better user insights
   - Implement proper authentication state management

5. **Feature Enhancements**:
   - Add video support for posts
   - Implement direct messaging between users
   - Create a discover feed with algorithmic content suggestions
   - Add story/ephemeral content feature

## Database Structure

I designed the Firebase Realtime Database with the following structure:

```
- users
  - [user_id]
    - username
    - email
    - profileImageUrl
    - bio
    - createdAt
- posts
  - [post_id]
    - caption
    - photoUrl
    - uid (creator)
    - timestamp
    - happy (reactions)
    - sad (reactions)
    - angry (reactions)
    - cool (reactions)
    - boring (reactions)
- comments
  - [post_id]
    - [comment_id]
      - text
      - uid (commenter)
      - timestamp
- followers
  - [user_id]
    - [follower_id]: true
- following
  - [user_id]
    - [following_id]: true
- feed
  - [user_id]
    - [post_id]: true
- notifications
  - [user_id]
    - [notification_id]
      - type
      - from
      - objectId
      - timestamp
```

## License

This project is available for open use and modification. Feel free to fork, modify, and use it for your own projects. I'd appreciate attribution if you build something based on this work.

## Personal Note

I created VFlair while I was still in school, and it represents one of my first major iOS development projects. While I ultimately pivoted away from it due to market competition and other priorities, I'm proud of what I accomplished and the skills I developed building it. The custom UI elements, reaction system, and overall architecture taught me a lot about iOS development.

If you have any questions about the project or want to collaborate on updating it, feel free to reach out!

~ Prajwal V.v

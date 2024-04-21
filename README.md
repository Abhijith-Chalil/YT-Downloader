# YT Downloader

A Flutter app that allows you to download YouTube videos and store them locally for offline viewing. This app uses the [youtube_explode_dart](https://pub.dev/packages/youtube_explode_dart) package for downloading videos and the [isar](https://pub.dev/packages/isar) package for local storage. Playback of downloaded videos is handled by the [better_player](https://pub.dev/packages/better_player) package. Routing is implemented using the [go_router](https://pub.dev/packages/go_router) package.

## Features

- Download YouTube videos
- Store downloaded videos locally using Isar database
- Play downloaded videos offline using the Better Player package
- Simple and beautiful user interface

## Getting Started

1. Clone the repository
2. Install dependencies <br />
   Run below command in the root of the project : <br />
   "flutter pub get"<br />
   "flutter packages pub run build_runner build  --delete-conflicting-outputs"<br />
   "flutter pub run flutter_launcher_icons"<br />

## Usage

1. Enter the YouTube video URL in the provided text field.
2. Tap the "Download" button to start the download process.
3. Once the download is complete, the video will be saved in the local database.
4. Access the "Downloaded Videos" section to view and play your downloaded videos.

## Architecture - Domain-Driven Design (DDD)

This app follows the BLoC (Business Logic Component) pattern for state management, using the [flutter_bloc](https://pub.dev/packages/flutter_bloc) package. Dependency injection is implemented with the [get_it](https://pub.dev/packages/get_it) package.

Routing is handled by the [go_router](https://pub.dev/packages/go_router) package, which provides a declarative approach to navigation in Flutter apps.

## Dependencies

- [youtube_explode_dart](https://pub.dev/packages/youtube_explode_dart)
- [isar](https://pub.dev/packages/isar)
- [better_player](https://pub.dev/packages/better_player)
- [path_provider](https://pub.dev/packages/path_provider)
- [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- [get_it](https://pub.dev/packages/get_it)
- [go_router](https://pub.dev/packages/go_router)


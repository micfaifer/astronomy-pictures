# NASA Astronomy Picture Viewer

Hey there, this is a (in progress) MVP to the NASA Astronomy Picture Viewer app, a small project born for studying Flutter. With this app, you can explore into an awsome list of astronomy images straight from NASA's "Astronomy Picture of the Day" archive.

## What's Inside?

- A simple list of images captured by NASA's satellites and telescopes.
- Filter images by name or date to quickly find your cosmic moments.
- Dive into details about each image, including its date, title, and a brief description.
- Enjoy the app offline and keep exploring space.

## How to Launch

1. Clone this repository to your local machine using Git:
   ```
   git clone https://github.com/micfaifer/astronomy-pictures
   ```

2. Navigate to the project directory:
   ```
   cd astronomy-pictures
   ```

3. Update the `lib/config.dart` file with your own NASA API Key:
   ```dart
   static const String apiKey = 'your_api_key_here';
   ```

4. Launch the app on your preferred emulator or device:
   ```
   flutter run
   ```

## Project Structure

Here's a peek into the project structure:

```
lib/
|-- data/
|   |-- apod_service.dart
|   |-- data_exceptions.dart
|   |-- data_manager.dart
|-- models/
|   |-- apod.dart
|-- viewmodels/
|   |-- apod_viewmodel.dart
|-- views/
|   |-- apod_list_screen.dart
|   |-- widgets/
|       |-- search_app_bar.dart
|       |-- list/
|           |-- apod_list_item.dart
|-- main.dart
|--
tests/
|-- ...
```

## Dependencies

This app relies on the following packages:

- `http`: For making HTTP requests.
- `provider`: For state management.
- `intl`: For internationalization and date formatting.
- `cupertino_icons`: For providing iOS-style icons.
- `shared_preferences`: For managing app preferences.
- `cached_network_image`: For efficient image loading and caching.

## Generating Mocks with `mockito` and `build_runner`

I've used the `mockito` package for writing mock classes and `build_runner` to generate mock files. To generate mock files, run the following command in your terminal:

```
flutter pub run build_runner build
```

## Next Steps/ Improvments

**UI/UX Refinement**: Enhance the user interface and experience (list, details are pretty simple).

**Image Zoom and Pan**: Implement image zooming and panning for a closer look at the captivating cosmic images.

**Animations**: Add subtle animations to make the app feel dynamic and lively.

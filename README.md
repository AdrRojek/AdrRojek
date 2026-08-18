# Adrian Rojek — Flutter portfolio

The HTML CV site from the `website` branch, rebuilt as a Flutter app for **web (PC)**, **mobile**, and desktop.

Interactive pieces from the original page are Flutter widgets:

- 3D hanging profile card (drag / swing + click-to-flip)
- scroll-in reveals for info cards, skills, and projects
- project hover overlay and scale-in popup with image slideshow
- certificate / diploma hover (tap on mobile)
- star field background and desktop cursor glow

## Run locally

```bash
flutter pub get
flutter run -d chrome      # PC web
flutter run                # connected phone / emulator
flutter run -d linux       # desktop
```

## Build

```bash
# Web (GitHub Pages / adrrojekcv.com)
flutter build web --release --base-href /

# Mobile
flutter build apk
flutter build ios
```

After `flutter build web`, GitHub Pages serves the `website` branch (the compiled `build/web` output), not this source branch.

Live: https://adrrojek.github.io/AdrRojek/

This branch replaces the old `index.html` site. The GitHub profile README still lives on `main`.

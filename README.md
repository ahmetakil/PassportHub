# PassportHub

![flutter_test_workflow](https://github.com/ahmetakil/PassportHub/actions/workflows/flutter_test.yml/badge.svg)

![brand_logo](brand_assets/logo_512x512.png)

PassportHub is a mobile application designed to enhance the travel experience by providing users with the power to
explore, compare, and understand passport strengths and visa-free travel opportunities.

Leveraging Bloc pattern for state management and a feature-based folder structure, PassportHub ensures a scalable,
maintainable, and clean codebase.

<a href="https://play.google.com/store/apps/details?id=me.ahmetakil.passport_hub">
<img src="https://svgshare.com/i/tP8.svg" width="275px" alt="google_play_link"/></a>

> Live demo is available at:
> https://passporthub-ec83e.web.app/

## Table of Contents

- [Getting Started](#getting-started)
- [Features](#features)
- [Architecture](#architecture)

## Getting Started

To get started with PassportHub, ensure you have Flutter installed on your machine. Clone the repository, and then:

```bash
flutter pub get
flutter run
```

## Features

1. Explore global passport rankings.
    - <img src="brand_assets/explore.png" width="300" height="600" alt="explore">

2. Discover to which countries you and your international friends can travel with visa-free
    - <img src="brand_assets/travel.png" width="300" height="600" alt="travel">

3. Check visa requirements for a country.
    - <img src="brand_assets/country_details.png" width="300" height="600" alt="country_details">

- Compare the passport strength between two countries. [SOON]
- Bloc pattern for predictable state management.
- Bloc tests to ensure functionality and performance.
- Feature-based folder structure for better modularity.

## Architecture

PassportHub adopts a feature-based Foldering structure, this ensures both:

1. Each feature is easily accessible and provides encapsulation.

2. Makes it trivially easier to understand a feature since everything is in a single folder.

3. Uses open source data provided by [ilyankou](https://github.com/ilyankou/passport-index-dataset)
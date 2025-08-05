# Netflix Clone

A Flutter application inspired by Netflix, designed to deliver a seamless media browsing and streaming experience.

## Overview

This project aims to replicate key features of Netflix, providing users with an intuitive interface to browse movies and TV shows. The app integrates with TMDb (The Movie Database) API to fetch extensive media data, including:

- A wide variety of movie and TV show categories
- Detailed information about each media item (title, description, ratings, release date, etc.)
- Dynamic data loading with infinite scroll for smooth user experience

## Features

- **TMDb API Integration**: Fetches up-to-date data on movies, TV shows, and genres.
- **Category Browsing**: Allows users to explore content sorted by genre and popularity.
- **Infinite Scrolling**: Loads more content as users scroll down, improving user experience.
- **Clean Architecture**: The app is structured in layers to separate concerns and improve maintainability.
- **State Management with BLoC**: Uses the BLoC pattern to manage app state efficiently.
- **Responsive UI**: Designed to work smoothly on various screen sizes and platforms.

## Architecture

The app follows **Clean Architecture** principles divided into:

- **Presentation Layer**: UI widgets and screens, using Flutter.
- **Domain Layer**: Business logic and entities.
- **Data Layer**: API integration and data repositories.

This separation allows for easier testing, scalability, and maintenance.

## Getting Started

### Prerequisites

- Flutter SDK installed ([Installation guide](https://flutter.dev/docs/get-started/install))
- A TMDb API key (sign up at [TMDb](https://www.themoviedb.org/documentation/api))

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/leeerrrrmmm/NetflixClone.git
   cd NetflixClone

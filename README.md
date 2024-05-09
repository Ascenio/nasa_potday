# nasa_potday

A NASA's [Astronomy Picture of the Day API](https://github.com/nasa/apod-api) consumer app.

Contains some goodies such as:

- Layered architecture
- Pagination
- Animations
- Unit testing
- Widget testing
- Integration testing
- Offline-first
- Caching
- API keys via environment variables

https://github.com/Ascenio/nasa_potday/assets/7662016/079d3cba-9222-4d96-b690-bb01a0bb32a9

## Getting started

### Configuration

You will need an API key. You can get one [here](https://api.nasa.gov/).

After that you need to move `env-example.json` to `env.json` and fill it with key you just got.

> Or you could just use `env-example.json` as is. Just remember to provide the correct filee name in the commands bellow.

### Running

Nothing too special. Just remember to provide the env file as an argument:

```bash
flutter run --dart-define-from-file=env.json
```

### Testing

#### Unit and widget tests

Just the usual:

```bash
flutter test
```

#### Integration test

This one needs the [key](#configuration) as it will query the API.

To run all tests:

```bash
flutter test --dart-define-from-file=env.json integration_test
```

To run a specific test, provide its file name:

```bash
flutter test --dart-define-from-file=env.json integration_test/picture_of_the_day_test.dart 
```

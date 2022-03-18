# uwb_ios

[![pub package](https://img.shields.io/pub/v/uwb_ios.svg)](https://pub.dartlang.org/packages/uwb_ios)
![Build status](https://github.com/Baseflow/flutter_uwb/workflows/uwb_ios/badge.svg?branch=main)
[![style: flutter_lints](https://img.shields.io/badge/style-flutter_lints-40c4ff.svg)](https://pub.dev/packages/flutter_lints)

The endorsed iOS implementation of the [uwb][1]
plugin by [Baseflow](https://baseflow.com).

## Usage

This is the endorsed iOS version of the [uwb][1] 
plugin. This means it will automatically be added to your dependencies when you
depend on [uwb][1] in your applications
pubspec.yaml.

More detailed instructions on using the API can be found in the 
[README.md][7] of the [uwb][1]
package.

## Contributing

This package uses [pigeon][2] to generate the communication layer between 
Flutter and the host platform (iOS). The communication interface is defined in
the `pigeons/multipeer_connectivity_wrapper.dart` file. After editing the
communication interface regenerate the communication layer by running:

```bash
flutter pub run pigeon --input pigeons/multipeer_connectivity_wrapper.dart
```

Due to [flutter/flutter#97744](https://github.com/flutter/flutter/issues/97744), the generated test
pigeon file needs one of its imports updated to properly work with `mockito`.

In `test/android_webview.pigeon.dart`, change

```dart
import '../lib/src/multipeer_connectivity/multipeer_connectivity.pigeon.dart';
```

to

```dart
import 'package:uwb_ios/src/multipeer_connectivity/multipeer_connectivity.pigeon.dart';
```

Besides [pigeon][2] this package also uses [mockito][3] to generate mock objects for testing purposes. To generate the mock objects run the following command:
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

## Issues

Please file any issues, bugs or feature requests as an issue on our 
[GitHub][4] page. Commercial support is available, you can contact us at
<hello@baseflow.com>.

## Want to contribute

If you would like to contribute to the plugin (e.g. by improving the 
documentation, solving a bug or adding a cool new feature), please carefully
review our [contribution guide][5] and send us your 
[pull request][6].

## Author

This uwb plugin for Flutter is developed by [Baseflow](https://baseflow.com).

[1]: https://pub.dev/packages/uwb
[2]: https://pub.dev/packages/pigeon
[3]: https://pub.dev/packages/mockito
[4]: https://github.com/Baseflow/flutter_uwb/issues
[5]: https://github.com/Baseflow/flutter_uwb/blob/main/CONTRIBUTING.md
[6]: https://github.com/Baseflow/flutter_uwb_/pulls
[7]: https://github.com/Baseflow/flutter_uwb/blob/main/uwb/README.md
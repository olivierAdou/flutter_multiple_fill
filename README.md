# flutter_multiple_fill

A new flutter plugin project for multiple fill.

<img src="./example/assets/fluttermultiplefill.png" alt="Screenshot"/>

## Installing flutter_multiple_fill
It so simple to use it !!

First, add flutter_multiple_fill as a dependency in your pubspec.yaml file.

```yaml
dependencies:
  flutter_multiple_fill: ^1.0.1
```

And after it run this command.
```
  flutter pub get
```

## Usage
Import it
```
  import 'package:flutter_multiple_fill/flutter_multiple_fill.dart';
```
Now in your Dart code, you can use like that:
```
 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin FlutterMultipleFill'),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              FlutterMultipleFill(
                circleAvatarTextStyle: const TextStyle(fontSize: 12),
                circleAvatarColor: Colors.black,
                chipTextStyle:
                    const TextStyle(fontSize: 12, color: Colors.white),
                chipColor: Colors.blue,
                chipLabelPadding: 1,
                inputDecoration: const InputDecoration(
                  hintText: "Add email",
                  filled: false,
                  hintStyle: TextStyle(fontSize: 12),
                ),
                emailPattern: true,
                boxDecoration: const BoxDecoration(color: Colors.transparent),
                boxPadding: 0,
                keyboardType: TextInputType.emailAddress,
                // get all values as list from this function
                onfillCallback: (List value) {
                  setState(() {
                    list = value;
                    print(list);
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
```


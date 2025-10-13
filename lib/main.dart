import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.accents.first),
      ),
      home: const MyHomePage(title: 'Test text'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Матвиенко С.Д. ПИбд-33"),
      ),
      body: Center(
        child: const MyWidget(),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      _CardData(
          "text",
          description: "hello",
          icon: Icons.skateboarding_outlined,
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c0/Manul_Timofey_in_April_2025_%281%2C_cropped%29.jpg/330px-Manul_Timofey_in_April_2025_%281%2C_cropped%29.jpg'),
      _CardData(
          "test",
          description: "world",
          icon: Icons.wifi,
          imageUrl: 'https://static.mk.ru/upload/entities/2024/09/27/06/articles/facebookPicture/1d/39/cc/b7/8e98fb7312647c5aaf958cae41c94691.jpg',
      ),
      _CardData(
          "something",
          description: "send help",
          icon: Icons.sos,
          imageUrl: 'https://cs9.pikabu.ru/post_img/2017/08/27/4/og_og_1503809823210718041.jpg',
      ),
    ];

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:
            data.map((e) => _Card.fromData(e)).toList(),
        ),
      ),
    );
  }
}

class _CardData {
  final String text;
  final String description;
  final IconData icon;
  final String? imageUrl;

  _CardData(
      this.text, {
        required this.description,
        this.icon = Icons.abc,
        this.imageUrl,
      });
}

class _Card extends StatelessWidget {
  final String text;
  final String description;
  final IconData icon;
  final String? imageUrl;

  const _Card(
      this.text, {
        this.icon = Icons.add_alarm,
        required this.description,
        this.imageUrl,
      });

  factory _Card.fromData(_CardData cardData) => _Card(
    cardData.text,
    description: cardData.description,
    icon: cardData.icon,
    imageUrl: cardData.imageUrl,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.primaries.first.shade100,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: SizedBox(
                  width: 100,
                  height: 150,
                  child: Image.network(
                    imageUrl ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Placeholder(),
                  ),
                ),
              )
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    this.text,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    this.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Icon(icon),
          ),
        ],
      ),
    );
  }
}


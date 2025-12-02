import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/details_page/details_page.dart';
import '../../domain/models/card.dart';
part 'card.dart';

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
      body: Center(child: const Body()),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      CardData(
        "text",
        description: "hello",
        icon: Icons.skateboarding_outlined,
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c0/Manul_Timofey_in_April_2025_%281%2C_cropped%29.jpg/330px-Manul_Timofey_in_April_2025_%281%2C_cropped%29.jpg',
      ),
      CardData(
        "test",
        description: "world",
        icon: Icons.wifi,
        imageUrl:
            'https://static.mk.ru/upload/entities/2024/09/27/06/articles/facebookPicture/1d/39/cc/b7/8e98fb7312647c5aaf958cae41c94691.jpg',
      ),
      CardData(
        "something",
        description: "send help",
        icon: Icons.sos,
        imageUrl:
            'https://cs9.pikabu.ru/post_img/2017/08/27/4/og_og_1503809823210718041.jpg',
      ),
    ];

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: data
              .map(
                (data) => _Card.fromData(
                  data,
                  onLike: (String title, bool isLiked) =>
                      _showSnackbar(context, title, isLiked),
                  onTap: () => _navToDetails(context, data),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void _navToDetails(BuildContext context, CardData data) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => DetailsPage(data)),
    );
  }

  void _showSnackbar(BuildContext context, String title, bool isLiked) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Manul $title ${isLiked ? "is liked!" : "unliked :["}",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          backgroundColor: Colors.orangeAccent,
          duration: const Duration(seconds: 1),
        ),
      );
    });
  }
}

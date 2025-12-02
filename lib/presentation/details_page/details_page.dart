import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/models/card.dart';

class DetailsPage extends StatelessWidget {
  final CardData cardData;
  const DetailsPage(this.cardData, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Image.network(cardData.imageUrl ?? ''),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              cardData.text,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          Text(
            cardData.description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CardData {
  final String id;
  final String text;
  final String description;
  final IconData icon;
  final String? imageUrl;

  CardData(this.text, {required this.description, this.icon = Icons.abc, this.imageUrl, required this.id});
}

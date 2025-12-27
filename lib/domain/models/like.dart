class LikeEntity {
  final String cardId;

  LikeEntity(this.cardId);

  Map<String, dynamic> toMap() => {
    'card_id': cardId,
  };

  factory LikeEntity.fromMap(Map<String, dynamic> map) =>
      LikeEntity(map['card_id'] as String);
}
part of 'home_page.dart';

typedef OnLikeCallback = void Function(String title, bool isLiked)?;

class _Card extends StatelessWidget {
  final String id;
  final String text;
  final String description;
  final IconData icon;
  final String? imageUrl;
  final OnLikeCallback onLike;
  final VoidCallback? onTap;

  const _Card(
      this.text, {
        required this.id,
        required this.description,
        this.icon = Icons.add_alarm,
        this.imageUrl,
        this.onLike,
        this.onTap,
      });

  factory _Card.fromData(
      CardData cardData, {
        OnLikeCallback onLike,
        VoidCallback? onTap,
      }) =>
      _Card(
        cardData.text,
        id: cardData.id,
        description: cardData.description,
        icon: cardData.icon,
        imageUrl: cardData.imageUrl,
        onLike: onLike,
        onTap: onTap,
      );

  @override
  Widget build(BuildContext context) {
    final isLiked = context.select<LikeBloc, bool>(
          (bloc) => bloc.state.likedIds?.contains(id) ?? false,
    );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 12),
        constraints: const BoxConstraints(minHeight: 140),
        decoration: BoxDecoration(
          color: Colors.primaries.first.shade100,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(50),
              spreadRadius: 4,
              offset: const Offset(0, 5),
              blurRadius: 8,
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                child: SizedBox(
                  width: 100,
                  height: double.infinity,
                  child: Image.network(
                    imageUrl ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Placeholder(),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(text, style: Theme.of(context).textTheme.headlineLarge),
                      Text(description, style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 4, right: 10, bottom: 10),
                  child: GestureDetector(
                    onTap: () {
                      context.read<LikeBloc>().add(ChangeLikeEvent(id));
                      onLike?.call(text, !isLiked);
                    },
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: isLiked
                          ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        key: ValueKey(0),
                      )
                          : const Icon(
                        Icons.favorite_border,
                        key: ValueKey(1),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:learning_app/controller/wishlist_controller/WishlistController.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatefulWidget {
  final int? courseId;
  final int? price;
  final int variant;

  const FavoriteButton({
    Key? key,
    required this.courseId,
    required this.price,
    this.variant = 1,
  }) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    var provider = context.watch<Wishlistcontroller>();
    bool isFavorite = provider.favoriteIds.contains(widget.courseId.toString());

    return InkWell(
      onTap: () {
        setState(() {
          if (isFavorite) {
            provider.removeWishlist(
              widget.courseId,
              widget.variant,
              false,
              context,
            );
          } else {
            provider.AddWishlist(
              widget.courseId,
              widget.price,
              widget.variant,
            );
          }
        });
      },
      child: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border_sharp,
        color: isFavorite ? Colors.red : ColorConstants.primary_white,
      ),
    );
  }
}

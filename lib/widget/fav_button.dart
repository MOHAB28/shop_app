import 'package:flutter/material.dart';
import 'package:shop_app/constance/color.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/models/products_model.dart';


class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    Key? key,
    required this.model,
    required this.index,
  }) : super(key: key);

  final HomeModel? model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: AppCubit.get(context)
                  .favorties[model!.data!.products[index].id] ==
              true
          ? Icon(
              Icons.favorite,
              color: defualtColor,
            )
          : Icon(Icons.favorite_outline),
      onPressed: () {
        AppCubit.get(context)
            .changeFav(model!.data!.products[index].id);
      },
    );
  }
}

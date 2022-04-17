import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constance/color.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';

class FavScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = AppCubit.get(context);
        return model.favoriteModel == null
            ? Center(child: Text('You did not like ant item yet'))
            : model.favoriteModel != null &&
                    state is! AppGetFavoritesLoadingState
                ? ListView.separated(
                    padding: EdgeInsets.all(10),
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (ctx, i) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(
                          image: NetworkImage(
                            '${model.favoriteModel!.data!.product![i].data!.image}',
                          ),
                          width: 150,
                          height: 150,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Expanded(
                          child: Text(
                            '${model.favoriteModel!.data!.product![i].data!.name}',
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: AppCubit.get(context).favorties.containsKey(
                                      model.favoriteModel!.data!.product![i]
                                          .data!.id) ==
                                  true
                              ? Icon(
                                  Icons.favorite,
                                  color: defualtColor,
                                )
                              : Icon(Icons.favorite_outline),
                          onPressed: () {
                            AppCubit.get(context).changeFav(model
                                .favoriteModel!.data!.product![i].data!.id);
                          },
                        )
                      ],
                    ),
                    separatorBuilder: (ctx, i) => Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                    itemCount: model.favoriteModel!.data!.product!.length,
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
      },
    );
  }
}

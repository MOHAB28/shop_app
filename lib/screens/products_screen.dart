import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/widget/fav_button.dart';
import '../constance/color.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../models/products_model.dart';
import '../widget/cat_item.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppChangeFavoritesSuccessState) {
          if (state.favoriteModel!.status == false) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '${state.favoriteModel!.message}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Theme.of(context).errorColor,
              ),
            );
          }
        }
      },
      builder: (context, state) {
        var homeModel = AppCubit.get(context).products;
        var catModel = AppCubit.get(context).categoriesModel;
        return homeModel != null && catModel != null
            ? SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                      items: AppCubit.get(context)
                          .products!
                          .data!
                          .banners
                          .map((e) => Image(
                                image: NetworkImage('${e.image}'),
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ))
                          .toList(),
                      options: CarouselOptions(
                        height: 250,
                        initialPage: 0,
                        viewportFraction: 1.0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayAnimationDuration: Duration(seconds: 1),
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 100,
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, i) => CategoriesItemBuilder(
                            catModel: catModel.data!.data![i]),
                        separatorBuilder: (ctx, i) => SizedBox(
                          width: 3,
                        ),
                        itemCount: catModel.data!.data!.length,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.grey[300],
                      child: GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 5.0,
                        crossAxisSpacing: 5.0,
                        shrinkWrap: true,
                        childAspectRatio: 1 / 1.58,
                        children: List.generate(
                          AppCubit.get(context).products!.data!.products.length,
                          (index) => GridViewItemBuilder(
                            model: homeModel,
                            index: index,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}

class GridViewItemBuilder extends StatelessWidget {
  const GridViewItemBuilder({
    Key? key,
    required this.model,
    required this.index,
  }) : super(key: key);

  final HomeModel? model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            child: Stack(
              children: [
                Image(
                  image: NetworkImage(
                    model!.data!.products[index].image,
                  ),
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.fill,
                ),
                if (model!.data!.products[index].oldPrice !=
                    model!.data!.products[index].price)
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      color: Colors.red,
                      child: Text(
                        'discount',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            model!.data!.products[index].name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Spacer(),
          Row(
            children: [
              Text(
                '${model!.data!.products[index].price.round()}',
                style: TextStyle(
                  color: defualtColor,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              if (model!.data!.products[index].oldPrice !=
                  model!.data!.products[index].price)
                Text(
                  '${model!.data!.products[index].oldPrice.round()}',
                  style: TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              Spacer(),
              FavoriteButton(model: model, index: index),
            ],
          ),
        ],
      ),
    );
  }
}


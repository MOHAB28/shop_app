import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';

class CatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cat = AppCubit.get(context).categoriesModel!.data!.data;
        return ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (ctx, i) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image(
                image: NetworkImage(
                  '${cat![i].image}',
                ),
                width: 150,
                height: 150,
              ),
              Text(
                '${cat[i].name}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios_outlined),
                onPressed: () {},
              ),
            ],
          ),
          separatorBuilder: (ctx, i) => Container(
            margin: EdgeInsetsDirectional.only(
              start: 25,
            ),
            width: double.infinity,
            height: 1,
            color: Colors.grey,
          ),
          itemCount: cat!.length,
        );
      },
    );
  }
}

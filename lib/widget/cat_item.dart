import 'package:flutter/material.dart';
import '../models/cat_model.dart';

class CategoriesItemBuilder extends StatelessWidget {
  const CategoriesItemBuilder({
    Key? key,
    required this.catModel,
  }) : super(key: key);

  final Data? catModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Stack(
        children: [
          Image(
            image: NetworkImage(
              '${catModel!.image}',
            ),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 30,
              color: Colors.black.withOpacity(
                .8,
              ),
              child: Center(
                child: Text(
                  '${catModel!.name}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
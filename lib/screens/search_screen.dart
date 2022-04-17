import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constance/color.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/search/cubit.dart';
import 'package:shop_app/cubit/search/states.dart';

class SearchScreen extends StatelessWidget {
  var _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var searchModel = SearchCubit.get(context).searchModel;
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Search',
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                    onFieldSubmitted: (value) {
                      SearchCubit.get(context).search(value);
                    },
                  ),
                  if(searchModel == null)
                  Center(
                    child: Text(
                      'Please enter something',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if(state is SearchLoadingState)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: LinearProgressIndicator(),
                  ),
                  if(state is SearchSuccessState)
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.only(top: 10),
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (ctx, i) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(
                            image: NetworkImage(
                              '${searchModel!.data!.product![i].image}',
                            ),
                            width: 150,
                            height: 150,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Expanded(
                            child: Text(
                              '${searchModel.data!.product![i].name}',
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: AppCubit.get(context).favorties[AppCubit.get(context).products!.data!.products[i].id] == true
                                ? Icon(
                                    Icons.favorite,
                                    color: defualtColor,
                                  )
                                : Icon(Icons.favorite_outline),
                            onPressed: () {
                              AppCubit.get(context).changeFav(
                                  AppCubit.get(context).products!.data!.products[i].id);
                            },
                          )
                        ],
                      ),
                      separatorBuilder: (ctx, i) => Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                      itemCount: searchModel!.data!.product!.length,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

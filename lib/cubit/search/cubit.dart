import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constance/login.dart';
import 'package:shop_app/cubit/search/states.dart';
import 'package:shop_app/helpers/dio_helper.dart';
import 'package:shop_app/models/search_model.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  void search(String text) {
    emit(SearchLoadingState());
    DioHelpers.postData(
      url: SEARCH,
      data: {
        'text': text,
      },
      token: token,
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}

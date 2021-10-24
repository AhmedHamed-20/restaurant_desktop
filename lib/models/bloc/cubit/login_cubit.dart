import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_windows/layout/admin_layout/admin_layout_screen.dart';
import 'package:restaurant_windows/models/bloc/states/login_states.dart';
import 'package:restaurant_windows/models/cach/chach.dart';
import 'package:restaurant_windows/models/dio/dio.dart';
import 'package:restaurant_windows/models/dio/end_points.dart';
import 'package:restaurant_windows/widgets/navigate.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(AppintiState());
  static LoginCubit get(context) => BlocProvider.of(context);

  Future getAllusers(String token) {
    return DioFunc.getdate(
      url: EndPoints.users,
      token: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    ).then((value) {
      EndPoints.allUser = value.data['data']['data'];
      print(EndPoints.allUser);

      emit(UsersGetSuccess());
    }).catchError((onError) {
      print(onError);
      emit(UsersGetError());
    });
  }

  Future getAllOrders(String token) {
    return DioFunc.getdate(
      url: '${EndPoints.allOrders}',
      token: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    ).then((value) {
      EndPoints.allorders = value.data['data']['data'];

      emit(OrderGetSuccess());
      print(EndPoints.allorders);
    }).catchError((onError) {
      emit(OrderGetError());
      print(onError);
    });
  }

  Future getAllCategories() {
    return DioFunc.getdate(
      url: EndPoints.categories,
    ).then((value) {
      EndPoints.allCategories = value.data['data']['data'];
      emit(CategorieCreatedSuccess());
      print(EndPoints.allCategories);
    }).catchError((onError) {
      emit(CategorieCreatedError());
      print(onError);
    });
  }

  Future getallRecipes() {
    return DioFunc.getdate(
      url: EndPoints.allRecipies,
    ).then((value) {
      EndPoints.allrecipesAdmin = value.data['data']['data'];
      print(EndPoints.allrecipesAdmin);
      emit(RecipesGetSuccess());
    }).catchError((onError) {
      print(onError);
      emit(RecipesGetError());
    });
  }

  String token;
  login(String email, String password, BuildContext context) {
    emit(LoginLoadingState());
    try {
      DioFunc.postData(
        EndPoints.Login,
        {
          "email": email,
          "password": password,
        },
      ).then((value) {
        print(value.data['token']);
        token = value.data['token'];
        CachFunc.putStringDate(key: 'token', data: value.data['token'])
            .then((value) async {
          await getAllusers(token).then((value) async {
            print(value);
            await getallRecipes();
            getAllCategories();
            getAllOrders(token);
            emit(DataGetSucces());
            Navigate(context: context, Screen: AdminLayout());
          });
        });
      });
    } on DioError catch (e) {
      emit(DataGeterror());
      print(e.response);
    }
  }
}

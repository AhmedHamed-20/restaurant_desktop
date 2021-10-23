

import 'package:restaurant_windows/models/class_models/login_model.dart';
import 'package:restaurant_windows/models/class_models/sign_up_model.dart';

class EndPoints {
  static String url = 'https://panda-restaurant.herokuapp.com/api/v1';
  static String SignUp = url + '/users/signup';
  static String Login = url + '/users/login';
  static String allRecipies = url + '/recipes/';
  static String allRecipiesPage = url + '/recipes/?page=';
  static String categories = url + '/categories/';
  static String search = url + '/recipes/search';
  static String updateMe = url + '/users/updateMe';
  static String order = url + '/orders/';
  static String users = url + '/users/';
  static String allusersPage = url + '/users/?page=';
  static String allOrders = url + '/orders/all';
  static String allOrdersPage = url + '/orders/all?page=';
  static String getCategoryRecipe = url + '/recipes/?category=';
  static String updatePassword = url + '/users/updateMyPassword';
  static String forgetPassword = url + '/users/forgotPassword';
  static String cancelOrder = url + '/orders/cancelOrder/';

  static LoginModel loginModel;
  static SignUpModel signUpModel;
  static Map<String, dynamic> allRecipiesMap;
  static List allCategoriesMap;
  static List recipes = [];
  static List FilteredCartDataBase = [];
  static List FavoriteDataBase = [];
  static List allUser = [];
  static List allorders = [];
  static List allCategories = [];
  static List allrecipesAdmin = [];

  static bool isDark = false;
}

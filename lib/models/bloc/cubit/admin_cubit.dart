import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:restaurant_windows/models/bloc/states/admin_state.dart';
import 'package:restaurant_windows/models/cach/chach.dart';
import 'package:restaurant_windows/models/dio/dio.dart';
import 'package:restaurant_windows/models/dio/end_points.dart';
import 'package:restaurant_windows/screens/admin_screens/categories_admin_screen.dart';
import 'package:restaurant_windows/screens/admin_screens/orders_admin_screen.dart';
import 'package:restaurant_windows/screens/admin_screens/recipes_admin_screen.dart';
import 'package:restaurant_windows/screens/admin_screens/users_admin_screen.dart';
import 'package:toast/toast.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AppintiState());

  static AdminCubit get(context) => BlocProvider.of(context);

  int currentindex = 0;
  List<Widget> screen = [
    UsersAdmin(),
    RecipesAdmin(),
    CategoriesAdmin(),
    OrdersAdmin(),
  ];
  List<String> title = [
    'Users',
    'Recipes',
    'Categories',
    'Orders',
  ];

  changBottomnav(int index) {
    currentindex = index;

    emit(ChangebottomState());
  }

  bool result = true;

  Future<bool> checkConnecthion() async {
    result = await InternetConnectionChecker().hasConnection;
    emit(HasConnecthion());
    return result;
  }

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
      noDataUsers = false;
      emit(UsersGetSuccess());
    }).catchError((onError) {
      print(onError);
      emit(UsersGetError());
    });
  }

  deleteUserById(String token, String userId, context) {
    DioFunc.deleteData(
      url: '${EndPoints.users + userId}',
      token: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    ).then((value) {
      print(value);
      pageUsrs = 2;
      getAllusers(token);
      Toast.show("Deleted success", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white);
    }).catchError((onError) {
      print(onError);
    });
  }

  updateuser(String token, String userId, String name, String email,
      BuildContext context, String role) {
    DioFunc.patchdata(
      url: '${EndPoints.users + userId}',
      token: token,
      name: name,
      email: email,
      role: role,
    ).then((value) {
      print(value);
      getAllusers(token);
      Navigator.of(context).pop();
    }).catchError((onError) {
      print(onError);
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

  createNewCategory(String token, String categorieName, BuildContext context) {
    DioFunc.postData(
      EndPoints.categories,
      {'name': categorieName},
      token: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    ).then((value) async {
      print(value);

      Navigator.of(context).pop();
      await getAllCategories();
      emit(CategorieCreatedSuccess());
    }).catchError((onError) {
      emit(CategorieCreatedError());
      print(onError);
    });
  }

  deleteCategorie(String token, String CategorieId, context) {
    DioFunc.deleteData(
      url: '${EndPoints.categories + CategorieId}',
      token: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    ).then((value) {
      print(value);

      getAllCategories();
      Toast.show("Deleted success", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white);
    }).catchError((onError) {
      print(onError);
    });
  }

  editCategorieName(
      String name, String token, String CategorieID, BuildContext context) {
    DioFunc.patchCategoriedata(
      url: '${EndPoints.categories + CategorieID}',
      token: token,
      name: name,
    ).then((value) {
      print(value);
      Navigator.of(context).pop();
      getAllCategories();
    }).catchError((onError) {
      print(onError);
    });
  }

  int page = 2;
  int pageUsrs = 2;
  int pageRecipe = 2;
  bool noData = false;
  bool noDataUsers = false;
  bool noDataRecipe = false;

  pageinathionOrders(String token, context) {
    emit(PageLoading());
    DioFunc.getdate(
      url: '${EndPoints.allOrdersPage + page.toString()}',
      token: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    ).then((
      value,
    ) {
      // print(value.data['results']);
      if (value.data['results'] == 0) {
        page = page;
        noData = true;
        Toast.show("End of data", context,
            duration: Toast.LENGTH_SHORT,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white);

        emit(PageGetEnd());
      } else {
        page++;
        print(EndPoints.allorders.length);
        EndPoints.allorders.addAll(value.data['data']['data']);
        print(EndPoints.allorders);
        emit(PageGetSuccess());
      }
    }).onError((error, stackTrace) {
      print(error);
      emit(PageGetError());
    });
  }

  pageinathionusers(String token, context) {
    emit(PageLoading());
    DioFunc.getdate(
      url: '${EndPoints.allusersPage + pageUsrs.toString()}',
      token: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    ).then((
      value,
    ) {
      // print(value.data['results']);
      if (value.data['results'] == 0) {
        pageUsrs = pageUsrs;
        noDataUsers = true;
        Toast.show("End of data ):", context,
            duration: Toast.LENGTH_SHORT,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white);

        emit(PageGetEnd());
      } else {
        pageUsrs++;
        print(EndPoints.allUser.length);
        EndPoints.allUser.addAll(value.data['data']['data']);
        print(EndPoints.allUser);
        emit(PageGetSuccess());
      }
    }).onError((error, stackTrace) {
      print(error);
      emit(PageGetError());
    });
  }

  pageinathionRecipes(context) {
    emit(PageLoading());
    DioFunc.getdate(
      url: '${EndPoints.allRecipiesPage + pageRecipe.toString()}',
    ).then((
      value,
    ) {
      // print(value.data['results']);
      if (value.data['results'] == 0) {
        pageRecipe = pageRecipe;
        noDataRecipe = true;
        Toast.show("End of data ):", context,
            duration: Toast.LENGTH_SHORT,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white);

        emit(PageGetEnd());
      } else {
        pageRecipe++;

        EndPoints.allrecipesAdmin.addAll(value.data['data']['data']);
        print(EndPoints.allrecipesAdmin);
        emit(PageGetSuccess());
      }
    }).onError((error, stackTrace) {
      print(error);
      emit(PageGetError());
    });
  }

  // updateUserDataBase(
  //     {String name, String email, @required String token, context}) {
  //   DioFunc.patchdata(
  //     url: EndPoints.updateMe,
  //     name: name,
  //     email: email,
  //     token: token,
  //   ).then((value) {
  //     DataBaseFun.updateDataBase(email, name).then((value) {
  //       Fluttertoast.showToast(
  //         msg: 'Updated successfully',
  //         backgroundColor: Colors.green,
  //         textColor: Colors.white,
  //       );
  //       emit(updatedSucess());
  //     });

  //     print(name + email);
  //     //  print(value);
  //   }).catchError(
  //     (onError) {
  //       print(onError);
  //     },
  //   );
  // }

  Future getallRecipes() {
    return DioFunc.getdate(
      url: EndPoints.allRecipies,
    ).then((value) {
      EndPoints.allrecipesAdmin = value.data['data']['data'];
      noDataRecipe = false;
      print(EndPoints.allrecipesAdmin);
      emit(RecipesGetSuccess());
    }).catchError((onError) {
      print(onError);
      emit(RecipesGetError());
    });
  }

  deleteRecipe(String token, String recipeId, context) {
    DioFunc.deleteData(
      url: '${EndPoints.allRecipies + recipeId}',
      token: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    ).then((value) {
      print(value);
      pageRecipe = 2;
      getallRecipes();
      Toast.show("Deleted Success", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white);

      emit(RecipesDeleteSuccess());
    }).catchError((onError) {
      print(onError);
      emit(RecipesDeleteError());
    });
  }

  FilePickerResult picker;
  File imagepicked;

  pickimage() async {
    // Pick an image

    picker = await FilePicker.platform.pickFiles().then((value) {
      emit(ImagePicked());
      imagepicked = File(value.files.single.path);
    }).catchError((onError) {
      print(onError);
    });
    print(imagepicked.uri);
  }

  FilePickerResult picker2;
  File AddImagePicked;

  Addimagepick() async {
    // Pick an image
    picker2 = await FilePicker.platform.pickFiles().then((value) {
      emit(ImagePicked());
      AddImagePicked = File(value.files.single.path);
    }).catchError((onError) {
      print(onError);
    });
    print(AddImagePicked.uri);
  }

  editRecipeData(String token, String name, String slug, int price,
      int cookingtime, List ingredients, String recipeId, File image, context) {
    DioFunc.patchRecipe(
            token: token,
            ingredients: ingredients,
            slug: slug,
            price: price,
            cookingTime: cookingtime,
            name: name,
            image: image,
            url: '${EndPoints.allRecipies + recipeId}')
        .then((value) {
      print(value);

      getallRecipes();
      emit(RecipesGetSuccess());
      Toast.show("Changes Saved Sucess", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white);

      Navigator.of(context).pop();
      // imagepicked = null;
    }).catchError((onError) {
      Toast.show(
        "error",
        context,
        duration: Toast.LENGTH_SHORT,
        gravity: Toast.BOTTOM,
        textColor: Colors.white,
        backgroundColor: Colors.red,
      );

      print(onError);
    });
  }

  // CreateRecipeData(String token, String name, String slug, int price,
  //     int cookingtime, List ingredients, String recipeId, File image) {
  //  DioFunc.postData(url, {})
  // }
  List<TextEditingController> controller = [];

  cancelOrder(String recipeId, String token, BuildContext context) {
    DioFunc.deleteData(
      url: '${EndPoints.order + recipeId}',
      token: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    ).then((value) {
      page = 2;
      getAllOrders(token);
      Toast.show(
        "Deleted Success",
        context,
        duration: Toast.LENGTH_SHORT,
        gravity: Toast.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      Navigator.of(context).pop();
      emit(OrderDeleteSuccess());

      print(value);
    }).catchError((onError) {
      emit(OrderDeleteError());
      print(onError);
    });
  }

  int lengthOFtextfield = 5;

  incrementTextfieldNumber(List<TextEditingController> savedcontroller) {
    controller = savedcontroller;
    lengthOFtextfield++;
    print(lengthOFtextfield);
    emit(IncrementTExtFieldNumer());
  }

  decrementTextfieldNumber(
      List<TextEditingController> savedcontroller, int index) {
    controller = savedcontroller;
    controller[index].clear();
    lengthOFtextfield--;
    print(lengthOFtextfield);
    emit(DecremntTExtFieldNumer());
  }

  addRecipe({
    String name,
    List ingredient,
    int price,
    int cockingtime,
    String slug,
    String category,
    String token,
    File image,
    context,
  }) {
    emit(UploadState());
    DioFunc.postRecipe(
            url: EndPoints.allRecipies,
            name: name,
            cookingTime: cockingtime,
            price: price,
            slug: slug,
            ingredients: ingredient,
            token: token,
            category: category,
            image: image)
        .then((value) {
      print(value);
      pageRecipe = 2;
      getallRecipes();

      emit(RecipeCreatedSucces());
      Navigator.of(context).pop();
      Toast.show(
        "Created Success",
        context,
        duration: Toast.LENGTH_SHORT,
        gravity: Toast.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      for (int i = 0; i < controller.length; i++) {
        controller[i].clear();
      }
      lengthOFtextfield = 5;
    }).catchError((onError) {
      Toast.show(
        "error,please make sure to fill all fields and size of image less than 2 mb",
        context,
        duration: Toast.LENGTH_SHORT,
        gravity: Toast.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );

      print(onError);
      emit(RecipeCreatedError());
    });
  }

  editRecipeWithoutPhoto(
      String recipeId,
      String token,
      String name,
      String slug,
      List ingredients,
      String category,
      int cockingtime,
      int price,
      context) {
    emit(UploadState());
    DioFunc.patchRecipeWithoutPhoto(
            token: token,
            category: category,
            slug: slug,
            price: price,
            name: name,
            ingredients: ingredients,
            url: '${EndPoints.allRecipies + recipeId}',
            cookingTime: cockingtime)
        .then((value) {
      print(value);
      Toast.show(
        "changes saved success",
        context,
        duration: Toast.LENGTH_SHORT,
        gravity: Toast.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      Navigator.of(context).pop();
      getallRecipes();
      emit(RecipesGetSuccess());
    }).catchError((onError) {
      Toast.show(
        "error",
        context,
        duration: Toast.LENGTH_SHORT,
        gravity: Toast.BOTTOM,
        textColor: Colors.white,
        backgroundColor: Colors.red,
      );

      print(onError);
    });
  }

  changeTheme() async {
    EndPoints.isDark = !EndPoints.isDark;
    await CachFunc.putBoolDate(key: 'isDark', data: EndPoints.isDark);
    emit(ChangeTheme());
  }
}

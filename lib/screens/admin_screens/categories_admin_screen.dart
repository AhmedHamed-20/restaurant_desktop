import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:restaurant_windows/models/bloc/cubit/admin_cubit.dart';
import 'package:restaurant_windows/models/bloc/states/admin_state.dart';
import 'package:restaurant_windows/models/cach/chach.dart';
import 'package:restaurant_windows/models/dio/end_points.dart';

class CategoriesAdmin extends StatelessWidget {
  const CategoriesAdmin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController categorieName = TextEditingController();
    TextEditingController categorieNewName = TextEditingController();
    String token = CachFunc.getData('token');
    var cubit = AdminCubit.get(context);
    //cubit.getAllCategories();
    refresh() {
      return cubit.getAllCategories();
    }

    return BlocConsumer<AdminCubit, AdminState>(
        builder: (context, state) {
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: FloatingActionButton(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                backgroundColor:
                    EndPoints.isDark ? Color(0xff393E46) : Colors.grey[100],
                child: Icon(
                  Icons.add,
                  color: Colors.orangeAccent,
                ),
                onPressed: () {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return SingleChildScrollView(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.7,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                ),
                                color: EndPoints.isDark
                                    ? Color(0xff393E46)
                                    : Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                  ),
                                  Text(
                                    'Create new Categorie',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Batka',
                                        color: EndPoints.isDark
                                            ? Colors.white
                                            : EndPoints.isDark
                                                ? Colors.white
                                                : EndPoints.isDark
                                                    ? Colors.white
                                                    : Colors.black),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.12,
                                  ),
                                  TextField(
                                    style: TextStyle(
                                      color: EndPoints.isDark
                                          ? Colors.white
                                          : EndPoints.isDark
                                              ? Colors.white
                                              : Colors.black,
                                    ),
                                    cursorColor: EndPoints.isDark
                                        ? Colors.white
                                        : EndPoints.isDark
                                            ? Colors.white
                                            : Colors.black,
                                    controller: categorieName,
                                    keyboardType: TextInputType.text,
                                    onChanged: (value) {},
                                    onSubmitted: (val) {},
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          color: EndPoints.isDark
                                              ? Colors.white
                                              : EndPoints.isDark
                                                  ? Colors.white
                                                  : Colors.black,
                                        ),
                                      ),
                                      labelText: 'Categorie Name',
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                            color: Colors.orangeAccent,
                                          )),
                                      labelStyle: TextStyle(
                                          color: EndPoints.isDark
                                              ? Colors.white
                                              : EndPoints.isDark
                                                  ? Colors.white
                                                  : Colors.black),
                                      prefixIcon: Icon(
                                        IconlyBroken.paper,
                                        color: EndPoints.isDark
                                            ? Colors.white
                                            : EndPoints.isDark
                                                ? Colors.white
                                                : Colors.black,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                            color: Colors.orangeAccent,
                                          )),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.orangeAccent,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    color: Colors.orangeAccent,
                                    onPressed: () {
                                      cubit.createNewCategory(
                                          token, categorieName.text, context);
                                    },
                                    child: Text(
                                      'Add',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
            backgroundColor: Colors.transparent,
            body: EndPoints.allCategories.isEmpty
                ? RefreshIndicator(
                    onRefresh: refresh,
                    child: SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'NO Categories to show',
                              style: TextStyle(
                                color: EndPoints.isDark
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 18,
                                fontFamily: 'Batka',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: refresh,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Card(
                            color: EndPoints.isDark
                                ? Color(0xff393E46)
                                : Colors.white,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(children: [
                              EndPoints.allCategories == null
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: ListView.separated(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount:
                                            EndPoints.allCategories.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              categorieNewName.clear();
                                              showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)),
                                                  context: context,
                                                  builder: (context) {
                                                    return SingleChildScrollView(
                                                      padding: EdgeInsets.only(
                                                          bottom: MediaQuery.of(
                                                                  context)
                                                              .viewInsets
                                                              .bottom),
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(12),
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.7,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    25),
                                                            topRight:
                                                                Radius.circular(
                                                                    25),
                                                          ),
                                                          color: EndPoints
                                                                  .isDark
                                                              ? Color(
                                                                  0xff393E46)
                                                              : Colors.white,
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'Update Categorie Name',
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontFamily:
                                                                      'Bakta',
                                                                  color: EndPoints
                                                                          .isDark
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black),
                                                            ),
                                                            SizedBox(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.08,
                                                            ),
                                                            TextField(
                                                              style: TextStyle(
                                                                color: EndPoints
                                                                        .isDark
                                                                    ? Colors
                                                                        .white
                                                                    : EndPoints
                                                                            .isDark
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                              ),
                                                              cursorColor: EndPoints
                                                                      .isDark
                                                                  ? Colors.white
                                                                  : EndPoints
                                                                          .isDark
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                              controller:
                                                                  categorieNewName,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .text,
                                                              onChanged:
                                                                  (value) {},
                                                              onSubmitted:
                                                                  (val) {},
                                                              decoration:
                                                                  InputDecoration(
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15),
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: EndPoints.isDark
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                                  ),
                                                                ),
                                                                labelText:
                                                                    'Categorie New Name',
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                15),
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              Colors.orangeAccent,
                                                                        )),
                                                                labelStyle: TextStyle(
                                                                    color: EndPoints.isDark
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black),
                                                                prefixIcon:
                                                                    Icon(
                                                                  IconlyBroken
                                                                      .paper,
                                                                  color: EndPoints
                                                                          .isDark
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                ),
                                                                border:
                                                                    OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                15),
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              Colors.orangeAccent,
                                                                        )),
                                                                disabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Colors
                                                                        .orangeAccent,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            MaterialButton(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            25),
                                                              ),
                                                              color: Colors
                                                                  .orangeAccent,
                                                              onPressed: () {
                                                                cubit
                                                                    .editCategorieName(
                                                                  categorieNewName
                                                                      .text,
                                                                  token,
                                                                  EndPoints.allCategories[
                                                                          index]
                                                                      ['_id'],
                                                                  context,
                                                                );
                                                              },
                                                              child: Text(
                                                                'Change',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            },
                                            child: ListTile(
                                              title: Text(
                                                EndPoints.allCategories[index]
                                                    ['name'],
                                                style: TextStyle(
                                                  fontFamily: 'Bakta',
                                                  fontSize: 20,
                                                  color: EndPoints.isDark
                                                      ? Colors.white
                                                      : EndPoints.isDark
                                                          ? Colors.white
                                                          : Colors.black,
                                                ),
                                              ),
                                              trailing: MaterialButton(
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.orangeAccent,
                                                ),
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          backgroundColor:
                                                              EndPoints.isDark
                                                                  ? Color(
                                                                      0xff393E46)
                                                                  : Colors
                                                                      .white,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                          ),
                                                          title: Text(
                                                            'You sure to delete this category',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color: EndPoints
                                                                      .isDark
                                                                  ? Colors.white
                                                                  : EndPoints
                                                                          .isDark
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                              fontFamily:
                                                                  'Bakta',
                                                            ),
                                                          ),
                                                          content: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                MaterialButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                    'Cancel',
                                                                    style: TextStyle(
                                                                        color: EndPoints.isDark
                                                                            ? Colors.white
                                                                            : Colors.black),
                                                                  ),
                                                                ),
                                                                MaterialButton(
                                                                  onPressed:
                                                                      () {
                                                                    cubit.deleteCategorie(
                                                                        token,
                                                                        EndPoints.allCategories[index]
                                                                            [
                                                                            '_id'],
                                                                        context);
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                    'Confirm',
                                                                    style: TextStyle(
                                                                        color: EndPoints.isDark
                                                                            ? Colors.white
                                                                            : Colors.black),
                                                                  ),
                                                                ),
                                                              ]),
                                                        );
                                                      });
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return Divider(
                                            color: EndPoints.isDark
                                                ? Color(0xff222831)
                                                : Colors.grey[300],
                                            thickness: 1.5,
                                          );
                                        },
                                      ),
                                    )
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ),
          );
        },
        listener: (context, state) {});
  }
}

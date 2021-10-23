import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:restaurant_windows/models/bloc/cubit/admin_cubit.dart';
import 'package:restaurant_windows/models/bloc/states/admin_state.dart';
import 'package:restaurant_windows/models/dio/end_points.dart';

class AdminLayout extends StatelessWidget {
  var token;
  AdminLayout({this.token});
  // Map<String, dynamic> userDate;
  // LayoutScreen(this.userDate);
  @override
  Widget build(BuildContext context) {
    var cubit = AdminCubit.get(context);
    cubit.checkConnecthion();
    return BlocConsumer<AdminCubit, AdminState>(
      listener: (context, state) {},
      builder: (context, state) {
        // if (token != null) {
        //   cubit.getdata();
        // }
        return WillPopScope(
          onWillPop: () async {
            cubit.changBottomnav(0);
            return false;
          },
          child: Scaffold(
            backgroundColor:
                EndPoints.isDark ? Color(0xff222831) : Colors.grey[200],
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.orangeAccent,
              unselectedItemColor: Colors.grey,
              backgroundColor:
                  EndPoints.isDark ? Color(0xff222831) : Colors.white,
              onTap: (index) {
                cubit.changBottomnav(index);
              },
              currentIndex: cubit.currentindex,
              items: [
                BottomNavigationBarItem(
                  backgroundColor:
                      EndPoints.isDark ? Color(0xff222831) : Colors.white,
                  icon: cubit.currentindex == 0
                      ? Icon(IconlyBold.user3)
                      : Icon(IconlyBroken.user3),
                  label: 'Users',
                ),
                BottomNavigationBarItem(
                  backgroundColor:
                      EndPoints.isDark ? Color(0xff222831) : Colors.white,
                  icon: cubit.currentindex == 1
                      ? Icon(Icons.restaurant_menu)
                      : Icon(Icons.restaurant_menu),
                  label: 'Recipes',
                ),
                BottomNavigationBarItem(
                  backgroundColor:
                      EndPoints.isDark ? Color(0xff222831) : Colors.white,
                  icon: cubit.currentindex == 2
                      ? Icon(IconlyBold.category)
                      : Icon(IconlyBroken.category),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  backgroundColor:
                      EndPoints.isDark ? Color(0xff222831) : Colors.white,
                  icon: cubit.currentindex == 3
                      ? Icon(IconlyBold.buy)
                      : Icon(IconlyBroken.buy),
                  label: 'Orders',
                ),
              ],
            ),
            appBar: AppBar(
              leading: MaterialButton(
                onPressed: () {
                  cubit.changeTheme();
                },
                child: Icon(
                  EndPoints.isDark ? Icons.wb_sunny : Icons.dark_mode,
                  color: EndPoints.isDark
                      ? Colors.white
                      : EndPoints.isDark
                          ? Colors.white
                          : Colors.black,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              title: Text(
                '${cubit.title[cubit.currentindex]}',
                style: TextStyle(
                  color: EndPoints.isDark ? Colors.white : Colors.grey[800],
                  fontFamily: 'Batka',
                ),
              ),
              actions: [],
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.light,
              ),
            ),
            body: cubit.result
                ? cubit.screen[cubit.currentindex]
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'No internet',
                          style: TextStyle(
                            color:
                                EndPoints.isDark ? Colors.white : Colors.black,
                            fontFamily: 'Batka',
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: MaterialButton(
                            onPressed: () {},
                            child: Text(
                              'Retry',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Batka',
                                fontSize: 16,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}

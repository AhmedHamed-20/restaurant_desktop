import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_windows/models/bloc/cubit/login_cubit.dart';
import 'package:restaurant_windows/models/bloc/states/login_states.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = LoginCubit();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return BlocConsumer<LoginCubit, LoginState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[100],
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width * 0.4,
                    color: Colors.orangeAccent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18, top: 12),
                          child: Text(
                            'Welome To\nPanda Restaurant',
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                fontSize: 40,
                                fontFamily: 'Batka'),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.17,
                        ),
                        Image.asset('assets/images/login.png')
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.15,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: TextField(
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  cursorColor: Colors.black,
                                  controller: emailController,
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {},
                                  onSubmitted: (val) {},
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    labelText: 'Email',
                                    labelStyle: TextStyle(color: Colors.black),
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: Colors.black,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          color: Colors.orangeAccent,
                                        )),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        )),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: TextField(
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  cursorColor: Colors.black,
                                  controller: passwordController,
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {},
                                  onSubmitted: (val) {},
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    labelText: 'Password',
                                    labelStyle: TextStyle(color: Colors.black),
                                    prefixIcon: Icon(
                                      Icons.password,
                                      color: Colors.black,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          color: Colors.orangeAccent,
                                        )),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        )),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                color: Colors.orangeAccent,
                                onPressed: () {
                                  cubit.login(emailController.text,
                                      passwordController.text, context);
                                },
                                child: state is LoginLoadingState
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : Text(
                                        'Login',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}

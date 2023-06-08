import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/business_logic/shared_pref/cache_helper.dart';

import '../../../business_logic/login/cubit/login_cubit.dart';
import '../../components/constant.dart';
import '../register_screen/register_screen.dart';
import '../../layout/home_layout.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginState>(
        listener: (context,state){
          if(state is SocialLoginErrorState){
            showToast(
              text: state.error,
              state: ToastState.error,
            );
          }
          if(state is SocialLoginSuccessState){
            CacheHelper.saveData(
              key: 'uId', 
              value: state.uId,
            ).then((value){
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context)=> const HomeLayout()));
            });
              
          }
        },
        builder: (context, state){
          return Scaffold(
                appBar: AppBar(
                  elevation: 0.0,
                  
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'LOGIN',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontSize: 22, color: Colors.black),
                            ),
                            const SizedBox(height: 20.0),
                            Text(
                              'Login now to communicate with friends',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontSize: 20),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter your email address';
                                }
                              },
                              decoration: const InputDecoration(
                                label: Text('Email Address'),
                                prefixIcon: Icon(Icons.email_outlined),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            TextFormField(
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'password is too short';
                                }
                              },
                              onFieldSubmitted: (value) {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              obscureText: LoginCubit.get(context).isPassword,
                              decoration: InputDecoration(
                                label: const Text('Password'),
          
                                prefixIcon: const Icon(Icons.lock),
                                suffix: InkWell(
                                    onTap: () {
                                      LoginCubit.get(context)
                                          .changePasswordVisibilty();
                                    },
                                    child: LoginCubit.get(context).suffix),
                                // IconButton(
                                //   onPressed: (){
          
                                //   },
                                //   icon:
                                //   ),
          
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            ConditionalBuilder(
                              // condition: state is! ShopLoginLoadingState,
                              condition: state is! SocialLoginLoadingState,
                              builder: (context) => Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      LoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                          
                                    }
                                  },
                                  child: const Text(
                                    'LOGIN',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                ),
                              ),
                              fallback: (context) =>
                                  const Center(child: CircularProgressIndicator()),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Don\'t have an account ?',
                                  style: TextStyle(fontWeight: FontWeight.w400),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) =>
                                            RegisterScreen()));
                                  },
                                  child: const Text('Register now'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
        },
        
      ),
    );
  }
}
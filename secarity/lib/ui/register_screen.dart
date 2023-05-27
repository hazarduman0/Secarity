import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:secarity/constants/app_colors.dart';
import 'package:secarity/constants/app_strings.dart';
import 'package:secarity/repository/auth_repository.dart';
import 'package:secarity/providers/route_controller_provider.dart';
import 'package:secarity/ui/widget/input_widget.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {

  final TextEditingController _deviceController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordCheckController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(child: Scaffold(
      body: Stack(
          children: [
            CustomPaint(
              painter: CustomShapePaint(),
              child: Container(),
            ),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: SizedBox(
                height: size.height,
                width: size.width,
                child: Column(
                  children: [
                    const Spacer(flex: 1),
                    SizedBox(
                      height: size.shortestSide * 1.6,
                      width: size.shortestSide * 0.9,
                      child: Card(
                        child: Column(
                          children: [
                            Container(
                              height: size.shortestSide * 0.18,
                              width: size.shortestSide,
                              decoration: BoxDecoration(
                                color: AppColors.appBlue,
                                borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(
                                          size.shortestSide * 0.03))
                              ),
                              
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.shortestSide * 0.1),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: AutoSizeText(AppString.welcomeToSecarity,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium)),
                              ),
                            ),
                            InputArea(
                                text: AppString.deviceID,
                                controller: _deviceController,
                                isPassword: false),
                            InputArea(
                                text: AppString.username,
                                controller: _emailController,
                                isPassword: false),
                            InputArea(
                                text: AppString.password,
                                controller: _passwordController,
                                isPassword: true),
                            InputArea(
                                text: AppString.passwordAgain,
                                controller: _passwordCheckController,
                                isPassword: true),    
                            Expanded(
                                child: Consumer(
                              builder: (context, ref, child) => GestureDetector(
                                  onTap: () async{
                                    if (_passwordController.text !=
                                _passwordCheckController.text) {
                              Fluttertoast.showToast(
                                  msg: AppString.passwordNotMatch,
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: size.shortestSide * 0.04);
                              return;
                            }
                            var statusCode = await ref
                                .read(authRepositoryProvider)
                                .register(
                                    _deviceController.text,
                                    _emailController.text,
                                    _passwordController.text);

                            if (statusCode == 200) {
                              ref
                                  .read(routeControllerProvider.notifier)
                                  .routeLogin();
                              Fluttertoast.showToast(
                                  msg: AppString.registerSucces,
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  //timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: size.shortestSide * 0.04);
                              return;
                            } else if (statusCode == 400) {
                              Fluttertoast.showToast(
                                  msg: AppString.nameAlreadyTaken,
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  //timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: size.shortestSide * 0.04);
                              return;
                            } else if (statusCode == 500) {
                              Fluttertoast.showToast(
                                  msg: AppString.noSuchDevice,
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  //timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: size.shortestSide * 0.04);
                              return;
                            }
                                  },
                                  child: SizedBox(
                                      child: Center(
                                    child: AutoSizeText(AppString.register,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall),
                                  ))),
                            ))
                          ],
                        ),
                      ),
                    ),
                    const Spacer(flex: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AutoSizeText('Has any account?',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: size.shortestSide * 0.04)),
                        TextButton(
                            onPressed: () {
                              ref
                                  .read(routeControllerProvider.notifier)
                                  .routeLogin();
                            },
                            child: AutoSizeText('Login',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: AppColors.appBlue,
                                        fontSize: size.shortestSide * 0.04))),
                      ],
                    ),
                    const Spacer(flex: 3),
                  ],
                ),
              ),
            ),
          ],
        ),
    ));
  }
}
class CustomShapePaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = AppColors.loginCustomShapeColor;
    paint.style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(0, size.height * 0.4);
    path.lineTo(size.width, size.height * 0.6);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, size.height * 0.4);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}


//////////////////////////////////////////////////////////////////

// InputDecoration inputDecoration(
//         Size size, String? hintText, BuildContext context) =>
//     InputDecoration(
//         hintText: hintText,
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(
//               color: Colors.indigo, width: size.shortestSide * 0.005),
//           borderRadius: BorderRadius.circular(size.shortestSide * 0.03),
//         ),
//         border: OutlineInputBorder(
//           borderSide: BorderSide.none,
//           borderRadius: BorderRadius.circular(size.shortestSide * 0.03),
//         ),
//         filled: true,
//         fillColor: const Color.fromARGB(255, 238, 235, 235),
//         hintStyle: Theme.of(context)
//             .textTheme
//             .headlineMedium!
//             .copyWith(fontSize: size.shortestSide * 0.045));


////////////////////////////////////////////////////////////////////

    //         SafeArea(
    //   child: Scaffold(
    //     appBar: AppBar(
    //         elevation: 0.0,
    //         backgroundColor: Colors.transparent,
    //         leading: Padding(
    //           padding:
    //               EdgeInsets.symmetric(horizontal: size.shortestSide * 0.03),
    //           child: IconButton(
    //               onPressed: () {
    //                 ref.read(routeControllerProvider.notifier).routeLogin();
    //               },
    //               icon: const Icon(Icons.arrow_back_ios_rounded,
    //                   color: Colors.black)),
    //         )),
    //     body: SingleChildScrollView(
    //       physics: const BouncingScrollPhysics(
    //           parent: AlwaysScrollableScrollPhysics()),
    //       child: Padding(
    //         padding: EdgeInsets.symmetric(
    //             horizontal: size.shortestSide * 0.1,
    //             vertical: size.shortestSide * 0.07),
    //         child: Form(
    //           key: _formGlobalKey,
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               AutoSizeText(
    //                 'Welcome to Secarity',
    //                 style: Theme.of(context)
    //                     .textTheme
    //                     .displaySmall!
    //                     .copyWith(fontSize: size.shortestSide * 0.04),
    //               ),
    //               SizedBox(height: size.shortestSide * 0.04),
    //               AutoSizeText(
    //                 'Register',
    //                 style: Theme.of(context)
    //                     .textTheme
    //                     .labelMedium!
    //                     .copyWith(fontSize: size.shortestSide * 0.1),
    //               ),
    //               SizedBox(height: size.shortestSide * 0.08),
    //               TextFormField(
    //                 controller: _deviceController,
    //                 validator: (value) {
    //                   if (value == null || value.isEmpty) {
    //                     return 'This field is required.';
    //                   }
    //                 },
    //                 cursorColor: Colors.indigo,
    //                 cursorHeight: size.shortestSide * 0.07,
    //                 //obscureText: true,
    //                 keyboardType: TextInputType.text,
    //                 style: Theme.of(context)
    //                     .textTheme
    //                     .headlineSmall!
    //                     .copyWith(fontSize: size.shortestSide * 0.05),
    //                 decoration: inputDecoration(size, 'Device ID', context),
    //               ),
    //               SizedBox(height: size.shortestSide * 0.07),
    //               TextFormField(
    //                 controller: _emailController,
    //                 validator: (value) {
    //                   if (value == null || value.isEmpty) {
    //                     return 'This field is required.';
    //                   } else if (!RegExp(
    //                           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
    //                       .hasMatch(value)) {
    //                     return 'This field must be in email format.';
    //                   }
    //                 },
    //                 cursorColor: Colors.indigo,
    //                 cursorHeight: size.shortestSide * 0.07,
    //                 //obscureText: true,
    //                 keyboardType: TextInputType.emailAddress,
    //                 style: Theme.of(context)
    //                     .textTheme
    //                     .headlineSmall!
    //                     .copyWith(fontSize: size.shortestSide * 0.05),
    //                 decoration: inputDecoration(size, 'Email', context),
    //               ),
    //               SizedBox(height: size.shortestSide * 0.07),
    //               TextFormField(
    //                 controller: _passwordController,
    //                 validator: (value) {
    //                   if (value == null || value.isEmpty) {
    //                     return 'This field is required.';
    //                   } else if (value.length < 8) {
    //                     return 'This field must be at least 8 characters long.';
    //                   }
    //                 },
    //                 cursorColor: Colors.indigo,
    //                 cursorHeight: size.shortestSide * 0.07,
    //                 obscureText: true,
    //                 keyboardType: TextInputType.visiblePassword,
    //                 style: Theme.of(context)
    //                     .textTheme
    //                     .headlineSmall!
    //                     .copyWith(fontSize: size.shortestSide * 0.05),
    //                 decoration: inputDecoration(size, 'Password', context),
    //               ),
    //               SizedBox(height: size.shortestSide * 0.07),
    //               TextFormField(
    //                 controller: _passwordCheckController,
    //                 validator: (value) {
    //                   if (value == null || value.isEmpty) {
    //                     return 'This field is required.';
    //                   } else if (value.length < 8) {
    //                     return 'This field must be at least 8 characters long.';
    //                   }
    //                 },
    //                 cursorColor: Colors.indigo,
    //                 cursorHeight: size.shortestSide * 0.07,
    //                 obscureText: true,
    //                 keyboardType: TextInputType.visiblePassword,
    //                 style: Theme.of(context)
    //                     .textTheme
    //                     .headlineSmall!
    //                     .copyWith(fontSize: size.shortestSide * 0.05),
    //                 decoration:
    //                     inputDecoration(size, 'Password Again', context),
    //               ),
    //               SizedBox(height: size.shortestSide * 0.1),
    //               SizedBox(
    //                 height: size.shortestSide * 0.14,
    //                 width: size.shortestSide * 0.8,
    //                 child: ElevatedButton(
    //                     onPressed: () async {
    //                       if (_formGlobalKey.currentState!.validate()) {
    //                         // use the information provided
    //                         if (_passwordController.text !=
    //                             _passwordCheckController.text) {
    //                           Fluttertoast.showToast(
    //                               msg: "Passwords do not match",
    //                               toastLength: Toast.LENGTH_LONG,
    //                               gravity: ToastGravity.BOTTOM,
    //                               //timeInSecForIosWeb: 1,
    //                               backgroundColor: Colors.red,
    //                               textColor: Colors.white,
    //                               fontSize: size.shortestSide * 0.04);
    //                           return;
    //                         }

    //                         var statusCode = await ref
    //                             .read(authRepositoryProvider)
    //                             .register(
    //                                 _deviceController.text,
    //                                 _emailController.text,
    //                                 _passwordController.text);

    //                         if (statusCode == 200) {
    //                           ref
    //                               .read(routeControllerProvider.notifier)
    //                               .routeLogin();
    //                           Fluttertoast.showToast(
    //                               msg: "Register success.",
    //                               toastLength: Toast.LENGTH_LONG,
    //                               gravity: ToastGravity.BOTTOM,
    //                               //timeInSecForIosWeb: 1,
    //                               backgroundColor: Colors.green,
    //                               textColor: Colors.white,
    //                               fontSize: size.shortestSide * 0.04);
    //                           return;
    //                         } else if (statusCode == 400) {
    //                           Fluttertoast.showToast(
    //                               msg: "Name is already taken.",
    //                               toastLength: Toast.LENGTH_LONG,
    //                               gravity: ToastGravity.BOTTOM,
    //                               //timeInSecForIosWeb: 1,
    //                               backgroundColor: Colors.red,
    //                               textColor: Colors.white,
    //                               fontSize: size.shortestSide * 0.04);
    //                           return;
    //                         } else if (statusCode == 500) {
    //                           Fluttertoast.showToast(
    //                               msg: "There is no such a device.",
    //                               toastLength: Toast.LENGTH_LONG,
    //                               gravity: ToastGravity.BOTTOM,
    //                               //timeInSecForIosWeb: 1,
    //                               backgroundColor: Colors.red,
    //                               textColor: Colors.white,
    //                               fontSize: size.shortestSide * 0.04);
    //                           return;
    //                         }
    //                       }
    //                     },
    //                     child: AutoSizeText(
    //                       'Register',
    //                       style: TextStyle(
    //                           fontSize: size.shortestSide * 0.06,
    //                           fontWeight: FontWeight.bold),
    //                     )),
    //               ),
    //               SizedBox(height: size.shortestSide * 0.05),
    //               Align(
    //                 alignment: Alignment.center,
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     AutoSizeText('Has any account?',
    //                         style: Theme.of(context)
    //                             .textTheme
    //                             .bodyMedium!
    //                             .copyWith(fontSize: size.shortestSide * 0.04)),
    //                     TextButton(
    //                         onPressed: () {
    //                           ref
    //                               .read(routeControllerProvider.notifier)
    //                               .routeLogin();
    //                         },
    //                         child: AutoSizeText('Login here',
    //                             style: Theme.of(context)
    //                                 .textTheme
    //                                 .bodyMedium!
    //                                 .copyWith(
    //                                     color: Colors.indigo,
    //                                     fontSize: size.shortestSide * 0.04)))
    //                   ],
    //                 ),
    //               )
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
import 'package:alumnest/src/auth/screens/login_screen.dart';
import 'package:alumnest/src/auth/screens/signup_screen.dart';
import 'package:alumnest/src/home/screens/profile_screen.dart';

final routeMap = {
  LoginScreen.routeName: (ctx) => const LoginScreen(),
  SignUpScreen.routeName: (ctx) => const SignUpScreen(),
  ProfileScreen.routeName: (ctx) => const ProfileScreen(),
};

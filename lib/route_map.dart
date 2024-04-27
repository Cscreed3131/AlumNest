import 'package:alumnest/src/auth/screens/login_screen.dart';
import 'package:alumnest/src/auth/screens/signup_screen.dart';
import 'package:alumnest/src/home/screens/home_screen.dart';
import 'package:alumnest/src/home/screens/profile_screen.dart';

final routeMap = {
  LoginScreen.routeName: (ctx) => const LoginScreen(),
  SignUpScreen.routeName: (ctx) => const SignUpScreen(),
  HomeScreen.routeName: (ctx) => const HomeScreen(),
  ProfileScreen.routeName: (ctx) => const ProfileScreen(),
};

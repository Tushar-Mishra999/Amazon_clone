import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:amazon_clone/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common/widgets/bottom_bar.dart';
import 'features/admin/screens/admin_screen.dart';
import 'features/auth/services/auth_service.dart';

void main() {
  runApp(
    MultiProvider(
    providers:[
      ChangeNotifierProvider(create: (context)=>UserProvider()),
    ],child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

 final AuthService authService = AuthService();
 final _messangerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AMAZON',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: GlobalVariables.backgroundColor,
        appBarTheme: const AppBarTheme(elevation: 0,iconTheme: IconThemeData(color: Colors.black)),
        colorScheme:const ColorScheme.light(primary: GlobalVariables.secondaryColor),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      //  home: Provider.of<UserProvider>(context).user.token.isNotEmpty?
      //  Provider.of<UserProvider>(context).user.type=='user'?const BottomBar():const AdminScreen()
      // :const AuthScreen(),
      home: const AuthScreen(),

    );
  }
}

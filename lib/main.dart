import 'package:fff/basic_concepts/BottomSheetClass.dart';
import 'package:fff/chat_firestore/ChatScreen.dart';
import 'package:fff/common/ViewModelClass.dart';
import 'package:fff/demoAPI/postApiTokenAuth/loginPage.dart';
import 'package:fff/demoAPI/repo_list_module/repoUI.dart';
import 'package:fff/demoAPI/repo_list_module/repoViewModel.dart';
import 'package:fff/demoAPI/users_list_module/UserViewModel.dart';
import 'package:fff/local/database.dart';
import 'package:fff/login_module/UserProfile.dart';
import 'package:fff/login_module/auth_service.dart';
import 'package:fff/login_module/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'basic_concepts/animation_classes.dart';
import 'basic_concepts/image_picker.dart';
import 'demoAPI/users_list_module/UserList.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final database = AppDatabase.getInstance();
  final authService = AuthService(database);
  // bool isLoggedIn = await authService.isLoggedIn();

  runApp(MyApp(authService));
}

class MyApp extends StatelessWidget {
  final AuthService authService;
  const MyApp(this.authService, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers:
      [
        ChangeNotifierProvider(create: (context) => RepoViewModel()),
        ChangeNotifierProvider(create: (context) => UserViewModel()),
        ChangeNotifierProvider(create: (context) => ViewModelClass()),
      ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: const isLoggedIn ? RepoListClass() : LoginPage(),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginPage(authService: authService),
        '/animation': (context) => AnimationOne(),
        '/image':(context) => ImagePic(),
        '/repo' : (context) => RepoListClass(authService: authService,),
        '/users' : (context) => UserListClass(),
        '/chat' : (context) => ChatScreen(),
        '/loginPost' : (context) => Login(),
        '/bottomsSheet' : (context) => BottomSheetClass(),
        '/userProfile' : (context) => Userprofile(),
      },
    ),);
  }
}


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService _authService = AuthService(AppDatabase.getInstance());

  @override
  void initState() {
    _checkLoginStatus();
    super.initState();
  }

  Future<void> _checkLoginStatus() async{
    bool isLoggedIn = await _authService.isLoggedIn();
    await Future.delayed(Duration(seconds: 2));
    if (!mounted) return;
    if(isLoggedIn){
      Navigator.pushReplacementNamed(context, '/repo');
    }else{
      Navigator.pushReplacementNamed(context, '/login');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.yellow,padding: EdgeInsets.all(20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
        children: [SizedBox(width: 100,height: 100,
            child: FittedBox(fit: BoxFit.fill,child: Icon(Icons.local_activity_rounded,color: Colors.black)))],));
  }
}

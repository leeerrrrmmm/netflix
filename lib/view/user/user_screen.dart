import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix/components/build_text.dart';
import 'package:netflix/components/curved_smile.dart';
import 'package:netflix/data/data_source/user_data_source.dart';
import 'package:netflix/data/repo_impl/user_repo_impl.dart';
import 'package:netflix/data/services/auth_service.dart';
import 'package:netflix/domain/entity/user_entity.dart';
import 'package:netflix/domain/use_cases/user_use_cases.dart';
import 'package:netflix/view/bottom/custom_bottom_nav_bar.dart';
import 'package:netflix/view/provider/user_provider.dart';
import 'package:netflix/view/sign_up/sign_up.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final Random _random = Random();
  List<Color> userColors = [];
  late final GetUserByUidUseCase getUserByUidUseCase;
  UserEntity? userEntity;
  bool isLoading = true;
  final UserRemoteDataSource userRemoteDataSource = UserRemoteDataSource(
    FirebaseFirestore.instance,
  );
  List<UserEntity?> users = [];

  @override
  void initState() {
    super.initState();
    getUserByUidUseCase = GetUserByUidUseCase(
      userRepoImpl: UserRepoImpl(
        firebaseFirestore: FirebaseFirestore.instance,
        userRemoteDataSource: userRemoteDataSource,
      ),
    );
    _fetchUsersByDeviceId();
    userColors = List.generate(users.length, (_) => _getRandomColor());
  }

  Future<void> loginWithCredential(String email, String password) async {
    try {
      final AuthService authService = AuthService();

      await authService.loginWithEmailAndPassword(email, password);

      final user = authService.getCurUser();

      if (!mounted) return;

      if (user != null) {
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (context) => CustomBottomNavBar()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Align(
              alignment: Alignment.center,
              child: Text("Login was failed"),
            ),
          ),
        );
      }
    } catch (e) {
      throw Exception('Login was failed: $e');
    }
  }

  Future<void> _fetchUsersByDeviceId() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final user = await getUserByUidUseCase.getUserByUid(currentUser.uid);
      final deviceId = user!.deviceId;

      final fetchedUsers = await getUserByUidUseCase.fetchUsersByDeviceId(
        deviceId,
      );

      setState(() {
        users = fetchedUsers;
        userColors = List.generate(users.length, (_) => _getRandomColor());
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
        users = [];
      });
    }
  }

  Color _getRandomColor() {
    return Color.fromARGB(
      255,
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/logo.png'),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: реализовать логику редактирования
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                children: [
                  // Градиентные полоски по бокам
                  _buildGradientLine(screenWidth, isLeft: true),
                  _buildGradientLine(screenWidth, isLeft: false),

                  // Сетка профилей
                  users.isEmpty && isLoading == false
                      ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration: const Duration(
                                      milliseconds: 700,
                                    ),
                                    pageBuilder: (_, __, ___) => const SignUp(),
                                    transitionsBuilder: (
                                      _,
                                      animation,
                                      __,
                                      child,
                                    ) {
                                      return SlideTransition(
                                        position: Tween<Offset>(
                                          begin: const Offset(0.0, 1.0),
                                          end: Offset.zero,
                                        ).animate(
                                          CurvedAnimation(
                                            parent: animation,
                                            curve: Curves.easeInOut,
                                          ),
                                        ),
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 25,
                                child: Icon(Icons.add, color: Colors.black),
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text('Add Profile'),
                          ],
                        ),
                      )
                      : Padding(
                        padding: const EdgeInsets.only(
                          top: 130.0,
                          left: 75,
                          right: 75,
                        ),
                        child: GridView.builder(
                          itemCount: users.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 25,
                                mainAxisSpacing: 25,
                              ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                final selectedUser = users[index];
                                if (selectedUser != null) {
                                  Provider.of<CurrentUserProvider>(
                                    context,
                                    listen: false,
                                  ).setUser(selectedUser);

                                  Navigator.pushReplacement(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (_) => CustomBottomNavBar(),
                                    ),
                                  );
                                }
                              },
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: userColors[index],
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    height: 110,
                                    width: double.infinity,
                                    child: Stack(
                                      children: const [
                                        Positioned(
                                          top: 30,
                                          left: 20,
                                          child: CircleAvatar(
                                            radius: 8,
                                            backgroundColor: Colors.white,
                                          ),
                                        ),
                                        Positioned(
                                          top: 30,
                                          right: 20,
                                          child: CircleAvatar(
                                            radius: 8,
                                            backgroundColor: Colors.white,
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 30,
                                          right: 6,
                                          child: CurvedSmile(
                                            width: 90,
                                            height: 20,
                                            strokeWidth: 8,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  BuildText(
                                    text: users[index]!.name,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),

                  // Кнопка добавления профиля
                  Positioned(
                    bottom: 80,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => SignUp(),
                              ),
                            );
                          },
                          child:
                              users.isEmpty
                                  ? null
                                  : CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 25,
                                    child: Icon(Icons.add, color: Colors.black),
                                  ),
                        ),
                        const SizedBox(height: 12),
                        const Text('Add Profile'),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }

  Widget _buildGradientLine(double screenWidth, {required bool isLeft}) {
    return Positioned(
      top: 0,
      bottom: 0,
      left: isLeft ? screenWidth / 1.5 : null,
      right: isLeft ? null : screenWidth / 1.5,
      child: SizedBox(
        width: 100,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.red.withValues(alpha: 0.04)],
            ),
          ),
        ),
      ),
    );
  }
}

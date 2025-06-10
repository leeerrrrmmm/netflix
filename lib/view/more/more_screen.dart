import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:netflix/components/build_text_widget.dart';
import 'package:netflix/components/curved_smile.dart';
import 'package:netflix/data/data_source/user_data_source.dart';
import 'package:netflix/data/repo_impl/user_repo_impl.dart';
import 'package:netflix/domain/entity/user_entity.dart';
import 'package:netflix/domain/use_cases/user_use_cases.dart';
import 'package:netflix/view/provider/user_provider.dart';
import 'package:provider/provider.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  final Random _random = Random();

  Color getRandomColor() {
    return Color.fromARGB(
      255,
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
    );
  }

  User? currentUser = FirebaseAuth.instance.currentUser;

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
  }

  Future<void> _fetchUsersByDeviceId() async {
    if (currentUser != null) {
      final user = await getUserByUidUseCase.getUserByUid(currentUser!.uid);
      final deviceId = user!.deviceId;

      final fetchedUsers = await getUserByUidUseCase.fetchUsersByDeviceId(
        deviceId,
      );

      setState(() {
        users = fetchedUsers;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
        users = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<CurrentUserProvider>(context).user;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              height: 117,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final usersOnThisDevice = users[index];
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width:
                              currentUser!.uid == usersOnThisDevice!.uid
                                  ? 90
                                  : 78,
                          height:
                              currentUser.uid == usersOnThisDevice.uid
                                  ? 90
                                  : 78,
                          decoration: BoxDecoration(
                            color: getRandomColor(),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 10,
                                left: 10,
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 10,
                                right: 20,
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                left: 10,
                                child: CurvedSmile(
                                  width: 80,
                                  height: 10,
                                  strokeWidth: 6,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      TextBuild(
                        text: usersOnThisDevice.name,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ],
                  );
                },
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.edit, color: Colors.white),
                  TextBuild(
                    text: 'Manage Profile',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(color: Color(0xff1a1a1a)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 19),
                    Row(
                      children: <Widget>[
                        Icon(Icons.message_outlined, color: Colors.white),
                        SizedBox(width: 8),
                        TextBuild(
                          text: 'Tell friends about Netflix',
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    const SizedBox(height: 19),
                    TextBuild(
                      text:
                          'Spread the word and share the fun—tell your friends about Netflix and enjoy endless movies, series, and exclusive shows together.',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 11),
                    TextBuild(
                      text: 'Term & Conditions',
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 11),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 248,
                          height: 38,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // TODO: Реализовать копирование ссылки
                          },
                          child: Container(
                            width: 100,
                            height: 38,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Center(
                              child: Text(
                                'Copy Link',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 11),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildImgButton('assets/images/sup.png'),
                        _buildDivider(),
                        _buildImgButton('assets/images/book.png'),
                        _buildDivider(),
                        _buildImgButton('assets/images/google.png'),
                        _buildDivider(),
                        GestureDetector(
                          child: Column(
                            children: [
                              Icon(
                                Icons.more_horiz_outlined,
                                color: Colors.white,
                              ),
                              TextBuild(
                                text: 'More',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            _buildTextButton(() {}, 'My List'),
            const Divider(color: Color(0xff424242)),
            _buildTextButton(() {}, 'App Settings'),
            _buildTextButton(() {}, 'Account'),
            _buildTextButton(() {}, 'Help'),
            _buildTextButton(() {}, 'Sign Out'),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(height: 41, width: 1, color: Color(0xff8c8787));
  }

  TextButton _buildTextButton(void Function()? onTap, String text) {
    return TextButton(
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          if (text == 'My List') Icon(Icons.edit, color: Colors.white),
          TextBuild(
            text: text,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  GestureDetector _buildImgButton(String imgPath) {
    return GestureDetector(onTap: () {}, child: Image.asset(imgPath));
  }
}

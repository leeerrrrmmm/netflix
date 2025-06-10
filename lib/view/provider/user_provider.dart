import 'package:flutter/material.dart';
import 'package:netflix/domain/entity/user_entity.dart';

class CurrentUserProvider extends ChangeNotifier {
  UserEntity? _user;

  UserEntity? get user => _user;

  void setUser(UserEntity user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}

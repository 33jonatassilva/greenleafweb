import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserService extends ChangeNotifier {
  User _currentUser = User(
    name: 'Jamilson',
    city: 'São Paulo',
    state: 'Brazil',
    email: 'jamilson@example.com',
    phone: '(11) 98765-4321',
    address: 'Rua Exemplo, 123',
  );

  // Alterado de 'user' para 'currentUser' para manter consistência
  User get currentUser => _currentUser;

  void updateUser(User newUser) {
    _currentUser = newUser;
    notifyListeners();
  }
}
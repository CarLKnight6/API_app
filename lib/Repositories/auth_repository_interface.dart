import '../model/models.dart';

abstract class AuthRepositoryInterface {
  Future<List<Logindetails>?> LoginOfuser(String email, password);
  Future<List<Registerdetails>?> RegisterOfuser(
      String name, email, password, passwordConfirmation);
}

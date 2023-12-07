import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fullstackwithflutter_ui/models/users.dart';
import 'package:fullstackwithflutter_ui/repositories/user_repository.dart';

final UserRepositoryProvider =
    Provider<IUserRepository>((ref) => UserRepository());

final usersList = FutureProvider.autoDispose<UserListResponse>((ref) {
  final repository = ref.watch(UserRepositoryProvider);
  return repository.fetchUsersList();
});

class UserFormNotifier extends ChangeNotifier {
  UserFormNotifier(this.ref) : super();
  final Ref ref;

  Future<UserResponse> onSubmitUser(User user) async {
    final repository = ref.read(UserRepositoryProvider);
    late UserResponse resp;

    if (user.id == 0) {
      resp = await repository.createNewUser(user);
    } else {}
    return resp;
  }
}

final userFormProvider =
    ChangeNotifierProvider.autoDispose<UserFormNotifier>((ref) {
  return UserFormNotifier(ref);
});

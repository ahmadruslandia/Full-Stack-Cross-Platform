import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fullstackwithflutter_ui/models/users.dart';
import 'package:fullstackwithflutter_ui/repositories/user_repository.dart';

final UserRepositoryProvider =
    Provider<IUserRepository>((ref) => UserRepository());

final usersList = FutureProvider.autoDispose<UserListResponse>((ref) async {
  final repository = ref.watch(UserRepositoryProvider);
  return repository.fetchUserList();
});

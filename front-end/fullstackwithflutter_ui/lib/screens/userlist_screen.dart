import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fullstackwithflutter_ui/models/users.dart';
import 'package:fullstackwithflutter_ui/providers/user_provider.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("USER LIST"),
      ),
      body: Center(
        child: Column(children: const [Text("test"), UsersListView()]),
      ),
    ));
  }
}

class UsersListView extends ConsumerWidget {
  const UsersListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lstUsers = ref.watch(usersList);
    return lstUsers.when(
      data: (users) {
        return Expanded(
          child: ListView.builder(
              itemCount: users.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      title: Text(users.data[index].fullName),
                      subtitle: Text(users.data[index].mobileNumber.toString()),
                    ),
                  ),
                );
              }),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (err, stack) => Text('Error $err'),
    );
  }
}

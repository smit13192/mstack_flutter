import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mstack/logic/cubit/user_cubit/user_cubit.dart';
import 'package:mstack/presentation/screens/auth/login_support.dart';
import 'package:mstack/providers/user_like_question_provider.dart';
import 'package:provider/provider.dart';

class PrimaryDrawer extends StatelessWidget {
  const PrimaryDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserLoggedOutState) {
          Navigator.pushNamedAndRemoveUntil(
              context, LoginSupport.routeName, (route) => false);
        }
      },
      child: Drawer(
        child: Column(
          children: [
            Consumer<UserLikeQuestionProvider>(
              builder: (context, provider, child) {
                return UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(color: Colors.black87),
                  currentAccountPicture: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 40,
                    ),
                  ),
                  accountName: Text(provider.userModel.username!),
                  accountEmail: Text(provider.userModel.email!),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log out'),
              onTap: () {
                BlocProvider.of<UserCubit>(context).logOut();
              },
            )
          ],
        ),
      ),
    );
  }
}

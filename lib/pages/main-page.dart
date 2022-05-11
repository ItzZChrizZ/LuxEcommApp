// ignore_for_file: file_names, avoid_types_as_parameter_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:luxappv2/components/homepage/custom-botnavbar.dart';
import 'package:luxappv2/pages/account-page.dart';
import 'package:luxappv2/pages/home-page.dart';
import 'package:luxappv2/pages/loading-page.dart';
import 'package:luxappv2/pages/login-page.dart';
import 'package:luxappv2/pages/saved-page.dart';
import 'package:luxappv2/pages/search-page.dart';



class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late PageController _tabsPageController;
  int _selectedTab = 0;

  @override
  void initState() {
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GetBottomNavBar(
        selectedTab: _selectedTab,
        tabPressed: (num) {
          _tabsPageController.animateToPage(
            num,
            duration: const Duration(
              milliseconds: 300,
            ),
            curve: Curves.easeOutCubic,
          );
        },
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return PageView(
      controller: _tabsPageController,
      onPageChanged: (num) {
        setState(() {
          _selectedTab = num;
        });
      },
      children: [
        const HomePage(),
        const SearchPage(),
        const SavedPage(),
        StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, streamSnapshot) {
            if (streamSnapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text("Error: ${streamSnapshot.error}"),
                ),
              );
            }
            if (streamSnapshot.connectionState == ConnectionState.active) {
              User? _user = streamSnapshot.data as User?;

              if (_user == null) {
                return const LoginPage();
              } else {
                return const AccountPage();
              }
            }
            return const LoadingPage();
          },
        ),
      ],
    );
  }
}
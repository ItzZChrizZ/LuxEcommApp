// ignore_for_file: avoid_unnecessary_containers, file_names

import 'package:flutter/material.dart';
import 'package:luxappv2/components/widgets/custom-actionbar.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          const Center(
            child: Text("My Favorites"),
          ),
          Container(
            child:  const CustomActionBar(
              hasBackArrow: false,
              title: 'My Favorites',
            ),
          ),
        ],
      ),
    );
  }
}

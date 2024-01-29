import 'package:flutter/material.dart';

class AppbarComp extends StatelessWidget implements PreferredSizeWidget {

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 50,
      title: const Text('成分チェッカー'),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)
          )
      ),
    );
  }

  @override
  Size get preferredSize{
    return const Size(double.infinity, 60.0);
  }
}
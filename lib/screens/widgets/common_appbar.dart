
import 'package:flutter/material.dart';
import 'package:sms_app/styles.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {

  final String name;
  final IconButton iconButton;

   const CommonAppBar({
    Key? key,
    required this.name,
    required this.iconButton
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue[400],
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DefaultTextStyle(
            style: AppStyles.headerAppBarTextStyle,
            child: Text(name)
          ),
        ],
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        iconButton
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

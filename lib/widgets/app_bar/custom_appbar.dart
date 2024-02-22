import 'package:flutter/material.dart';
import 'package:verificationsystem/app_export.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key? key,
    this.height,
    required this.leadingIcon,
    required this.trailingIcon,
    required this.automaticallyImplyLeading,
    required this.title,
  }) : super(
          key: key,
        );

  final String title;

  final IconData leadingIcon;

  final IconData trailingIcon;

  bool automaticallyImplyLeading;

  final double? height;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: height ?? 56,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(leadingIcon),
            onPressed: () {
              AppRoutes.pushReplacement(context, AppRoutes.dashboardPageScreen);
            },
          ),
          Text(title),
          IconButton(
            icon: Icon(trailingIcon),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.userProfileScreen);
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

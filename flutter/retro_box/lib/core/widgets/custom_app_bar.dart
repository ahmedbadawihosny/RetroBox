import 'package:flutter/material.dart';
import 'package:retro_box/core/constants/app_colors.dart';

AppBar customAppBar(
    {String? barTitle,
    required IconData? barIcon,
    required void Function()? barFunc,
    List<Widget>? barAction}) {
  return AppBar(
    backgroundColor: AppColor.white,
    elevation: 0,
    centerTitle: true,
    title: Text(
      barTitle ?? '',
      style: TextStyle(
          color: AppColor.black, fontSize: 25, fontWeight: FontWeight.w500),
    ),
    leading: IconButton(
      icon: Icon(
        barIcon,
        color: AppColor.black,
        size: 25,
      ),
      onPressed: barFunc,
    ),
    actions: barAction ?? [],
  );
}

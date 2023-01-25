import 'package:flutter/material.dart';
import 'package:todo/utils/text_styles.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      title,
      style: AppTextStyle.bodyErrorText(context),
    ));
  }
}

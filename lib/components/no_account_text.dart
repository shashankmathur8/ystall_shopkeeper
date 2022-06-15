import 'package:flutter/material.dart';
import 'package:ystall_shopkeeper/screens/signin/sign_in_screen.dart';

import '../constants.dart';
import '../size_config.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "        Don’t have an account? \n Sign Up Now",
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
      ],
    );
  }
}

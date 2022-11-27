import 'package:amazon_clone/features/account/services/account_services.dart';
import 'package:flutter/material.dart';
import 'package:amazon_clone/features/account/widgets/account_button.dart';
class TopAdminButtons extends StatelessWidget {
  const TopAdminButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: 'Your Orders',
              onTap: () {},
            ),
           AccountButton(
              text: 'Log Out',
              onTap: () {
                AccountServices().logOut(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}

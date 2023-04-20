import 'package:flutter/material.dart';
import 'package:store_app/features/home/presentation/views/home_view/widgets/custom_app_bar.dart';
import 'package:store_app/features/home/presentation/views/home_view/widgets/home_body_list_view.dart';

class HomeBodyView extends StatelessWidget {
  const HomeBodyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(
          height: 12,
        ),
        CustomAppBar(),
        SizedBox(
          height: 5,
        ),
        Expanded(
          child: HomeBodyListView(),
        ),
      ],
    );
  }
}
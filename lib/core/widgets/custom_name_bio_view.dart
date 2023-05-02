import 'package:flutter/material.dart';
import 'package:store_app/core/utils/styles.dart';

class NameAndBio extends StatelessWidget {
  const NameAndBio({
    Key? key,
    required this.name,
    required this.email,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : super(key: key);

  final String name;
  final String email;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          name,
          style: Styles.textStyle24.copyWith(fontSize: 20),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          email,
          style: TextStyle(color: Colors.grey[600]),
        )
      ],
    );
  }
}

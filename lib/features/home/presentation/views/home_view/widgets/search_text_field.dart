import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/constants.dart';
import 'package:store_app/core/utils/app_assets.dart';
import 'package:store_app/features/home/presentation/view_models/search_cubit/search_cubit.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key? key,
    this.controller,
    required this.focusNode,
  }) : super(key: key);
  final TextEditingController? controller;
  final FocusNode focusNode;

// height: 50,
  // width: MediaQuery.of(context).size.width * 0.6,
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: TextField(
        onChanged: (value) {
          if(value.isNotEmpty) {
            BlocProvider.of<SearchCubit>(context).getSearch(value);
          }
        },
        controller: controller,
        focusNode: focusNode,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        autofocus: false,
        cursorColor: kMainColor,
        style: const TextStyle(color: kMainColor),
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: kMainColor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          hoverColor: kMainColor,
          hintText: "Search...",
          hintStyle: TextStyle(
            color: Colors.grey[500],
          ),
          prefixIcon: Image.asset(
            AppAssets.searchIcon,
            color: Colors.grey[400],
          ),
        ),
      ),
    );
  }
}

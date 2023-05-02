import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/constants.dart';
import 'package:store_app/features/home/data/models/search_model/datum.dart';
import 'package:store_app/features/home/presentation/view_models/search_cubit/search_cubit.dart';
import 'package:store_app/features/home/presentation/views/home_view/widgets/search_text_field.dart';

class AutocompleteExample extends StatelessWidget {
  const AutocompleteExample({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        SearchCubit cubit = BlocProvider.of(context);
        return Autocomplete<Datum>(
          optionsViewBuilder: (context, onSelected, options) {
            return OptionView(
              options: options,
              context: context,
              onSelected: onSelected,
            );
          },
          displayStringForOption: (option) => option.name!,
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<Datum>.empty();
            }
            if (state is SearchSuccess) {
              return state.searchModel.data!.data!;
            } else {
              return const Iterable<Datum>.empty();
            }
          },
          onSelected: (Datum selection) {
            /*_textEditingController.text = selection;*/

            /// TODO: Navigate to details
          },
          fieldViewBuilder: (BuildContext context,
              TextEditingController textEditingController,
              FocusNode focusNode,
              VoidCallback onFieldSubmitted) {
            return SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width * 0.6,
              child: Column(
                children: [
                  SearchTextField(
                    controller: textEditingController,
                    focusNode: focusNode,
                  ),
                  if (state is SearchLoading)
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: const LinearProgressIndicator(
                        color: kMainColor,
                        minHeight: 2.5,
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class OptionView extends StatelessWidget {
  const OptionView({
    Key? key,
    required this.context,
    required this.onSelected,
    required this.options,
  }) : super(key: key);
  final BuildContext context;
  final Function(Datum value) onSelected;
  final Iterable<Datum> options;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(
        end: 50,
        bottom: max(MediaQuery.of(context).size.height - 80 * options.length,
            MediaQuery.of(context).size.height - 80 * 5),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        elevation: 4.0,
        child: ListView.separated(
          padding: const EdgeInsetsDirectional.only(top: 8, end: 8),
          physics: const BouncingScrollPhysics(),
          itemCount: options.length,
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey[500],
          ),
          itemBuilder: (BuildContext context, int index) {
            final option = options.elementAt(index);
            return SizedBox(
              height: 70,
              child: ListTile(
                onTap: () => onSelected(option),
                leading: Image.network(option.image!
                    // 'https://student.valuxapps.com/storage/uploads/products/1615440322npwmU.71DVgBTdyLL._SL1500_.jpg'
                    ),
                title: Text(option.name!, textAlign: TextAlign.end),
              ),
            );
          },
        ),
      ),
    );
  }
}

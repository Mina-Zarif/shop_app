import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/layout/shopAppLayout/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/cubit.dart';

import '../../../models/categoriesModel/categoriesModel.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoriesModel? categoryModel = ShopCubit.get(context).categoriesModel;
    return ConditionalBuilder(
      condition: ShopCubit.get(context).categoriesModel != null,
      builder: (context) => Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                buildItem(categoryModel.data!.data[index]),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Container(
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            itemCount: categoryModel!.data!.data.length,
          ),
        ),
      ),
      fallback: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget buildItem(DataModel model) {
    return Row(
      children: [
        Image(
          image: NetworkImage(model.image!),
          fit: BoxFit.cover,
          height: 80,
          width: 80,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          model.name!.toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Spacer(),
        IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios_outlined)),
      ],
    );
  }
}

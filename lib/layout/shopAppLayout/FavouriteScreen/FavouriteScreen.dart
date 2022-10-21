import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shopAppLayout/cubit/cubit.dart';
import 'package:shop_app/shared/constants/Colors.dart';

import '../../../models/FavouriteModel/FavouriteModel.dart';
import '../../../shared/components/components.dart';
import '../cubit/states.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GetFavoriteModel? model = ShopCubit.get(context).favoriteModel;
    ShopCubit cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) => Container(
        color: Colors.white,
        child: ConditionalBuilder(
          condition: state is !ShopFavoritesAppLoadingGetData || model != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
                // scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => bulidFavItems(model!, context, index),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: cubit.favoriteModel!.data!.data.length),
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  Widget bulidFavItems(GetFavoriteModel model, context, index) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage('${model.data!.data[index].product!.image}'),
              width: 150,
              height: 150,
              // fit: BoxFit.cover,
            ),
            if (model.data!.data[index].product!.discount != 0)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                      backgroundColor: Colors.red),
                ),
              ),
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                model.data!.data[index].product!.name!,
                style: TextStyle(
                  height: 1.5,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    '${model.data!.data[index].product!.price!} EP',
                    style: TextStyle(
                      color: defultColor,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    width: 11,
                  ),
                  if (model.data!.data[index].product!.discount != 0)
                    Text(
                      '${model.data!.data[index].product!.oldPrice!} EP',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  IconButton(
                      onPressed: () {

                        ShopCubit.get(context).changeFavorites(
                          model.data!.data[index].product!.productId!
                        );
                      },
                      icon: Icon(
                        !ShopCubit.get(context).favorites[
                                model.data!.data[index].product!.productId]!
                            ? Icons.favorite_border
                            : Icons.favorite,
                        size: 17,
                        color: !ShopCubit.get(context).favorites[
                                model.data!.data[index].product!.productId]!
                            ? Colors.grey
                            : Colors.red,
                      )),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

///////////////////////////////////////////////////////////////////////////////

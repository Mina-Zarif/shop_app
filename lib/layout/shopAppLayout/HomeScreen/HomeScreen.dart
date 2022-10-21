import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shopAppLayout/cubit/cubit.dart';
import 'package:shop_app/layout/shopAppLayout/cubit/states.dart';
import 'package:shop_app/shared/constants/Colors.dart';
import '../../../models/HomeModel/Home_model.dart';
import '../../../models/categoriesModel/categoriesModel.dart';
import '../../../shared/components/components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ShopCubit cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopChangeFavoritesAppSeccessGetData) {
        if (!state.model.status!) {
          showToast(
            msg: state.model.message!,
            state: ToastStates.ERROR,
          );
        }
      }},
      builder: (context, state) => SafeArea(
        child: ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoriesModel != null,
          builder: (context) => productBuilder(
              cubit.homeModel!,
              cubit.categoriesModel!,
              context),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  Widget productBuilder(
          HomeModel homeModel, CategoriesModel categoriesModel, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                  items: homeModel.data!.banners
                      .map(
                        (e) => Image(
                          image: NetworkImage('${e.image}'),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    height: 250,
                    initialPage: 0,
                    viewportFraction: 1,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                  )),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Categories',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      // alignment: AlignmentDirectional.topStart,
                      height: 120,
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => bulidCategoriesItems(
                            categoriesModel.data!.data[index]),
                        separatorBuilder: (context, index) => SizedBox(
                          width: 15,
                        ),
                        itemCount: categoriesModel.data!.data.length,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'NEW PRODUCTS',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                color: Colors.grey[300],
                child: GridView.count(
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    childAspectRatio: 1 / 1.55,
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: List.generate(
                      homeModel.data!.products.length,
                      (index) => Container(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.bottomStart,
                              children: [
                                Image(
                                  image: NetworkImage(
                                      '${homeModel.data!.products[index].image}'),
                                  width: double.infinity,
                                  height: 200,
                                  // fit: BoxFit.cover,
                                ),
                                if (homeModel.data!.products[index].discount !=
                                    0)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
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
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    homeModel.data!.products[index].name
                                        .toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(height: 1.3),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${homeModel.data!.products[index].price.round()} EP',
                                        style: TextStyle(
                                            fontSize: 13, color: defultColor),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      if (homeModel
                                              .data!.products[index].discount !=
                                          0)
                                        Text(
                                          '${homeModel.data!.products[index].oldPrice.round()} EP',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                      Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            ShopCubit.get(context)
                                                .changeFavorites(
                                                    ShopCubit.get(context)
                                                        .homeModel!
                                                        .data!
                                                        .products[index]
                                                        .id!);
                                          },
                                          icon: Icon(
                                            !ShopCubit.get(context).favorites[
                                                    homeModel.data!
                                                        .products[index].id!]!
                                                ? Icons.favorite_border
                                                : Icons.favorite,
                                            size: 17,
                                            color: !ShopCubit.get(context)
                                                        .favorites[
                                                    homeModel.data!
                                                        .products[index].id!]!
                                                ? Colors.grey
                                                : Colors.red,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              )
            ],
          ),
        ),
      );

  Widget bulidGrideItems(ProductModel product) => Column(
        children: [
          Image(
            image: NetworkImage(product.image!),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ],
      );

  Widget bulidCategoriesItems(model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(model.image!),
            width: 100,
            height: 100,
          ),
          Container(
            color: Colors.black.withOpacity(0.8),
            width: 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                model.name!.toString().toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  // backgroundColor: Colors.black.withOpacity(0.7),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      );
}

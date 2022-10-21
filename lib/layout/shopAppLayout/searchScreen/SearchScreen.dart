import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app/layout/shopAppLayout/searchScreen/cubit/cubit.dart';
import 'package:shop_app/layout/shopAppLayout/searchScreen/cubit/status.dart';
import 'package:shop_app/shared/constants/Colors.dart';

import '../../../models/SearchModel/SearchModel.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
            // leading: Text(''),
            actions: [
              SizedBox(
                width: 330,
                child: TextFormField(
                  controller: SearchCubit.get(context).searchController,
                  cursorColor: defultColor,
                  onChanged: (value) {
                    SearchCubit.get(context).getSearchData(value);
                  },
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    hintText: ('Search....'),
                  ),
                ),
              ),
            ],
          ),
          body: ConditionalBuilder(
            condition: SearchCubit.get(context).searchModel != null,
            builder: (context) => Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => bulidFavItems(
                      SearchCubit.get(context).searchModel, context, index),
                  separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Container(
                      height: 1,
                      color: Colors.grey[300],
                    ),
                  ),
                  itemCount:
                      SearchCubit.get(context).searchModel!.data!.data.length,
                ),
              ),
            ),
            fallback: (context) {
              if (state is SearchAppLoadingGetData) {
                return LinearProgressIndicator();
              } else {
                return Center(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search,
                        size: 50,
                        color: Colors.grey,
                      ),
                      Text(
                        'Search',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold,color: Colors.grey),
                      )
                    ],
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}

Widget bulidFavItems(SearchModel? model, context, index) {
  return Row(
    // crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(
            image: NetworkImage('${model!.data!.data[index].image}'),
            width: 100,
            height: 100,
            // fit: BoxFit.cover,
          ),
          // if (model.data!.data[index].discount != 0||false)
          //   Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 5),
          //     child: Text(
          //       'DISCOUNT',
          //       style: TextStyle(
          //           fontSize: 11,
          //           color: Colors.white,
          //           backgroundColor: Colors.red),
          //     ),
          //   ),
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
              model.data!.data[index].name!,
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
                  '${model.data!.data[index].price!} EP',
                  style: TextStyle(
                    color: defultColor,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  width: 11,
                ),
                // if (model.data!.data[index].discount != 0)
                // Text(
                //   '${model.data!.data[index].oldPrice} EP',
                //   style: TextStyle(
                //     color: Colors.grey,
                //     fontSize: 13,
                //     decoration: TextDecoration.lineThrough,
                //   ),
                // ),
                // Spacer(),
                // IconButton(
                //     onPressed: () {
                //
                //       ShopCubit.get(context).changeFavorites(
                //           model.data!.data[index].productId!
                //       );
                //     },
                //     icon: Icon(
                //       !ShopCubit.get(context).favorites[
                //       model.data!.data[index].productId]!
                //           ? Icons.favorite_border
                //           : Icons.favorite,
                //       size: 17,
                //       color: !ShopCubit.get(context).favorites[
                //       model.data!.data[index].productId]!
                //           ? Colors.grey
                //           : Colors.red,
                //     )),
              ],
            )
          ],
        ),
      ),
    ],
  );
}

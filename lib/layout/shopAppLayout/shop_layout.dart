import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shopAppLayout/cubit/states.dart';
import 'package:shop_app/layout/shopAppLayout/searchScreen/SearchScreen.dart';
import 'cubit/cubit.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Shop App'),
            actions: [
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
              }, icon: Icon(Icons.search))
            ],
          ),

          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.apps_outlined) ,
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite) ,
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings) ,
                label: 'Settings',
              )
            ],
            currentIndex: cubit.currentIndex,
            onTap: (value) => cubit.changeIndex(value),

          ),

        );
      },
    );
  }
}

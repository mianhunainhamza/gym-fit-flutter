import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:softec_app_dev/view/Screens/Shopping/cart_page.dart';
import 'dart:convert';
import "package:velocity_x/velocity_x.dart";

import '../../../core/store.dart';
import '../../../model/cart.dart';
import '../../../model/catalog.dart';
import '../../../widgets/shopping_widgets/catalog_header.dart';
import '../../../widgets/shopping_widgets/catalog_list.dart';
import '../../../widgets/theme.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});

  @override
  State<ShoppingPage> createState() => ShoppingPageState();
}

class ShoppingPageState extends State<ShoppingPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(const Duration(seconds: 1));
    var catalogJson = await rootBundle.loadString("assets/files/catalog.json");
    var decodeData = jsonDecode(catalogJson);
    var productsData = decodeData["products"];
    setState(() {
      CatalogModel.items = List.from(productsData)
          .map<Item>((item) => Item.fromMap(item))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = (VxState.store as MyStore).cart;
    return Scaffold(
      appBar: AppBar(title:  const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text("Trending Products")),titleTextStyle: const TextStyle(fontWeight: FontWeight.w400,color: Colors.black,fontSize: 25),centerTitle: false,),
        floatingActionButton: VxBuilder(
            mutations: const {AddMutation, RemoveMutation},
            builder: (context, MyStore, none) {
              return FloatingActionButton(
                onPressed: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (c) => const CartPage()));
                },
                backgroundColor: MyTheme.darkBlusihColor,
                child: const Icon(
                  CupertinoIcons.cart,
                  color: Colors.white,
                ),
              ).badge(
                  size: 20,
                  count: cart.items.length,
                  color: (context.theme.colorScheme.primary),
                  textStyle: TextStyle(
                      color: (context.canvasColor),
                      fontSize: 12,
                      fontWeight: FontWeight.bold));
            }),
        backgroundColor: context.canvasColor,
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (CatalogModel.items.isNotEmpty)
                    const CatalogList().expand()
                  else
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          context.theme.colorScheme.secondary),
                    ).centered().expand(),
                ])));
  }
}

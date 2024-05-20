import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:softec_app_dev/utils/colors.dart';
import 'package:softec_app_dev/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../core/store.dart';
import '../../model/cart.dart';
import '../../model/catalog.dart';
import '../theme.dart';

class AddToCart extends StatelessWidget {
  final Item catalog;
   const AddToCart({
    super.key, required this.catalog,
  });
  @override
  Widget build(BuildContext context)
  {
    VxState.watch(context, on: [AddMutation,RemoveMutation]);
    final CartModel _cart= (VxState.store as MyStore).cart;
    bool isInCart= _cart.items.contains(catalog)??false;
    return ElevatedButton(
        onPressed: (){
          if(!isInCart)
          {
            AddMutation(catalog);
            Utils().showMessage(context,  "Item has been added", yellowDark);
          }
          else {
            Utils().showMessage(context,  "Item already added", yellowDark);
          }
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(MyTheme.darkBlusihColor),shape: MaterialStateProperty.all(const StadiumBorder())
        ),
        child: isInCart ? const Icon(Icons.done,color: Colors.black,): const Icon(CupertinoIcons.cart_badge_plus,color: Colors.black,));
  }
}
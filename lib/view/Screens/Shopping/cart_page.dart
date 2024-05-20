import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../core/store.dart';
import '../../../model/cart.dart';
import '../../../utils/colors.dart';
import '../../../utils/utils.dart';
import '../../../widgets/theme.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: context.canvasColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.canvasColor,
        title: "Cart".text.xl3.center.make().pOnly(top: 7),
      ),
      body: Column
        (
        children: [
          _CartList().p32().expand(),
          const Divider(),
          const _CardTotal(),
        ],
      ),
    );
  }
}
class _CardTotal extends StatelessWidget {
  const _CardTotal();

  @override
  Widget build(BuildContext context) {
    final CartModel cart = (VxState.store as MyStore).cart;
    VxState.watch(context, on: [RemoveMutation]);
    return  SizedBox(
      height: 200,
      child:cart.items.isEmpty ? " ".text.make(): Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          "Rs${cart.totalPrice}".text.color(context.theme.colorScheme.secondary).xl3.make(),
          30.widthBox,
          ElevatedButton(
              onPressed: (){
                Utils().showMessage(context,'Buying not supported yet',Colors.red);
              },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(MyTheme.darkBlusihColor),
            shape: MaterialStateProperty.all(const StadiumBorder())
          ), child: "Buy".text.xl2.black.fontWeight(FontWeight.w300).make(),).wh(90, 45)
        ],
      ),
    );
  }
}
class _CartList extends StatelessWidget {
  final CartModel _cart = (VxState.store as MyStore).cart;
  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [RemoveMutation]);

    return _cart.items.isEmpty ? "Nothing to Show here".text.xl.makeCentered(): ListView.builder(
        itemCount: _cart.items.length,
        itemBuilder: (context,index){
          return ListTile(
            leading: const Icon(Icons.done),
            trailing: IconButton(
              icon: const Icon(Icons.remove_circle_outline), onPressed: () {
              Utils().showMessage(context,'Item has been Removed',yellowDark);
                RemoveMutation(_cart.items[index]);
            },
            ),
            title: Text(_cart.items[index].name.toString()),
          );
        });
  }
}
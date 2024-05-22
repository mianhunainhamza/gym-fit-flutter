import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../model/catalog.dart';
import '../../../widgets/shopping_widgets/add_to_cart.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.catalog});
  final Item catalog;
  @override
  Widget build(BuildContext context) {
    timeDilation = 2;
    return Scaffold(
      bottomNavigationBar: Container(
        color: context.cardColor,
        child: ButtonBar(
          buttonPadding: EdgeInsets.zero,
          alignment: MainAxisAlignment.spaceBetween,
          children: [
            "Rs ${catalog.prices}".text.xl3.color(context.theme.colorScheme.secondary).bold.make(),
                AddToCart(catalog: catalog).wh(60, 50)
          ],
        ).pOnly(left: 30,right: 30,bottom: 10),
      ),
      appBar: AppBar(
        backgroundColor: context.canvasColor,
      ),
      backgroundColor: context.canvasColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Hero(
                    tag:Key(catalog.id.toString()),
                    child: Image.network(catalog.image))
                .h32(context),
            Expanded(
                  child: VxArc(
              height: 30,
              edge: VxEdge.top,
              arcType: VxArcType.convey,
              child: Container(
                  width: context.screenWidth,
                  color: context.cardColor,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        catalog.name.text.bold
                            .color(context.theme.colorScheme.secondary)
                            .xl4
                            .make(),
                        // catalog.desc.text.xl
                        //     .textStyle(context.captionStyle)
                        //     .make()
                        //     .py(5),
                            catalog.desc
                            .text.textStyle(context.captionStyle)
                            .make().p20(),
                        10.heightBox,
                      ],
                    ).py64(),
                  ),
              ),
            ),
                )
          ],
        ),
      ),
    );
  }
  // Duration get transitionDuration => const Duration(milliseconds: 10000);
}

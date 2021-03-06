import 'package:example/Consts/color_consts.dart';
import 'package:example/Consts/text_style_consts.dart';
import 'package:example/products_screen/Product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class ActionSheet extends StatelessWidget {
  final Product product;

  const ActionSheet(this.product, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AllColors.CardBackgroundColor,
      height: 204,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16,),
                  Text(
                    product.hintTitle,
                    style: AllTextStyles.AppBarTextStyle,
                  ),
                  SizedBox(height: 24,),
                  Container(
                    width: MediaQuery.of(context).size.width - 60,
                    child: Text(
                      product.hintDescription,
                      style: AllTextStyles.BottomSheetDescriptionTextStyle,
                    ),
                  )
                ],
              ),
              Spacer(),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: AllColors.QuestionBackgroundColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0)),
                ),
                child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.close,
                        color: AllColors.BottomNavBarSelectedItemColor,
                        size: 18,
                      ),
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
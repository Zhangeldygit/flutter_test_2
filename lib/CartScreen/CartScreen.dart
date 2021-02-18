import 'package:example/CartScreen/cart_bloc.dart';
import 'package:example/CategoryScreen/category_bloc/category_bloc.dart';
import 'package:example/ProductsScreen/Product_card.dart';
import 'package:example/ProductsScreen/Product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  // final Product product;

  const CartScreen({Key key, }) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double sum = 0;
  int totalCount;
  CartBloc cartBloc;

  refresh() {
    setState(() {});
  }

  @override
  void initState() {
    cartBloc = context.read<CartBloc>();

    _setValues(cartBloc.state);

    cartBloc.listen((state) {
      _setValues(state);
    });
    super.initState();
  }

  void _setValues(List<Product> state) {
    sum = state
        .map((e) => e.count * e.price)
        .reduce((value, element) => value + element);

    totalCount =
        state.map((e) => e.count).reduce((value, element) => value + element);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, List<Product>>(
      builder: (context, state) {
        if (state.isEmpty) {
          return Container();
        } else {
          return Column(
            children: [
              Container(
                width: double.maxFinite,
                height: 50,
                color: CupertinoColors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        'Корзина',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      padding: EdgeInsets.only(left: 170),
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Очистить',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      onTap: () {
                        cartBloc.add(ClearCart());
                      },
                    )
                  ],
                ),
              ),
              BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, categoryState) {
                return Expanded(
                  child: ListView.separated(
                      padding: EdgeInsets.only(top: 10, bottom: 20),
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: state.length,
                      itemBuilder: (context, index) {
                        return ProductCard(state[index], callBack: refresh);
                      }),
                );
              }),
              Container(
                padding: EdgeInsets.all(16),
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Общая сумма $sum тг',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('$totalCount вещи')
                        ],
                      ),
                    ),
                    Container(
                      width: 375,
                      child: CupertinoButton(
                        color: Colors.blue,
                        onPressed: () {
                          sum > 0 ? cartBloc.add(ConfirmCart()) : Offstage();
                        },
                        child: Text(
                          'Оформить',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        }
      },
    );
  }
}

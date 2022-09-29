import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:provider/provider.dart';
import 'package:animations/animations.dart';

import '../pages/details_page.dart';
import '../widgets/product_item.dart';
import '../providers/products_provider.dart';

class ProductsPage extends StatelessWidget {
  static const String routeName = '/products';
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: const Text('Produtos'),
      ),
      body: Consumer<ProductProvider>(builder: (context, provider, _) {
        var products = provider.products;
        return GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(10),
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: List.generate(
            products.length,
            (index) => OpenContainer(
              closedBuilder: (context, action) =>
                  ProductItem(product: products.elementAt(index), index: index),
              openBuilder: (context, action) {
                context.read<ProductProvider>().setSelectedProductIndex(index);
                return const ProductsDetails();
              },
            ),
          ),
        );
      }),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  DrawerHeader(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(FluentIcons.person_24_filled),
                        Text('Meu perfil')
                      ],
                    ),
                  ),
                  ListTile(
                    title: const Text('Meus produtos'),
                    leading: const Icon(FluentIcons.production_24_regular),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text('Configurações'),
                    leading: const Icon(FluentIcons.settings_24_filled),
                    onTap: () {},
                  ),
                ],
              ),
              ListTile(
                title: const Text('Logout'),
                leading: const Icon(FluentIcons.sign_out_24_filled),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

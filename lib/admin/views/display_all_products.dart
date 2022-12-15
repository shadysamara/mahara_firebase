import 'package:flutter/material.dart';
import 'package:mahara_fb/admin/providers/admin_provider.dart';
import 'package:mahara_fb/admin/views/add_new_product.dart';
import 'package:mahara_fb/app_router/app_router.dart';
import 'package:provider/provider.dart';

class AllProducts extends StatelessWidget {
  String catId;
  AllProducts(this.catId);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                AppRouter.navigateToScreen(AddNewProduct(catId));
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Consumer<AdminProvider>(
        builder: (context, provider, w) {
          return ListView.builder(
              itemCount: provider.products?.length ?? 0,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: double.infinity,
                  height: 200,
                  child:
                      Image.network(provider.products?[index].imageUrl ?? ''),
                );
              });
        },
      ),
    );
  }
}

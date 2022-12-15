import 'package:flutter/material.dart';
import 'package:mahara_fb/admin/models/category.dart';
import 'package:mahara_fb/admin/providers/admin_provider.dart';
import 'package:mahara_fb/admin/views/display_all_products.dart';
import 'package:mahara_fb/admin/views/updaete_category.dart';
import 'package:mahara_fb/app_router/app_router.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatelessWidget {
  Category category;
  CategoryWidget(this.category);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: () {
        Provider.of<AdminProvider>(context, listen: false)
            .getAllProducts(category.id!);
        AppRouter.navigateToScreen(AllProducts(category.id!));
      },
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.black, width: 2)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                      width: double.infinity,
                      height: 170,
                      child: Image.network(
                        category.image!,
                        fit: BoxFit.cover,
                      )),
                  Positioned(
                      right: 15,
                      top: 10,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: IconButton(
                                onPressed: () {
                                  Provider.of<AdminProvider>(context,
                                          listen: false)
                                      .deleteCategory(category);
                                },
                                icon: Icon(Icons.delete)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: IconButton(
                                onPressed: () {
                                  Provider.of<AdminProvider>(context,
                                          listen: false)
                                      .catNameController
                                      .text = category.name!;
                                  AppRouter.navigateToScreen(
                                      UpdateCategory(category));
                                },
                                icon: Icon(Icons.edit)),
                          ),
                        ],
                      ))
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(category.name!),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
/*
String names = ['omar','osama','ahmed']
1- print(names[1]);
2- print(names.where((e){
  return e == 'osama'
}));
*/
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mahara_fb/admin/providers/admin_provider.dart';
import 'package:mahara_fb/admin/views/display_all_products.dart';
import 'package:mahara_fb/app_router/app_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerMainPage extends StatelessWidget {
  Future<void> _launchUrl(url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launcWhatsapp() async {
    if (!await launchUrl(
        Uri.parse("tel:214324234"))) {
      throw 'Could not launch Whats app';
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          _launcWhatsapp();
        },
        child: Icon(Icons.whatsapp),
      ),
      appBar: AppBar(title: Text('Home Page')),
      body: Consumer<AdminProvider>(builder: (context, provider, w) {
        return Column(
          children: [
            provider.sliders == null
                ? SizedBox()
                : CarouselSlider(
                    options:
                        CarouselOptions(viewportFraction: 1, autoPlay: true),
                    items: provider.sliders!.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return InkWell(
                            onTap: () {
                              _launchUrl(i.url);
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(color: Colors.amber),
                                child: Image.network(
                                  i.imageUrl ?? '',
                                  fit: BoxFit.cover,
                                )),
                          );
                        },
                      );
                    }).toList(),
                  ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'All Categories',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                        child: GridView.builder(
                            itemCount: provider.categories!.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10),
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    provider.getAllProducts(
                                        provider.categories![index].id!);
                                    AppRouter.navigateToScreen(AllProducts(
                                        provider.categories![index].id!));
                                  },
                                  child: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Image.network(
                                        provider.categories![index].image!,
                                        fit: BoxFit.cover,
                                      )));
                            }))
                  ],
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}

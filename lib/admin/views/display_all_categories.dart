import 'package:flutter/material.dart';
import 'package:mahara_fb/admin/providers/admin_provider.dart';
import 'package:mahara_fb/admin/views/add_new_category.dart';
import 'package:mahara_fb/admin/views/category_widget.dart';
import 'package:mahara_fb/app_router/app_router.dart';
import 'package:mahara_fb/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class DisplayAllCategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: Drawer(
        child: Column(children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage(
                        Provider.of<AuthProvider>(context)
                            .loggedAppUser!
                            .imageUrl??'')),
            accountName: Text(Provider.of<AuthProvider>(context).loggedAppUser!.fname!), accountEmail: Text(
                    Provider.of<AuthProvider>(context).loggedAppUser!.email!))
        ,
          ListTile(
          trailing: Icon(Icons.arrow_forward_ios),
          leading: Icon(Icons.logout),
          title: Text(
 (Provider.of<AuthProvider>(context)
                            .loggedAppUser!.isAdmin!)?
                            'Your Are The Admin':
                            'You Are A customer'

          ),),
        ListTile(
          onTap: (){
            Provider.of<AuthProvider>(context,listen: false).signOut(); 
          },
          trailing: Icon(Icons.arrow_forward_ios),
          leading: Icon(Icons.logout),
          title: Text('LogOut'),)
        ],),
      ),
      appBar: AppBar(
        title: Text('All Catgegories'),
        actions: [
          IconButton(
              onPressed: () {
                AppRouter.navigateToScreen(AddNewCategory());
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Consumer<AdminProvider>(
        builder: (context, provider, child) {
          return provider.categories == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: provider.categories!.length,
                  itemBuilder: (context, index) {
                    return CategoryWidget(provider.categories![index]);
                  });
        },
      ),
    );
  }
}

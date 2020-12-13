
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/ui/homePage/Category/widgets/sortBy.dart';
import 'package:beauty/features/ui/homePage/screens/search.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:beauty/components/model/categoryModel.dart' as cat;
import 'package:provider/provider.dart';

class SubCategoryWait extends StatelessWidget {
  final  cat.Data  categor ;
  SubCategoryWait({ this.categor, });
  @override
  Widget build(BuildContext context) {
    ApiProvider apiProviderFalse =  Provider.of<ApiProvider>(context,listen: false) ;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          appBar:  AppBar(
          backgroundColor: Colors.white,
           leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              apiProviderFalse.setTypeSelected(0);

            } ,
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: Text(
           categor.name,
            style: kSubCategoryText,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                Icons.filter_list,
                color: Colors.black,
              ),
            ),
          ],
        ),
          body: Column(
            children: [
              SizedBox(
                height: 3,
                child: LinearProgressIndicator(
                  backgroundColor:
                  Theme.of(context).accentColor.withOpacity(0.2),
                  valueColor:
                  new AlwaysStoppedAnimation<Color>(kPinkLight),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

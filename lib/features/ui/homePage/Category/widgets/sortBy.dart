import 'package:beauty/components/widgets/btn.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/provider/uiProvider.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:beauty/value/string.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class SortBy extends StatefulWidget {
  @override
  _SortByState createState() => _SortByState();
}

class _SortByState extends State<SortBy> {
  int index =0;
  String _character;

  @override
  Widget build(BuildContext context) {
    UiProvider uiProvider = Provider.of<UiProvider>(context);
    ApiProvider apiProvider = Provider.of<ApiProvider>(context);
    // index= Provider.of<ApiProvider>(context,).typeSelected ??0;
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: ScreenUtil().setHeight(40),
          child: Row(
            children: [
              GestureDetector(
                child: Icon(Icons.close),
                onTap: () => Navigator.pop(context),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(125),
              ),
              Container(
                height: ScreenUtil().setHeight(56),
                alignment: Alignment.center,
                child: Text(
                  'التصنيف ',
                  style:
                      kSectionText.copyWith(fontSize: ScreenUtil().setSp(18)),
                ),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1,
          color: kBorder,
        ),
        ...radio(context),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Button(
              text: 'حفظ',
              onTap: () {
                print(_character);
                Provider.of<ApiProvider>(context,listen: false).nullProductSort();
                apiProvider.setIsSort(true);
                apiProvider.setLoadingSort();
                Provider.of<ApiProvider>(context,listen: false).setTypeSelected(sort.indexOf(apiProvider.character));
                Navigator.pop(context);
              }),
        ),
      ],
    );
  }

  List<Widget> radio(BuildContext context) {
    ApiProvider apiProviderFalse = Provider.of<ApiProvider>(context,listen: false);
    ApiProvider apiProvider = Provider.of<ApiProvider>(context);
    List<Widget> radios = [];
    for (int i = 0; i <= 4; i++) {
      radios.add(Row(
        children: [
          Radio(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeColor: kPinkLight,
            value: sort[i],
            groupValue: apiProvider.character,
            onChanged: (value) {
              apiProvider.setCharacter(value);
              Logger().d(sort.indexOf(apiProvider.character));
              index = sort.indexOf(apiProvider.character) ;
              // setState(() {
              //   _character = value;
              //   index = i ;
              // });
            },
          ),
          GestureDetector(
            onTap: () {
         // setState(() {
         //   _character = sort[i];
         //   index = i ;
         // });
                apiProvider.setCharacter(sort[i]);
                index = sort.indexOf(apiProvider.character) ;
            },
              child: Text(sortUi[i],style: TextStyle(
                  fontSize: ScreenUtil().setSp(18)
              ),),
          ),
        ],
      ));
    }
    return radios;
  }
}

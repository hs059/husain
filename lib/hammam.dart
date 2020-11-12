

import 'package:beauty/value/colors.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:beauty/value/string.dart';


import 'components/widgets/btn.dart';
import 'features/provider/uiProvider.dart';

class Hammam extends StatefulWidget {
  @override
  _HammamState createState() => _HammamState();
}

class _HammamState extends State<Hammam> {
  int index;
  String _character;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: ScreenUtil().setHeight(50),
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
                  'Sort by',
                  style: kSectionText.copyWith(
                      fontSize: ScreenUtil().setSp(18)),
                ),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1,
          color: kBorder,
        ),
        ... radio(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Button(text: 'Save', onTap: null),
        ),
      ],
    );
  }
  List<Widget> radio() {
    List<Widget>radios= [] ;
    for(int i =1;i<=5;i++){
      radios.add(Row(
        children: [
          Radio(
            activeColor: kPinkLight,
            value: sort[i],
            groupValue: _character,
            onChanged: (value) {
              setState(() {
                print(_character);
                _character = value;
              });
            },
          ),
          Text(sort[i]),
        ],
      ));
    }
    return radios;
  }
}

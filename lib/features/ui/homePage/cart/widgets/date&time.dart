import 'package:beauty/features/provider/uiProvider.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/containerCart.dart';
import 'package:beauty/value/style.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';



class DateAndTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UiProvider uiProvider = Provider.of<UiProvider>(context);
    UiProvider uiProviderFalse =
    Provider.of<UiProvider>(context, listen: false);
    return               ContainerCart(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: ScreenUtil().setWidth(4),
              ),
              Text(
                'Delivery Time Settings',
                style: kSectionText,
              ),
            ],
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Card(
            color: Color(0xffF5F8FD),
            child: ListTile(
              onTap: () =>
                  Provider.of<UiProvider>(context, listen: false)
                      .selectDate(context),
              title: Text(
                '${uiProvider.selectedDate.year}/${uiProvider.selectedDate.month}/${uiProvider.selectedDate.day}',
                style: kGrayText33,
              ),
              trailing: Icon(Icons.calendar_today),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Card(
            color: Color(0xffF5F8FD),
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(
                  showPicker(
                    context: context,
                    value: uiProvider.timeCheckOut,
                    onChange: uiProviderFalse.setTimeCheckOut,
                  ),
                );
              },
              title: Text(
                uiProvider.timeCheckOut.format(context),
                style: kGrayText33,
              ),
              trailing: Icon(Icons.access_time),
            ),
          ),
        ],
      ),
    )
    ;
  }
}

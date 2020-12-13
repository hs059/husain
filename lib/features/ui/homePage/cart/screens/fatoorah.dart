import 'package:beauty/components/widgets/btn.dart';
import 'package:beauty/features/provider/db_provider.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/containerCart.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/constant.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:logger/logger.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'dart:convert';

/*
TODO: The following data are using for demo (testing) only, so that when you go live
      don't forget to replace the following test credentials with the live
      credentials provided by MyFatoorah Company.
*/

// Base Url
final String baseUrl = "https://apitest.myfatoorah.com";

// You can get the API Key for regular payment or direct payment and recurring from here:
// https://myfatoorah.readme.io/docs/demo-information
// final String mAPIKey = "bearer w1500ff@gmail.com";
final String mAPIKey = "bearer rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL";


class Fatoorah extends StatefulWidget {
   String amount ;
  Fatoorah (this.amount);
  @override
  _FatoorahState createState() => _FatoorahState();
}

class _FatoorahState extends State<Fatoorah> {
  String _response = '';
  String _loading = "Loading...";
  String charcater = " ";
  List<PaymentMethods> paymentMethods = List();
  List<bool> isSelected = List();
  int selectedPaymentMethodIndex = -1;
  String cardNumber = "2223000000000007";
  String expiryMonth = "5";
  String expiryYear = "21";
  String securityCode = "100";
  String cardHolderName = "Mahmoud Ibrahim";
  bool visibilityObs = false;

  @override
  void initState() {
    super.initState();

    if(mAPIKey.isEmpty) {
      setState(() {
        _response = "Missing API Key.. You can get it from here: https://myfatoorah.readme.io/docs/demo-information";

      });
      return;
    }

    // TODO, don't forget to init the MyFatoorah Plugin with the following line
    MFSDK.init(baseUrl, mAPIKey);

    // (Optional) un comment the following lines if you want to set up properties of AppBar.

//    MFSDK.setUpAppBar(
//      title: "MyFatoorah Payment",
//      titleColor: Colors.white,  // Color(0xFFFFFFFF)
//      backgroundColor: Colors.black, // Color(0xFF000000)
//      isShowAppBar: true); // For Android platform only

    // (Optional) un comment this line, if you want to hide the AppBar.
    // Note, if the platform is iOS, this line will not affected

//    MFSDK.setUpAppBar(isShowAppBar: false);

    initiatePayment();
  }

  /*
    Send Payment
   */
  // void sendPayment() {
  //   var request = MFSendPaymentRequest(
  //       invoiceValue: double.parse(widget.amount),
  //       customerName: "Customer name",
  //       notificationOption: MFNotificationOption.LINK);
  //
  //   var invoiceItem = new InvoiceItem(itemName:"item1", quantity:3, unitPrice:3.5);
  //   var listItems = new List<InvoiceItem>();
  //   listItems.add(invoiceItem);
  //   request.invoiceItems = listItems;
  //
  //   MFSDK.sendPayment(
  //       MFAPILanguage.AR,
  //       request,
  //           (MFResult<MFSendPaymentResponse> result) => {
  //         if (result.isSuccess())
  //           {
  //             setState(() {
  //               print(result.response.toJson());
  //               _response = result.response.toJson().toString();
  //             })
  //           }
  //         else
  //           {
  //             setState(() {
  //               print(result.error.toJson());
  //               _response = result.error.message;
  //             })
  //           }
  //       });
  //
  //   setState(() {
  //     _response = _loading;
  //   });
  // }

  /*
    Initiate Payment
   */
  void initiatePayment() {
    var request = new MFInitiatePaymentRequest(
        double.parse(widget.amount), MFCurrencyISO.SAUDI_ARABIA_SAR);

    MFSDK.initiatePayment(
        request,
        MFAPILanguage.AR,
            (MFResult<MFInitiatePaymentResponse> result) => {
          if (result.isSuccess())
            {
              setState(() {
                Logger().d(result.response.toJson());
                _response = ""; //result.response.toJson().toString();
                paymentMethods.addAll(result.response.paymentMethods);
                for (int i = 0; i < paymentMethods.length; i++)
                  isSelected.add(false);
              })
            }
          else
            {
              setState(() {
                Logger().d(result.error.toJson());
                _response = result.error.message;
              })
            }
        });

    setState(() {
      _response = _loading;
    });
  }

  /*
    Execute Regular Payment
   */
  void executeRegularPayment(String paymentMethodId) {
    var request = new MFExecutePaymentRequest(paymentMethodId, widget.amount);

    MFSDK.executePayment(
        context,
        request,
        MFAPILanguage.AR,
            (String invoiceId, MFResult<MFPaymentStatusResponse> result) => {
          if (result.isSuccess())
            {
              setState(() {
                Logger().d(invoiceId);
                print(result.response.toJson());
                _response = result.response.toJson().toString();
              })
            }
          else
            {
              setState(() {
                Logger().d(invoiceId);
                print(result.error.toJson());
                _response = result.error.message;
              })
            }
        });

    setState(() {
      _response = _loading;
    });
  }

  /*
    Execute Direct Payment
   */
  void executeDirectPayment(String paymentMethodId) {
    var request = new MFExecutePaymentRequest(paymentMethodId, widget.amount);

//    var mfCardInfo = new MFCardInfo(cardToken: "Put your token here");

    var mfCardInfo = new MFCardInfo(
        cardNumber: cardNumber,
        expiryMonth: expiryMonth,
        expiryYear: expiryYear,
        securityCode: securityCode,
        cardHolderName: cardHolderName,
        bypass3DS: true,
        saveToken: false);

    MFSDK.executeDirectPayment(
        context,
        request,
        mfCardInfo,
        MFAPILanguage.AR,
            (String invoiceId, MFResult<MFDirectPaymentResponse> result) => {
          if (result.isSuccess())
            {
              setState(() {
                Logger().d(invoiceId);
                print(result.response.toJson());
                _response = result.response.toJson().toString();
              })
            }
          else
            {
              setState(() {
                Logger().d(invoiceId);
                print(result.error.toJson());
                _response = result.error.message;
              })
            }
        });

    setState(() {
      _response = _loading;
    });
  }

  /*
    Execute Direct Payment with Recurring
   */
  void executeDirectPaymentWithRecurring() {
    // The value "2" is the paymentMethodId of Visa/Master payment method.
    // You should call the "initiatePayment" API to can get this id and the ids of all other payment methods
    String paymentMethod = "2";

    var request = new MFExecutePaymentRequest(paymentMethod, widget.amount);

    var mfCardInfo = new MFCardInfo(
        cardNumber: cardNumber,
        expiryMonth: expiryMonth,
        expiryYear: expiryYear,
        securityCode: securityCode,
        bypass3DS: true,
        saveToken: false);

    int intervalDays = 5;

    MFSDK.executeDirectPaymentWithRecurring(
        context,
        request,
        mfCardInfo,
        intervalDays,
        MFAPILanguage.AR,
            (String invoiceId, MFResult<MFDirectPaymentResponse> result) => {
          if (result.isSuccess())
            {
              setState(() {
                Logger().d(invoiceId);
                print(result.response.toJson());
                _response = result.response.toJson().toString();
              })
            }
          else
            {
              setState(() {
                Logger().d(invoiceId);
                print(result.error.toJson());
                _response = result.error.message;
              })
            }
        });

    setState(() {
      _response = _loading;
    });
  }


  void getPaymentStatus() {
    var request = MFPaymentStatusRequest(invoiceId: "12345");

    MFSDK.getPaymentStatus(
        MFAPILanguage.AR,
        request,
            (MFResult<MFPaymentStatusResponse> result) => {
          if (result.isSuccess())
            {
              setState(() {
                Logger().d(result.response.toJson());
                _response = result.response.toJson().toString();
              })
            }
          else
            {
              setState(() {
                Logger().d(result.error.toJson());
                _response = result.error.message;
              })
            }
        });

    setState(() {
      _response = _loading;
    });
  }

  /*
    Cancel Token
   */
  void cancelToken() {
    MFSDK.cancelToken(
        "Put your token here",
        MFAPILanguage.AR,
            (MFResult<bool> result) => {
          if (result.isSuccess())
            {
              setState(() {
                Logger().d(result.response.toString());
                _response = result.response.toString();
              })
            }
          else
            {
              setState(() {
                Logger().d(result.error.toJson());
                _response = result.error.message;
              })
            }
        });

    setState(() {
      _response = _loading;
    });
  }

  /*
    Cancel Recurring Payment
   */
  void cancelRecurringPayment() {
    MFSDK.cancelRecurringPayment(
        "Put RecurringId here",
        MFAPILanguage.AR,
            (MFResult<bool> result) => {
          if (result.isSuccess())
            {
              setState(() {
                Logger().d(result.response.toString());
                _response = result.response.toString();
              })
            }
          else
            {
              setState(() {
                Logger().d(result.error.toJson());
                _response = result.error.message;
              })
            }
        });

    setState(() {
      _response = _loading;
    });
  }

  void setPaymentMethodSelected(int index, bool value) {
    for (int i = 0; i < isSelected.length; i++) {
      if (i == index) {
        isSelected[i] = value;
        if (value) {
          selectedPaymentMethodIndex = index;
          visibilityObs = paymentMethods[index].isDirectPayment;
        } else {
          selectedPaymentMethodIndex = -1;
          visibilityObs = false;
        }
      } else
        isSelected[i] = false;
    }
  }
  void dialog (){
    if(_response.isNotEmpty){
      showDialog(
          context: context,
          builder: (context) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: SimpleDialog(
                  contentPadding: EdgeInsets.all(
                      15),
                  titlePadding: EdgeInsets
                      .symmetric(
                      horizontal: 15, vertical: 20),
                  title: Row(
                    children: <Widget>[
                      Icon(Icons.category),
                      SizedBox(width: 10),
                      Text(
                        'جميع الطلبات',
                      )
                    ],
                  ),
                  children:[]
              ),
            );
          });
    }


    setState(() {

    });
  }
  void pay() {
    if (selectedPaymentMethodIndex == -1) {
      Toast.show("Please select payment method first", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
    } else {
      if (widget.amount.isEmpty) {
        Toast.show("Set the amount", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
      } else if (paymentMethods[selectedPaymentMethodIndex].isDirectPayment) {
        if (cardNumber.isEmpty ||
            expiryMonth.isEmpty ||
            expiryYear.isEmpty ||
            securityCode.isEmpty)
          Toast.show("Fill all the card fields", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
        else
          executeDirectPayment(paymentMethods[selectedPaymentMethodIndex]
              .paymentMethodId
              .toString());
      } else
        executeRegularPayment(paymentMethods[selectedPaymentMethodIndex]
            .paymentMethodId
            .toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    DBProvider dbProvider = Provider.of<DBProvider>(context);

    return SafeArea(

      child: Scaffold(
        appBar: PreferredSize(
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: kBorder,
                offset: Offset(0, 2.0),
                blurRadius: 4.0,
              )
            ]),
            child: AppBar(

              backgroundColor: Colors.white,
              title: Text(
                "الشراء أونلاين", style: kSectionText.copyWith(
                fontSize: ScreenUtil().setSp(18),
                fontFamily: 'Cairo-Regular',
              ),),
              centerTitle: true,
              elevation: 0.0,
            ),

          ),
          preferredSize: Size.fromHeight(kToolbarHeight),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            margin: EdgeInsets.all(10.0),
            child: Column(children: [
              ContainerCart(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'السعر الكلي',
                        style: kSeeAll,
                      ),
                      Text(
                        double.parse(widget.amount).toStringAsFixed(2)+
                            ' ' +
                            currency,
                        style: kSeeAll,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
              ),
              Text("اختار بوابة الدفع"),
              Padding(
                padding: EdgeInsets.all(5.0),
              ),
              Expanded(
                flex: 15,
                  child: Builder(
                    builder: (context) {
                      paymentMethods.removeWhere((element) =>
                      element.paymentMethodAr=="البطاقات المدينة - الامارات"||
                      element.paymentMethodAr=="اميكس"||
                      element.paymentMethodAr=="بنفت"||
                      element.paymentMethodAr=="البطاقات المدينة - قطر"||
                      element.paymentMethodAr=="كي نت"
                      );
                      return ListView.builder(
                          itemCount: paymentMethods.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return ListTile(
                              onTap: () {
                                charcater = paymentMethods[index].paymentMethodAr;
                                setState(() {

                                });
                              },
                              leading: Image.network(paymentMethods[index].imageUrl,
                                  width: 40.0, height: 40.0),
                              title: Text(paymentMethods[index].paymentMethodAr),
                              trailing: Column(
                                children: [
                                  Radio(
                                      value: paymentMethods[index].paymentMethodAr,
                                      groupValue: charcater,
                                    activeColor: kPinkLight,
                                      hoverColor:kPinkLight ,
                                      focusColor:kPinkLight ,
                                      onChanged: (value) {
                                        charcater = value;
                                        setState(() {

                                        });
                                      },
                                  ),

                                ],
                              ),
                            );
                          });
                    },

                  )),
              // visibilityObs
              //     ? Container(
              //     child: Column(
              //       children: <Widget>[
              //         Padding(
              //           padding: EdgeInsets.all(5.0),
              //         ),
              //         TextField(
              //           keyboardType: TextInputType.number,
              //           decoration: InputDecoration(labelText: "Card Number"),
              //           controller: TextEditingController(text: cardNumber),
              //           onChanged: (value) {
              //             cardNumber = value;
              //           },
              //         ),
              //         TextField(
              //           keyboardType: TextInputType.number,
              //           decoration: InputDecoration(labelText: "Expiry Month"),
              //           controller: TextEditingController(text: expiryMonth),
              //           onChanged: (value) {
              //             expiryMonth = value;
              //           },
              //         ),
              //         TextField(
              //           keyboardType: TextInputType.number,
              //           decoration: InputDecoration(labelText: "Expiry Year"),
              //           controller: TextEditingController(text: expiryYear),
              //           onChanged: (value) {
              //             expiryYear = value;
              //           },
              //         ),
              //         TextField(
              //           keyboardType: TextInputType.number,
              //           decoration: InputDecoration(labelText: "Security Code"),
              //           controller: TextEditingController(text: securityCode),
              //           onChanged: (value) {
              //             securityCode = value;
              //           },
              //         ),
              //         TextField(
              //           keyboardType: TextInputType.name,
              //           decoration: InputDecoration(labelText: "Card Holder Name"),
              //           controller: TextEditingController(text: cardHolderName),
              //           onChanged: (value) {
              //             cardHolderName = value;
              //           },
              //         ),
              //       ],
              //     ))
              //     : Container(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.all(5.0),
                  ),
                  Button(
                    onTap: pay,
                    text: 'شراء',
                  ),

                  // RaisedButton(
                  //   color: Colors.lightBlue,
                  //   textColor: Colors.white,
                  //   child: Text('Send Payment'),
                  //   onPressed: sendPayment,
                  // ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                ],
              ),
              Container(
                child: Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: GestureDetector(
                        child: Text(_response),
                      onTap: () {
                        Logger().d(_response);
                      },
                    ),
                  ),
                ),
              ),

            ]),
          ),
        ),
      ),
    );
  }
}

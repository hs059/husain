import 'package:beauty/components/widgets/btn.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/provider/db_provider.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/containerCart.dart';
import 'package:beauty/features/ui/homePage/homePage.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/constant.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:get/get.dart';
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
final String baseUrl = "https://api.myfatoorah.com/";
final String mAPIKey ="lPjFxhC0yOA0UbnE0vFldoCuArr-bgk1L9spr2Bw1vszgDhMD9XEmRR805JdvYVvSst11Lx25QYe9aE_hljHsLuluI8fJ8xaian--Sy503jQ3g24FPP79q6uI4UxOTyOWueU8hyThXdSBrsk0tgwOZQQFbMiJI5CDFOuOv_PZm4yr9dxY3O7Y5Qw1cB0goBeG7kZAygWjAef9kYsDbHZ_Dfyt5qWmGDoCaqHnvLohQ-PcWFuDIjYI7yt7dK99aoeR_ZvS8rvX68NvbbRUobgv9-yTLl2DOgxdEms4irRmZnkW8lR4AvSDlHhh8UcDnALaAjbjdtqtxcTD5egd3wpG4eRRXw96ZvSWC5MEMAzCkSSle_mmvpHbvg400deps2NUDNkYQmsHok2tpXjrZc9kKp9TaxzE7MpmqT76WOj0yzsE_6Mo2B6GNtBSPUJiVUxlcR1zHIqfkI64nml6y1PdUW6cLnsJDnoR152IYOQVj0o3WHRUv9gEgAJDa7kO5eEoOKnbU8TgX3FrYWJu9_Z1Qnl29xGE5E7CWrcWuMj2F8H7uqzxcv7NbGWTl3NKK1dGEHj-ceE89lVfSOj1JsUH8INFBZwGPO1cK7O6_YtNy03HAYq1AHtpD7UFpYqV85Nr7NMsSn-fQP9zHGzn0Hvug7g6nZHc2XNXJXnAcbvPPy3wV1Xek5ifNQbHZCuTiVvLztdZSyAA9GgzfvKkml2lP53y5c-jdxyMI676jxSDkNXS5Py";

// You can get the API Key for regular payment or direct payment and recurring from here:
// https://myfatoorah.readme.io/docs/demo-information
// final String baseUrl = "https://apitest.myfatoorah.com";
// final String mAPIKey ="bearer rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL";

class Fatoorah extends StatefulWidget {
  String amount;

  Fatoorah(this.amount);

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

    if (mAPIKey.isEmpty) {
      setState(() {
        _response =
            "Missing API Key.. You can get it from here: https://myfatoorah.readme.io/docs/demo-information";
      });
      return;
    }

    // TODO, don't forget to init the MyFatoorah Plugin with the following line
    MFSDK.init(baseUrl, mAPIKey);

    // (Optional) un comment the following lines if you want to set up properties of AppBar.

    MFSDK.setUpAppBar(
        title: "MyFatoorah Payment",
        titleColor: Colors.white, // Color(0xFFFFFFFF)
        backgroundColor: Colors.black, // Color(0xFF000000)
        isShowAppBar: true); // For Android platform only

    MFSDK.setUpAppBar(isShowAppBar: false);

    initiatePayment();
  }


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

  MFPaymentStatusResponse mfPaymentStatusResponse;

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
                    Logger().d(result.response.toJson());
                    mfPaymentStatusResponse = result.response;
                    if (mfPaymentStatusResponse
                            .invoiceTransactions[0].transactionStatus ==
                        "Failed") {
                      Get.snackbar('رسالة تحذير', 'هناك خطأ بإدخالك للبيانات');
                    }else if(mfPaymentStatusResponse
                        .invoiceTransactions[0].transactionStatus ==
                        "InProgress" ||mfPaymentStatusResponse
                        .invoiceTransactions[0].transactionStatus == "Succss"){
                            Provider.of<ApiProvider>(context,listen: false).updateOrder();
                            Provider.of<DBProvider>(context, listen: false).deleteAllProduct();
                            tabControllerConstant.animateTo(0);
                            kNavigatorPushAndRemoveUntil(
                                context, HomePage());
                    }else{
                      Get.snackbar('رسالة تحذير', 'هناك خطأ بإدخالك للبيانات');
                    }
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
                    print(result.response.toJson());
                    Logger().d(result.response);
                    Logger().d(result.response.toJson());
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
                    Logger().d(result.response);
                    Logger().d(result.response.toJson());
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

  void dialog() {
    if (_response.isNotEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: SimpleDialog(
                  contentPadding: EdgeInsets.all(15),
                  titlePadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  title: Row(
                    children: <Widget>[
                      Icon(Icons.category),
                      SizedBox(width: 10),
                      Text(
                        'جميع الطلبات',
                      )
                    ],
                  ),
                  children: []),
            );
          });
    }

    setState(() {});
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
                "الشراء أونلاين",
                style: kSectionText.copyWith(
                  fontSize: ScreenUtil().setSp(18),
                  fontFamily: 'Cairo-Regular',
                ),
              ),
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
                        double.parse(widget.amount).toStringAsFixed(2) +
                            ' ' +
                            currency,
                        style: kSeeAll,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              _response.length < 12 && _response.isNotEmpty
                  ? Column(
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
                        Center(
                          child: Text(
                            'جاري تحضير بوابات الدفع',
                            style: kSeeAll.copyWith(
                                fontFamily: 'Cairo-Regular', fontSize: 18),
                          ),
                        ),
                      ],
                    )
                  : Container(),
              Padding(
                padding: EdgeInsets.all(5.0),
              ),
              Text(
                "إختار طريقة الدفع",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
              ),
              Expanded(
                  flex: 15,
                  child: Builder(
                    builder: (context) {
                      paymentMethods.removeWhere((element) =>
                          element.paymentMethodAr ==
                              "البطاقات المدينة - الامارات" ||
                          element.paymentMethodAr == "اميكس" ||
                          element.paymentMethodAr == "بنفت" ||
                          element.paymentMethodAr == "البطاقات المدينة - قطر" ||
                          element.paymentMethodAr == "كي نت");
                      return ListView.builder(
                          itemCount: paymentMethods.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return ListTile(
                              onTap: () {
                                charcater =
                                    paymentMethods[index].paymentMethodAr;
                                selectedPaymentMethodIndex = index;
                                setState(() {});
                              },
                              leading: Image.network(
                                  paymentMethods[index].imageUrl,
                                  width: 40.0,
                                  height: 40.0),
                              title:
                                  Text(paymentMethods[index].paymentMethodAr),
                              trailing: Radio(
                                value:
                                    paymentMethods[index].paymentMethodAr,
                                groupValue: charcater,
                                activeColor: kPinkLight,
                                hoverColor: kPinkLight,
                                focusColor: kPinkLight,
                                onChanged: (value) {
                                  charcater = value;
                                  selectedPaymentMethodIndex = index;
                                  print(selectedPaymentMethodIndex);
                                  setState(() {});
                                },
                              ),
                            );
                          });
                    },
                  )),
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
                      child: mfPaymentStatusResponse != null
                          ? Column(
                              children: [
                                if (mfPaymentStatusResponse
                                        .invoiceTransactions[0]
                                        .transactionStatus ==
                                    "Failed")
                                  Text('خطأ: يرجى ادخال بيانات صحيحة'),
                              ],
                            )
                          : Text(_response),
                      onTap: () {
                        setState(() {
                          Logger().d(_response);
                          String res = json.encode(_response);
                          Logger().d(res);

                          // Logger().d(InvoiceTransactionsList.length);
                          // bool check = false;
                          // setCheck(bool value) {
                          //   check = value;
                          //   setState(() {});
                          // }
                          //   String myRes = '';
                          // int count = 0;
                          // for (int i = 0; i < _response.length; i++) {
                          //   if (_response[i] == ',') {
                          //     count++;
                          //   }
                          //   if(count  >=15){
                          //     myRes = myRes +_response[i] ;
                          //   }
                          // }
                          // print(count);
                          // print(myRes.rem);
                        });
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



import 'package:flutter/material.dart';

import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:toast/toast.dart';

// Base Url
final String baseUrl = "https://portal.myfatoorah.com/En/SAU/PayInvoice/LinkInvoiceDetails/040589741721547";

// final String mAPIKey = "bearer rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL";
final String mAPIKey = "lPjFxhC0yOA0UbnE0vFldoCuArr-bgk1L9spr2Bw1vszgDhMD9XEmRR805JdvYVvSst11Lx25QYe9aE_hljHsLuluI8fJ8xaian--Sy503jQ3g24FPP79q6uI4UxOTyOWueU8hyThXdSBrsk0tgwOZQQFbMiJI5CDFOuOv_PZm4yr9dxY3O7Y5Qw1cB0goBeG7kZAygWjAef9kYsDbHZ_Dfyt5qWmGDoCaqHnvLohQ-PcWFuDIjYI7yt7dK99aoeR_ZvS8rvX68NvbbRUobgv9-yTLl2DOgxdEms4irRmZnkW8lR4AvSDlHhh8UcDnALaAjbjdtqtxcTD5egd3wpG4eRRXw96ZvSWC5MEMAzCkSSle_mmvpHbvg400deps2NUDNkYQmsHok2tpXjrZc9kKp9TaxzE7MpmqT76WOj0yzsE_6Mo2B6GNtBSPUJiVUxlcR1zHIqfkI64nml6y1PdUW6cLnsJDnoR152IYOQVj0o3WHRUv9gEgAJDa7kO5eEoOKnbU8TgX3FrYWJu9_Z1Qnl29xGE5E7CWrcWuMj2F8H7uqzxcv7NbGWTl3NKK1dGEHj-ceE89lVfSOj1JsUH8INFBZwGPO1cK7O6_YtNy03HAYq1AHtpD7UFpYqV85Nr7NMsSn-fQP9zHGzn0Hvug7g6nZHc2XNXJXnAcbvPPy3wV1Xek5ifNQbHZCuTiVvLztdZSyAA9GgzfvKkml2lP53y5c-jdxyMI676jxSDkNXS5Py";
// final String mAPIKey = "lPjFxhC0yOA0UbnE0vFldoCuArr-bgk1L9spr2Bw1vszgDhMD9XEmRR805JdvYVvSst11Lx25QYe9aE_hljHsLuluI8fJ8xaian--Sy503jQ3g24FPP79q6uI4UxOTyOWueU8hyThXdSBrsk0tgwOZQQFbMiJI5CDFOuOv_PZm4yr9dxY3O7Y5Qw1cB0goBeG7kZAygWjAef9kYsDbHZ_Dfyt5qWmGDoCaqHnvLohQ-PcWFuDIjYI7yt7dK99aoeR_ZvS8rvX68NvbbRUobgv9-yTLl2DOgxdEms4irRmZnkW8lR4AvSDlHhh8UcDnALaAjbjdtqtxcTD5egd3wpG4eRRXw96ZvSWC5MEMAzCkSSle_mmvpHbvg400deps2NUDNkYQmsHok2tpXjrZc9kKp9TaxzE7MpmqT76WOj0yzsE_6Mo2B6GNtBSPUJiVUxlcR1zHIqfkI64nml6y1PdUW6cLnsJDnoR152IYOQVj0o3WHRUv9gEgAJDa7kO5eEoOKnbU8TgX3FrYWJu9_Z1Qnl29xGE5E7CWrcWuMj2F8H7uqzxcv7NbGWTl3NKK1dGEHj-ceE89lVfSOj1JsUH8INFBZwGPO1cK7O6_YtNy03HAYq1AHtpD7UFpYqV85Nr7NMsSn-fQP9zHGzn0Hvug7g6nZHc2XNXJXnAcbvPPy3wV1Xek5ifNQbHZCuTiVvLztdZSyAA9GgzfvKkml2lP53y5c-jdxyMI676jxSDkNXS5Py";

// You can get the API Key for regular payment or direct payment and recurring from here:
// https://myfatoorah.readme.io/docs/demo-information
class Fatooora extends StatefulWidget {
  Fatooora({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FatoooraState createState() => _FatoooraState();
}

class _FatoooraState extends State<Fatooora> {
  String _response = '';
  String _loading = "Loading...";

  List<PaymentMethods> paymentMethods = List();
  List<bool> isSelected = List();
  int selectedPaymentMethodIndex = -1;

  String amount = "0.100";
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
    MFSDK.init(baseUrl
        , mAPIKey
    );

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
  void sendPayment() {
    var request = MFSendPaymentRequest(
        invoiceValue: double.parse(amount),
        customerName: "Customer name",
        notificationOption: MFNotificationOption.LINK);

    var invoiceItem = new InvoiceItem(itemName:"item1", quantity:3, unitPrice:3.5);
    var listItems = new List<InvoiceItem>();
    listItems.add(invoiceItem);
    request.invoiceItems = listItems;

    MFSDK.sendPayment(
        MFAPILanguage.EN,
        request,
            (MFResult<MFSendPaymentResponse> result) => {
          if (result.isSuccess())
            {
              setState(() {
                print(result.response.toJson());
                _response = result.response.toJson().toString();
              })
            }
          else
            {
              setState(() {
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
    Initiate Payment
   */
  void initiatePayment() {
    var request = new MFInitiatePaymentRequest(
        double.parse(amount), MFCurrencyISO.KUWAIT_KWD);

    MFSDK.initiatePayment(
        request,
        MFAPILanguage.EN,
            (MFResult<MFInitiatePaymentResponse> result) => {
          if (result.isSuccess())
            {
              setState(() {
                print(result.response.toJson());
                _response = ""; //result.response.toJson().toString();
                paymentMethods.addAll(result.response.paymentMethods);
                for (int i = 0; i < paymentMethods.length; i++)
                  isSelected.add(false);
              })
            }
          else
            {
              setState(() {
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
    Execute Regular Payment
   */
  void executeRegularPayment(String paymentMethodId) {
    var request = new MFExecutePaymentRequest(paymentMethodId, amount);

    MFSDK.executePayment(
        context,
        request,
        MFAPILanguage.EN,
            (String invoiceId, MFResult<MFPaymentStatusResponse> result) => {
          if (result.isSuccess())
            {
              setState(() {
                print(invoiceId);
                print(result.response.toJson());
                _response = result.response.toJson().toString();
              })
            }
          else
            {
              setState(() {
                print(invoiceId);
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
    var request = new MFExecutePaymentRequest(paymentMethodId, amount);

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
        MFAPILanguage.EN,
            (String invoiceId, MFResult<MFDirectPaymentResponse> result) => {
          if (result.isSuccess())
            {
              setState(() {
                print(invoiceId);
                print(result.response.toJson());
                _response = result.response.toJson().toString();
              })
            }
          else
            {
              setState(() {
                print(invoiceId);
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

    var request = new MFExecutePaymentRequest(paymentMethod, amount);

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
        MFAPILanguage.EN,
            (String invoiceId, MFResult<MFDirectPaymentResponse> result) => {
          if (result.isSuccess())
            {
              setState(() {
                print(invoiceId);
                print(result.response.toJson());
                _response = result.response.toJson().toString();
              })
            }
          else
            {
              setState(() {
                print(invoiceId);
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
    Payment Enquiry
   */
  void getPaymentStatus() {
    var request = MFPaymentStatusRequest(invoiceId: "12345");

    MFSDK.getPaymentStatus(
        MFAPILanguage.EN,
        request,
            (MFResult<MFPaymentStatusResponse> result) => {
          if (result.isSuccess())
            {
              setState(() {
                print(result.response.toJson());
                _response = result.response.toJson().toString();
              })
            }
          else
            {
              setState(() {
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
    Cancel Token
   */
  void cancelToken() {
    MFSDK.cancelToken(
        "Put your token here",
        MFAPILanguage.EN,
            (MFResult<bool> result) => {
          if (result.isSuccess())
            {
              setState(() {
                print(result.response.toString());
                _response = result.response.toString();
              })
            }
          else
            {
              setState(() {
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
    Cancel Recurring Payment
   */
  void cancelRecurringPayment() {
    MFSDK.cancelRecurringPayment(
        "Put RecurringId here",
        MFAPILanguage.EN,
            (MFResult<bool> result) => {
          if (result.isSuccess())
            {
              setState(() {
                print(result.response.toString());
                _response = result.response.toString();
              })
            }
          else
            {
              setState(() {
                print(result.error.toJson());
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

  void pay() {
    if (selectedPaymentMethodIndex == -1) {
      Toast.show("Please select payment method first", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
    } else {
      if (amount.isEmpty) {
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
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(children: [
            TextField(
              keyboardType: TextInputType.number,
              controller: TextEditingController(text: amount),
              decoration: InputDecoration(labelText: "Payment Amount"),
              onChanged: (value) {
                amount = value;
              },
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
            ),
            Text("Select payment method"),
            Padding(
              padding: EdgeInsets.all(5.0),
            ),
            Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 0.0,
                        mainAxisSpacing: 0.0),
                    itemCount: paymentMethods.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Column(
                        children: <Widget>[
                          Image.network(paymentMethods[index].imageUrl,
                              width: 40.0, height: 40.0),
                          Checkbox(
                              value: isSelected[index],
                              onChanged: (bool value) {
                                setState(() {
                                  setPaymentMethodSelected(index, value);
                                });
                              })
                        ],
                      );
                    })),
            visibilityObs
                ? Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(5.0),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: "Card Number"),
                      controller: TextEditingController(text: cardNumber),
                      onChanged: (value) {
                        cardNumber = value;
                      },
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: "Expiry Month"),
                      controller: TextEditingController(text: expiryMonth),
                      onChanged: (value) {
                        expiryMonth = value;
                      },
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: "Expiry Year"),
                      controller: TextEditingController(text: expiryYear),
                      onChanged: (value) {
                        expiryYear = value;
                      },
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: "Security Code"),
                      controller: TextEditingController(text: securityCode),
                      onChanged: (value) {
                        securityCode = value;
                      },
                    ),
                    TextField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(labelText: "Card Holder Name"),
                      controller: TextEditingController(text: cardHolderName),
                      onChanged: (value) {
                        cardHolderName = value;
                      },
                    ),
                  ],
                ))
                : Container(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(5.0),
                ),
                RaisedButton(
                  color: Colors.lightBlue,
                  textColor: Colors.white,
                  child: Text('Pay'),
                  onPressed: pay,
                ),
                RaisedButton(
                  color: Colors.lightBlue,
                  textColor: Colors.white,
                  child: Text('Send Payment'),
                  onPressed: sendPayment,
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
                  child: Text(_response),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
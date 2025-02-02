import 'package:flutter/material.dart';

class ShowAlertBox {
  showError(context, String errorMessage) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "พบข้อผิดพลาดดังนี้",
                      style: TextStyle(color: Colors.pinkAccent, fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Text(errorMessage),
                    SizedBox(height: 10),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: Text('ปิด'),
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }

  showErrorWithHead(context, String errorMessage, String headErrorMessage) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      headErrorMessage,
                      style: TextStyle(color: Colors.pinkAccent, fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Text(errorMessage),
                    SizedBox(height: 10),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: Text('ปิด'),
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }

  showErrorWithAddErrorWidgert(
      context, List<Widget> listWidgetErrorMessage, String headErrorMessage) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      headErrorMessage,
                      style: TextStyle(color: Colors.pinkAccent, fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: listWidgetErrorMessage,
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: Text('ปิด'),
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }
}

import 'package:flutter/material.dart';

class ShowAlertBox {
  ShowError(context, String errorMessage) {
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
}

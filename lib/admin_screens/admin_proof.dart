import 'package:flutter/material.dart';

class ProofDialog {
  static void show(BuildContext context, String fileLink) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: _contentBox(context, fileLink),
        );
      },
    );
  }

  static Widget _contentBox(BuildContext context, String fileLink) {
    return Center(
      child: Stack(
        children: [
          Container(
              width: 500,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(0, 10),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Center(
                child: Image.network(fileLink),
              )),
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close)),
          ),
        ],
      ),
    );
  }
}

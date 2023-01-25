import 'package:flutter/material.dart';

import '../../../../core/constant/constant.dart';

class ScanResultsItem extends StatelessWidget {
  const ScanResultsItem({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: Constant.kPaddingA8,
      shape: const CircleBorder(side:BorderSide.none),
      elevation: 0,
      child: Container(
        padding: Constant.kPaddingA16,
        decoration: BoxDecoration(
          color: Constant.darkBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10,right: 30),
                padding: Constant.kPaddingA4,
                decoration: BoxDecoration(
                    border:
                    Border.all(color: Constant.primaryColor, width: 3),
                    borderRadius: const BorderRadius.all(Radius.circular(05))),
                child: Icon(Icons.file_open,
                    color: Constant.primaryColor,size: 15,)),
            Text(text, style: Constant.bodyText14),

          ],
        ),
      )

    );
  }
}


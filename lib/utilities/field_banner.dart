import 'package:flutter/material.dart';
import 'constants.dart';

class FieldBanner extends StatelessWidget {
  const FieldBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 30,
                  child: Container(
                    child: const Text(
                      'NAMA KOMODITAS',
                      style: kFieldNameTextStyle,
                    ),
                  ),
                ),
                const Expanded(
                  flex: 9,
                  child: Text(
                    'HARGA HARI INI',
                    textAlign: TextAlign.center,
                    style: kFieldNameTextStyle,
                  ),
                ),
                const Expanded(
                  flex: 25,
                  child: Text(
                    'PERUBAHAN HARGA',
                    textAlign: TextAlign.center,
                    style: kFieldNameTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: SizedBox(
            height: 0,
            child: Divider(
              // height: ,
              thickness: 1,
            ),
          ),
        ),
      ],
    );
  }
}

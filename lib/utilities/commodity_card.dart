import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CommodityCard extends StatefulWidget {
  final String commodityName;
  final String commodityCode;
  final String commodityRate;
  final String commodityPreviousRate;
  final String percent24HChange;
  final String selectedMarketCode;
  final String commodityLogoUrl;
  final String commodityUnit;
  Color? jcmpIconColor = Colors.grey[300];

  CommodityCard({Key? key,
    required this.commodityName,
    required this.commodityCode,
    required this.commodityRate,
    required this.commodityPreviousRate,
    required this.percent24HChange,
    required this.selectedMarketCode,
    required this.commodityLogoUrl,
    required this.commodityUnit,
  }) : super(key: key);

  @override
  _CommodityCardState createState() => _CommodityCardState();
}

class _CommodityCardState extends State<CommodityCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 11.0, horizontal: 20.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: widget.commodityLogoUrl,
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                  height: 35,
                  width: 35,
                ),
                const SizedBox(
                  width: 14,
                ),
                Expanded(
                  flex: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.commodityName,
                        style: kCommodityNameTextStyle,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Rp ${widget.commodityRate}/${widget.commodityUnit}',
                          style: kRateTextStyle,
                        ),
                        Text(
                          'Rp ${widget.commodityPreviousRate}/${widget.commodityUnit}',
                          textAlign: TextAlign.center,
                          style: kMarketCodeTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: (widget.percent24HChange[0] != '-')
                          ? const Color(0xFFFEEEEE)
                          : const Color(0xAAE5FBF0),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      '${widget.percent24HChange}%',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        color: (widget.percent24HChange[0] != '-')
                            ? const Color(0xFFF35957)
                            : const Color(0xFF43BC7A),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.jcmpIconColor = Colors.yellow.shade700;
                      });
                    },
                    child: Icon(
                      CupertinoIcons.eye,
                      color: widget.jcmpIconColor,
                      size: 25,
                    ),
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

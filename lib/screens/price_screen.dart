import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import '../services/commodity_data.dart';
import 'package:jakarta_market_commodity_prices/utilities/commodity_card.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jakarta_market_commodity_prices/utilities/field_banner.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String selectedMarketName = 'Pasar Induk DKI (Rata-rata)';
  String selectedMarketCode = '626688e80c192000043fd9b2';
  late Widget allCommoditiesTab;
  late Widget selectedMarketIcon;
  var commoditiesData;
  late PriceData commodityData;
  // bool updatePrice = false;

  List<PopupMenuItem<String>> getPopupMenuItemsList() {
    List<PopupMenuItem<String>> popupMenuItems = [];
    marketsList.forEach((key, value) {
      PopupMenuItem<String> popupMenuItem = PopupMenuItem(
        child: Text(value),
        value: key,
      );
      popupMenuItems.add(popupMenuItem);
    });
    return popupMenuItems;
  }

  void updateUI() async {
    for (;;) {
      commodityData = PriceData(market: selectedMarketCode);
      commoditiesData = await commodityData.fetchCommoditiesMetaData();
      setState(() {
        allCommoditiesTab = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const FieldBanner(),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (listViewContext, index) {
                  String priceInString, previousPriceInString, commodities24HChangeInString;
                  RegExp regex = RegExp(r'([.]*00)(?!.*\d)');
                  double price =
                  commodityData.getCommoditiesPrice().values.toList()[index];
                  if (price < 1) {
                    priceInString = price.toStringAsFixed(6).toString().replaceAll(regex, '');
                  } else {
                    priceInString = price.toStringAsFixed(2).toString().replaceAll(regex, '');
                  }

                  double previousPrice =
                  commodityData.getCommoditiesPreviousPrice().values.toList()[index];
                  if (previousPrice < 1) {
                    previousPriceInString = previousPrice.toStringAsFixed(6).toString().replaceAll(regex, '');
                  } else {
                    previousPriceInString = previousPrice.toStringAsFixed(2).toString().replaceAll(regex, '');
                  }

                  double commodities24HChange =
                  commodityData.getCommodities24Change().values.toList()[index];
                  commodities24HChangeInString = commodities24HChange.toStringAsFixed(2);

                  String imageUrl = commodityData.getCommoditiesLogoUrl().values.toList()[index];
                  String commodityUnit = commodityData.getCommoditiesUnit().values.toList()[index];

                  return CommodityCard(
                    commodityName: commodityData.getCommoditiesName().values.toList()[index],
                    commodityCode: commodityData.getCommoditiesName().keys.toList()[index],
                    commodityRate: priceInString,
                    commodityPreviousRate: previousPriceInString,
                    percent24HChange: commodities24HChangeInString,
                    selectedMarketCode: selectedMarketCode,
                    commodityLogoUrl: imageUrl,
                    commodityUnit: commodityUnit,
                  );
                },
                itemCount: commodityData.getCommoditiesName().length,
              ),
            ),
          ],
        );
        selectedMarketIcon = const Text(
          "Pilih Pasar",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        );
      });
      await Future.delayed(const Duration(seconds: 600));
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this, initialIndex: 0);
    allCommoditiesTab = const Center(
      child: SpinKitRing(
        color: Colors.black,
        size: 30,
        lineWidth: 4,
      ),
    );
    selectedMarketIcon = const Text(
      "Pilih Pasar",
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    );
    updateUI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 5,
        shadowColor: const Color(0xFF999999),
        backgroundColor: Colors.black,
        title: Row(
          children: const [
            Text(
              'JM',
              style: kLogoFirstWordTextStyle,
            ),
            Text(
              'CP',
              style: kLogoSecondWordTextStyle,
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return getPopupMenuItemsList();
            },
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            onSelected: (key) {
              selectedMarketName = marketsList[key].toString();
              selectedMarketCode = key;
              setState(() {
                selectedMarketIcon = const SpinKitRing(
                  color: Colors.white,
                  size: 20,
                  lineWidth: 2,
                );
              });
              updateUI();
            },
            icon: selectedMarketIcon,
          ),
          const SizedBox(
            width: 8,
          ),
        ],
        bottom: TabBar(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          indicatorColor: const Color(0xFFd0ff00),
          controller: _tabController,
          tabs: [
            Tab(
              child: Text(
                selectedMarketName,
                style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          allCommoditiesTab
        ],
      ),
    );
  }
}


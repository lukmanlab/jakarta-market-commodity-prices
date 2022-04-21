import 'networking.dart';

const Map<String, String> marketsList = {
  '6260d10b04ace909f8601fe1': 'Ps. Induk Kramat Jati',
  '6260d10b04ace909f8601fdf': 'Ps. Senen Blok III - VI',
  '6260d10b04ace909f8601fdd': 'Ps. Jembatan Merah',
  '6260d10b04ace909f8601fdb': 'Ps. Sunter Podomoro',
  '6260d10b04ace909f8601fd9': 'Ps. Rawa Badak',
  '6260d10b04ace909f8601fd7': 'Ps. Grogol',
  '6260d10b04ace909f8601fd5': 'Ps. Glodok',
  '6260d10d04ace909f8602033': 'Ps. Minggu',
  '6260d10d04ace909f8602031': 'Ps. Mayestik',
  '6260d10d04ace909f860202f': 'Ps. Pramuka',
  '6260d10d04ace909f860202d': 'Ps. Kramat Jati',
  '6260d10d04ace909f860202b': 'Ps. Jatinegara',
  '6260d10d04ace909f8602029': 'Ps. Perumnas Klender',
  '6260d10d04ace909f8602027': 'Ps. Pulo Gadung',
  '6260d10d04ace909f8602025': 'Ps. Pal Meriam',
  '6260d10d04ace909f8602023': 'Ps. Ciplak',
  '6260d10d04ace909f8602021': 'Ps. Cijantung',
  '6260d10d04ace909f860201f': 'Ps. Cibubur',
  '6260d10c04ace909f860201d': 'Ps. Ujung Menteng',
  '6260d10c04ace909f860201b': 'Ps. Tanah Abang Blok A-G',
  '6260d10c04ace909f8602019': 'Ps. Petojo Ilir',
  '6260d10c04ace909f8602017': 'Ps. Gondangdia',
  '6260d10c04ace909f8602015': 'Ps. Paseban',
  '6260d10c04ace909f8602013': 'Ps. Cempaka Putih',
  '6260d10c04ace909f8602011': 'Ps. Johar Baru',
  '6260d10c04ace909f860200f': 'Ps. Baru Metro Atom',
  '6260d10c04ace909f860200d': 'Ps. Kebayoran Lama',
  '6260d10c04ace909f860200b': 'Ps. Cipete',
  '6260d10c04ace909f8602009': 'Ps. Pesanggrahan',
  '6260d10c04ace909f8602007': 'Ps. Pondok Labu',
  '6260d10c04ace909f8602005': 'Ps. Lenteng Agung',
  '6260d10c04ace909f8602003': 'Ps. Mampang Prapatan',
  '6260d10c04ace909f8602001': 'Ps. Tebet Barat',
  '6260d10c04ace909f8601fff': 'Ps. Rumput',
  '6260d10c04ace909f8601ffd': 'Ps. Tomang Barat',
  '6260d10c04ace909f8601ffb': 'Ps. Cengkareng',
  '6260d10c04ace909f8601ff9': 'Ps. Kalideres',
  '6260d10c04ace909f8601ff7': 'Ps. Pos Pengumben',
  '6260d10c04ace909f8601ff5': 'Ps. Pal Merah',
  '6260d10c04ace909f8601ff3': 'Ps. Jembatan Lima',
  '6260d10c04ace909f8601ff1': 'Ps. Kelapa Gading',
  '6260d10c04ace909f8601fef': 'Ps. Pademangan Timur',
  '6260d10c04ace909f8601fed': 'Ps. Pluit',
  '6260d10c04ace909f8601feb': 'Ps. Kalibaru',
  '6260d10b04ace909f8601fe9': 'Ps. Koja Baru',
  '6260d10b04ace909f8601fe7': 'Ps. Rawamangun',
  '6260d10b04ace909f8601fe5': 'Ps. Klender SS',
  '6260d10b04ace909f8601fe3': 'Ps. Anyer Bahari'
};

const marketsLatestPriceApiURL =
    'https://jakarta-market-commodity-price.herokuapp.com/api/prices';

const noOfMarkets = 48;

class PriceData {
  final String market;
  Map<String, String> _commoditiesName = {
  };

  Map<String, double> _commoditiesPrice = {
  };

  Map<String, double> _commoditiesPreviousPrice = {
  };

  Map<String, double> _commodities24HChange = {
  };

  Map<String, String> _commoditiesLogoUrl = {
  };

  Map<String, String> _commoditiesUnit = {
  };

  PriceData({required this.market});

  Map<String, String> getCommoditiesName() {
    return _commoditiesName;
  }

  Map<String, double> getCommoditiesPrice() {
    return _commoditiesPrice;
  }

  Map<String, double> getCommoditiesPreviousPrice() {
    return _commoditiesPreviousPrice;
  }

  Map<String, double> getCommodities24Change() {
    return _commodities24HChange;
  }

  Map<String, String> getCommoditiesLogoUrl() {
    return _commoditiesLogoUrl;
  }

  Map<String, String> getCommoditiesUnit() {
    return _commoditiesUnit;
  }

  void setCommoditiesPrice(newCommoditiesPrice) {
    _commoditiesPrice = newCommoditiesPrice;
  }

  void setCommoditiesPreviousPrice(newCommoditiesPreviousPrice) {
    _commoditiesPreviousPrice = newCommoditiesPreviousPrice;
  }

  Future<Map<String, double>> fetchCommoditiesPrice() async {
    Map<String, double> priceList = {};
    NetworkHelper networkHelper = NetworkHelper(
        '$marketsLatestPriceApiURL/$market');
    var commodityData = await networkHelper.getData();
    int i = 0;
    for (var commodity in _commoditiesName.keys) {
      priceList[commodity] = commodityData['prices'][i]['price'].toDouble();
      i++;
    }
    return priceList;
  }

  Future<Map<String, double>> fetchCommoditiesPreviousPrice() async {
    Map<String, double> previousPriceList = {};
    NetworkHelper networkHelper = NetworkHelper(
        '$marketsLatestPriceApiURL/$market');
    var commodityData = await networkHelper.getData();
    int i = 0;
    for (var commodity in _commoditiesName.keys) {
      previousPriceList[commodity] = commodityData['prices'][i]['price_compare'].toDouble();
      i++;
    }
    return previousPriceList;
  }

  Future<Map<String, double>> fetchCommodities24HChange() async {
    Map<String, double> commodities24HChangeList = {};
    NetworkHelper networkHelper = NetworkHelper(
        '$marketsLatestPriceApiURL/$market');
    var commodityData = await networkHelper.getData();
    int i = 0;
    for (var commodity in _commoditiesName.keys) {
      var percentChange = (commodityData['prices'][i]['price'] / commodityData['prices'][i]['price_compare'] * 100) - 100;
      commodities24HChangeList[commodity] = (percentChange.toDouble());
      i++;
    }

    return commodities24HChangeList;
  }

  Future<Map<String, String>> fetchCommoditiesListings() async {
    Map<String, String> commodities = {};
    NetworkHelper networkHelper = NetworkHelper(
        '$marketsLatestPriceApiURL/$market');
    var commodityData = await networkHelper.getData();
    final prices = commodityData['prices'];
    final pricesLength = await prices.length;
    for (int i = 0; i < int.parse(pricesLength.toString()); i++) {
      commodities[commodityData['prices'][i]['commodity_id']] = commodityData['prices'][i]['name'];
    }
    return commodities;
  }

  Future<Map<String, String>> fetchCommoditiesImageUrl() async {
    Map<String, String> commodityImageUrl = {};
    NetworkHelper networkHelper = NetworkHelper(
        '$marketsLatestPriceApiURL/$market');
    var commodityData = await networkHelper.getData();
    int i = 0;
    for (var commodity in _commoditiesName.keys) {
      commodityImageUrl[commodity] = commodityData['prices'][i]['image_url'];
      i++;
    }
    return commodityImageUrl;
  }

  Future<Map<String, String>> fetchCommoditiesUnit() async {
    Map<String, String> commodityUnit = {};
    NetworkHelper networkHelper = NetworkHelper(
        '$marketsLatestPriceApiURL/$market');
    var commodityData = await networkHelper.getData();
    int i = 0;
    for (var commodity in _commoditiesName.keys) {
      commodityUnit[commodity] = commodityData['prices'][i]['unit'];
      i++;
    }
    return commodityUnit;
  }

  Future<dynamic> fetchCommoditiesMetaData() async {
    _commoditiesName = await fetchCommoditiesListings();
    _commoditiesPrice = await fetchCommoditiesPrice();
    _commoditiesPreviousPrice = await fetchCommoditiesPreviousPrice();
    _commodities24HChange = await fetchCommodities24HChange();
    _commoditiesLogoUrl = await fetchCommoditiesImageUrl();
    _commoditiesUnit = await fetchCommoditiesUnit();
    String commodityCodeList = '';
    for (var commodityName in _commoditiesName.keys) {
      if (commodityName == _commoditiesName.keys.last) {
        commodityCodeList += commodityName;
      } else {
        commodityCodeList += commodityName;
        commodityCodeList += ',';
      }
    }

    NetworkHelper networkHelper = NetworkHelper(
        '$marketsLatestPriceApiURL/$market');
    var commoditiesData = await networkHelper.getData();

    return commoditiesData;
  }
}

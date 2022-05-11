import 'networking.dart';

const Map<String, String> marketsList = {
  '626688e80c192000043fd9b2': 'Pasar Induk DKI (Rata-rata)',
  '6260d10b04ace909f8601fe1': 'Pasar Induk Kramat Jati',
  '6260d10b04ace909f8601fdf': 'Pasar Senen Blok III - VI',
  '6260d10b04ace909f8601fdd': 'Pasar Jembatan Merah',
  '6260d10b04ace909f8601fdb': 'Pasar Sunter Podomoro',
  '6260d10b04ace909f8601fd9': 'Pasar Rawa Badak',
  '6260d10b04ace909f8601fd7': 'Pasar Grogol',
  '6260d10b04ace909f8601fd5': 'Pasar Glodok',
  '6260d10d04ace909f8602033': 'Pasar Minggu',
  '6260d10d04ace909f8602031': 'Pasar Mayestik',
  '6260d10d04ace909f860202f': 'Pasar Pramuka',
  '6260d10d04ace909f860202d': 'Pasar Kramat Jati',
  '6260d10d04ace909f860202b': 'Pasar Jatinegara',
  '6260d10d04ace909f8602029': 'Pasar Perumnas Klender',
  '6260d10d04ace909f8602027': 'Pasar Pulo Gadung',
  '6260d10d04ace909f8602025': 'Pasar Pal Meriam',
  '6260d10d04ace909f8602023': 'Pasar Ciplak',
  '6260d10d04ace909f8602021': 'Pasar Cijantung',
  '6260d10d04ace909f860201f': 'Pasar Cibubur',
  '6260d10c04ace909f860201d': 'Pasar Ujung Menteng',
  '6260d10c04ace909f860201b': 'Pasar Tanah Abang Blok A-G',
  '6260d10c04ace909f8602019': 'Pasar Petojo Ilir',
  '6260d10c04ace909f8602017': 'Pasar Gondangdia',
  '6260d10c04ace909f8602015': 'Pasar Paseban',
  '6260d10c04ace909f8602013': 'Pasar Cempaka Putih',
  '6260d10c04ace909f8602011': 'Pasar Johar Baru',
  '6260d10c04ace909f860200f': 'Pasar Baru Metro Atom',
  '6260d10c04ace909f860200d': 'Pasar Kebayoran Lama',
  '6260d10c04ace909f860200b': 'Pasar Cipete',
  '6260d10c04ace909f8602009': 'Pasar Pesanggrahan',
  '6260d10c04ace909f8602007': 'Pasar Pondok Labu',
  '6260d10c04ace909f8602005': 'Pasar Lenteng Agung',
  '6260d10c04ace909f8602003': 'Pasar Mampang Prapatan',
  '6260d10c04ace909f8602001': 'Pasar Tebet Barat',
  '6260d10c04ace909f8601fff': 'Pasar Rumput',
  '6260d10c04ace909f8601ffd': 'Pasar Tomang Barat',
  '6260d10c04ace909f8601ffb': 'Pasar Cengkareng',
  '6260d10c04ace909f8601ff9': 'Pasar Kalideres',
  '6260d10c04ace909f8601ff7': 'Pasar Pos Pengumben',
  '6260d10c04ace909f8601ff5': 'Pasar Pal Merah',
  '6260d10c04ace909f8601ff3': 'Pasar Jembatan Lima',
  '6260d10c04ace909f8601ff1': 'Pasar Kelapa Gading',
  '6260d10c04ace909f8601fef': 'Pasar Pademangan Timur',
  '6260d10c04ace909f8601fed': 'Pasar Pluit',
  '6260d10c04ace909f8601feb': 'Pasar Kalibaru',
  '6260d10b04ace909f8601fe9': 'Pasar Koja Baru',
  '6260d10b04ace909f8601fe7': 'Pasar Rawamangun',
  '6260d10b04ace909f8601fe5': 'Pasar Klender SS',
  '6260d10b04ace909f8601fe3': 'Pasar Anyer Bahari'
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

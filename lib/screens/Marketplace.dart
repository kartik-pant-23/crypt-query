import 'package:crypt_query/widgets/CurrenciesList.dart';
import 'package:flutter/material.dart';

class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({Key? key}) : super(key: key);

  @override
  _MarketplaceScreenState createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> with AutomaticKeepAliveClientMixin<MarketplaceScreen> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: CurrenciesList()),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

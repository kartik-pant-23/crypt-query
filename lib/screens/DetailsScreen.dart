import 'package:crypt_query/models/Currency.dart';
import 'package:crypt_query/services/currencies.dart';
import 'package:crypt_query/widgets/Link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class DetailsScreen extends StatefulWidget {
  final Currency currency;

  DetailsScreen({required this.currency});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Widget _shimmerLayout = Shimmer.fromColors(
    baseColor: Color(0xffd9e2ec).withOpacity(0.50),
    highlightColor: Color(0xffbcccdc),
    child: ListView.builder(
      itemCount: 60,
      shrinkWrap: true,
      itemBuilder: (_, index) {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 8, width: (index / 9 == 2) ? 100 : double.infinity, color: Color(0xff486f51)),
                SizedBox(width: 16),
              ]
            )
        );
      }
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Row(children: [
              CircleAvatar(
                  radius: 16,
                  child: (widget.currency.logoUrl.endsWith(".svg"))
                      ? SvgPicture.network(widget.currency.logoUrl,
                          height: 32, width: 32)
                      : Image.network(widget.currency.logoUrl,
                          height: 32, width: 32)),
              SizedBox(width: 8),
              Text(widget.currency.symbol)
            ]),
            backgroundColor: Color(0xff243b53),
            titleSpacing: 0.0),
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 12.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: Color(0xff486581).withOpacity(0.15)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              widget.currency.logoUrl.endsWith(".svg")
                                  ? SvgPicture.network(widget.currency.logoUrl,
                                      height: 48, width: 48)
                                  : Image.network(widget.currency.logoUrl,
                                      height: 48, width: 48),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("${widget.currency.name}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(width: 8),
                                        Text("(${widget.currency.symbol})"),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        Text(widget.currency.price ?? "-",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xffd9e2ec))),
                                        SizedBox(width: 8),
                                        Text(
                                            "(${widget.currency.priceDelta ?? "-"})",
                                            style: TextStyle(
                                                color: (widget.currency
                                                                .priceDelta ??
                                                            "-")
                                                        .startsWith("-")
                                                    ? Colors.red
                                                    : Colors.green,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 8.0),
                          MaterialButton(
                            onPressed: () {},
                            color: Colors.amber,
                            child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                child: Text("Add to Dashboard",
                                    style: TextStyle(
                                        color: Color(0xff102a43),
                                        fontWeight: FontWeight.bold))),
                          )
                        ],
                      )
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 12.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: Color(0xff486581).withOpacity(0.15)),
                      child: FutureBuilder<Currency?>(
                        future: getCurrencyDetails(widget.currency.id),
                        builder: (BuildContext context, AsyncSnapshot<Currency?> snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting)
                            return _shimmerLayout;
                          else {
                            if(snapshot.hasData) {
                              Currency currency = snapshot.data!;
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Icon(Icons.link_rounded, size: 20.0),
                                      SizedBox(width: 4.0),
                                      Text("External Links", style: TextStyle(fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                  if(currency.websiteUrl?.isNotEmpty ?? false) Link(text: currency.websiteUrl!),
                                  if(currency.githubUrl?.isNotEmpty ?? false) Link(text: currency.githubUrl!),
                                  if(currency.twitterUrl?.isNotEmpty ?? false) Link(text: currency.twitterUrl!),
                                  if(currency.bitCoinTalkUrl?.isNotEmpty ?? false) Link(text: currency.bitCoinTalkUrl!),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Divider(thickness: 1.0, color: Colors.white12),
                                  ),
                                  Text(currency.description ?? "")
                                ],
                              );
                            } else {
                              return Text(
                                "Some error has occurred!",
                                style: TextStyle(color: Colors.red)
                              );
                            }
                          }
                        },
                      ),
                    ),
                  )
                ]
            )
        )
    );
  }
}

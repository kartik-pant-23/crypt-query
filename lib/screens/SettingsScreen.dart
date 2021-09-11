import 'package:crypt_query/models/Settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late String perPage, currency;
  @override
  void initState() {
    perPage = Provider.of<Settings>(context, listen: false).perPage;
    currency = Provider.of<Settings>(context, listen: false).currency;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        titleSpacing: 0.0,
        backgroundColor: Color(0xff243b53),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text("Per Page Count"),
                SizedBox(width: 12.0),
                DropdownButton(
                  value: perPage,
                  onChanged: (String? value) {
                    setState(() => perPage = value ?? perPage);
                  },
                  items: [
                    DropdownMenuItem(child: Text("20"), value: "20"),
                    DropdownMenuItem(child: Text("35"), value: "35"),
                    DropdownMenuItem(child: Text("50"), value: "50"),
                  ],
                )
              ],
            ),
            SizedBox(height: 12.0),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text("Currency"),
                SizedBox(width: 12.0),
                DropdownButton(
                  value: currency,
                  onChanged: (String? value) {
                    setState(() => currency = value ?? currency);
                  },
                  items: [
                    DropdownMenuItem(child: Text("INR"), value: "INR"),
                    DropdownMenuItem(child: Text("USD"), value: "USD"),
                    DropdownMenuItem(child: Text("EUR"), value: "EUR"),
                  ],
                )
              ],
            ),
            SizedBox(height: 12.0),
            Container(
              alignment: Alignment.centerRight,
              child: MaterialButton(
                color: Colors.amber,
                textColor: Color(0xff102a43),
                child: Text("Save changes", style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () {
                  context.read<Settings>().changeValues(currency, perPage);
                  Navigator.of(context).pop();
                },
              )
            )
          ],
        ),
      )
    );
  }
}

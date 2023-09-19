// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'package:flutter/material.dart';

import 'package:garments_app/controller/controller.dart';
import 'package:garments_app/model/model.dart';
import 'package:garments_app/view/bill/bill_create.dart';

class BillCreateOnePage extends StatefulWidget {
  const BillCreateOnePage({super.key});

  @override
  State<BillCreateOnePage> createState() => _BillCreateOnePageState();
}

class _BillCreateOnePageState extends State<BillCreateOnePage> {
  Future<GarmentsApp>? _future;
  PartyPersonal? _selected;

  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController password2 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _future = getPartyListtmy();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Create Bill"),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Create Bill',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Shop Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: password,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Shop Address',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Owner Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: password,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Owner Phone',
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'OR',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
            ),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Shop List"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder(
                      future: _future,
                      builder: (BuildContext context,
                          AsyncSnapshot<GarmentsApp> sn) {
                        if (sn.hasData) {
                          return DropdownButton<PartyPersonal>(
                            items: sn.data!.partyPersonal.map((partyPersonal) {
                              return DropdownMenuItem<PartyPersonal>(
                                value: partyPersonal,
                                child: Text(partyPersonal.shopName.toString()),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selected = value;
                              });
                            },
                            value: _selected,
                          );
                        }
                        if (sn.hasError) {
                          return const Center(
                              child: Text("Error Loading Data"));
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Create Bill'),
                onPressed: () {
                  if (_selected!.shopName == null) {
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BillCreatePage(
                          myShopName: _selected!.shopName,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

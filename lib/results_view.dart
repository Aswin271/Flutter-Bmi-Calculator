// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bmi_project/functions.dart';
import 'package:flutter_bmi_project/home_page.dart';
import 'package:flutter_bmi_project/models/store_details.dart';

class ResultsView extends StatefulWidget {
  const ResultsView({super.key});

  @override
  State<ResultsView> createState() => _ResultsViewState();
}

class _ResultsViewState extends State<ResultsView> {
  List<StoreDetails> storeList = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    List<StoreDetails> storeDetailList = await retrieveStoreDetailsList();
    setState(() {
      storeList = storeDetailList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
        ),
      ),
      body: storeList.isEmpty
          ? Center(child: Text('No results to display'))
          : ListView.builder(
              itemCount: storeList.length,
              itemBuilder: (context, index) {
                final storeDetails = storeList[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(storeDetails.storeName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Age: ${storeDetails.storeAge}'),
                        Text('Height: ${storeDetails.storeHeight} cm'),
                        Text('Weight: ${storeDetails.storeWeight} kg'),
                        Text('BMI Result: ${storeDetails.storeResult.toStringAsFixed(2)}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

import 'package:covid_tracker/View/world_states.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
   String name,image;
   int totalClass,totalDeaths,totalRecovered,active, critical,todayRecovered,test;
    DetailsScreen({Key? key,
    required this.name,
     required this.image,
     required this.totalClass,
     required this.totalDeaths,
     required this.totalRecovered,
     required this.active,
     required this.critical,
     required this.todayRecovered,
     required this.test,
      });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [

              Card(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage:NetworkImage(widget.image),
                    ),
                    ReusableRow(title: 'name', value: widget.name),
                    ReusableRow(title: 'totalClass', value: widget.totalClass.toString()),
                    ReusableRow(title: 'totalDeaths', value: widget.totalDeaths.toString()),
                    ReusableRow(title: 'totalRecovered', value: widget.totalRecovered.toString()),
                    ReusableRow(title: 'active', value: widget.active.toString()),
                    ReusableRow(title: 'critical', value: widget.critical.toString()),
                    ReusableRow(title: 'active', value: widget.active.toString()),
                    ReusableRow(title: 'todayRecovered', value: widget.todayRecovered.toString()),
                    ReusableRow(title: 'test', value: widget.test.toString()),
                  ],
                ),
              ),

            ],
          )
        ],
      ),
    );
  }
}

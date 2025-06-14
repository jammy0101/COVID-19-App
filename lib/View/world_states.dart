import 'package:covid_tracker/Model/WorldStateModel.dart';
import 'package:covid_tracker/Services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({Key? key}) : super(key: key);

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates>
    with TickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: Duration(seconds: 3),
  )..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  final colorList = [
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              FutureBuilder(
                  future: statesServices.fetchWorldStatesRecords(),
                  builder: (context,AsyncSnapshot<WorldStateModel> snapshot){
                    if(snapshot.hasData){
                      return Expanded(
                        flex: 1,
                          child: SpinKitFadingCircle(
                            size: 50.0,
                            color: Colors.white,
                            controller: controller,
                          )
                      );
                    }else{
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Total": 20,
                              "Recovered": 15,
                              "Deaths": 5,
                            },
                            animationDuration: Duration(seconds: 3),
                            legendOptions: LegendOptions(
                              legendPosition: LegendPosition.left,
                              legendShape: BoxShape.circle,
                              legendTextStyle: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            chartType: ChartType.ring,
                            colorList: colorList,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.height * .1),
                            child: Card(
                              child: Column(
                                children: [
                                  ReusableRow(
                                    title: 'Total',
                                    value: '200',
                                  ),
                                  ReusableRow(
                                    title: 'Total',
                                    value: '200',
                                  ),
                                  ReusableRow(
                                    title: 'Total',
                                    value: '200',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(child: Text('Track Countries')),
                          ),
                        ],
                      );
                    }
                  }
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider(),
        ],
      ),
    );
  }
}

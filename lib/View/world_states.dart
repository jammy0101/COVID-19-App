import 'package:covid_tracker/Model/WorldStateModel.dart';
import 'package:covid_tracker/Services/states_services.dart';
import 'package:covid_tracker/View/countries_list.dart';
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
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              FutureBuilder(
                  future: statesServices.fetchWorldStatesRecords(),
                  builder: (context,AsyncSnapshot<WorldStateModel> snapshot){
                    if(!snapshot.hasData){
                      return Expanded(
                        flex: 1,
                          child: SpinKitFadingCircle(
                            size: 50.0,
                            color: Colors.white,
                            controller: controller,
                          )
                      );
                    }else{
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            PieChart(
                              dataMap: {
                                "Total": double.parse(snapshot.data!.cases.toString()),
                                "Recovered": double.parse(snapshot.data!.recovered.toString()),
                                "Deaths": double.parse(snapshot.data!.deaths.toString()),
                              },
                              animationDuration: Duration(seconds: 3),
                              chartValuesOptions: ChartValuesOptions(
                                showChartValuesInPercentage: true
                              ),
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
                                  vertical: MediaQuery.of(context).size.height * .01),
                              child: Card(
                                child: Column(
                                  children: [
                                    ReusableRow(
                                      title: 'Total',
                                      value: snapshot.data!.cases.toString(),
                                    ),
                                    ReusableRow(
                                      title: 'Deaths',
                                      value: snapshot.data!.deaths.toString(),
                                    ),
                                    ReusableRow(
                                      title: 'Recovered',
                                      value: snapshot.data!.recovered.toString(),
                                    ),
                                    ReusableRow(
                                      title: 'Active',
                                      value: snapshot.data!.active.toString(),
                                    ),
                                    ReusableRow(
                                      title: 'critical',
                                      value: snapshot.data!.critical.toString(),
                                    ),
                                    ReusableRow(
                                      title: 'today Deaths',
                                      value: snapshot.data!.todayDeaths.toString(),
                                    ),
                                    ReusableRow(
                                      title: 'today Recovered',
                                      value: snapshot.data!.todayRecovered.toString(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => CountriesList()));
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color(0xff1aa260),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(child: Text('Track Countries')),
                              ),
                            ),
                          ],
                        ),
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

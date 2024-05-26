import 'package:antitheftalarm/theme/theme_text.dart';
import 'package:antitheftalarm/theme/themecolors.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Anti Theft Alarm'),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.sort),color: Themecolor.white,)],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Feature'),
              SizedBox(
                height: height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: height * 0.13,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                                width: 2.0, style: BorderStyle.solid))),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Intruder Alert',
                                style: Themetext.atextstyle.copyWith(fontWeight: FontWeight.w900,fontSize: 16),
                              ),
                              Icon(
                                Icons.warning_amber,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'capture intruder photos upon unatherrised unlock attept',
                          style: Themetext.greyColortextstyle,
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: height * 0.13,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border(
                            bottom: BorderSide(
                                width: 2.0, style: BorderStyle.solid))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Donot Touch My Phone',
                                style: Themetext.atextstyle.copyWith(fontWeight: FontWeight.w900,fontSize: 16),
                              ),
                              Icon(
                                Icons.mobile_off_rounded,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Detect When your phone is moved',
                            style: Themetext.greyColortextstyle,
                          ),
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: height * 0.13,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border(
                            bottom: BorderSide(
                                width: 2.0, style: BorderStyle.solid))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Anti Pocket Detection',
                                style: Themetext.atextstyle.copyWith(fontWeight: FontWeight.w900,fontSize: 16),
                              ),
                              Icon(
                                Icons.not_accessible_sharp,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Detct when remove from pocket',
                            style: Themetext.greyColortextstyle,
                          ),
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: height * 0.13,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border(
                            bottom: BorderSide(
                                width: 2.0, style: BorderStyle.solid))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Charging Detection',
                                style: Themetext.atextstyle.copyWith(fontWeight: FontWeight.w900,fontSize: 16),
                              ),
                              Icon(
                                Icons.charging_station_outlined,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Detect when charge is unplugged',
                            style:Themetext.greyColortextstyle,
                          ),
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: height * 0.13,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border(
                            bottom: BorderSide(
                                width: 2.0, style: BorderStyle.solid))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Wifi Detection',
                                style: Themetext.atextstyle.copyWith(fontWeight: FontWeight.w900,fontSize: 16),
                              ),
                              Icon(
                                Icons.wifi,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Alarm when someone try to on/off the wifi',
                            style: Themetext.greyColortextstyle,
                          ),
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: height * 0.13,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border(
                            bottom: BorderSide(
                                width: 2.0, style: BorderStyle.solid))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Ovoid Overcharging',
                                style: Themetext.atextstyle.copyWith(fontWeight: FontWeight.w900,fontSize: 16),
                              ),
                              Icon(
                                Icons.charging_station_rounded,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Alarm when battry is fully charged!',
                            style: Themetext.greyColortextstyle,
                          ),
                        )
                      ],
                    )),
              )
       ,           SizedBox(
                height: height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: height * 0.13,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border(
                            bottom: BorderSide(
                                width: 2.0, style: BorderStyle.solid))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'AirPhones Detection',
                                style: Themetext.atextstyle.copyWith(fontWeight: FontWeight.w900,fontSize: 16),
                              ),
                              Icon(
                                Icons.charging_station_rounded,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Alarm when battry is fully charged!',
                            style: Themetext.greyColortextstyle,
                          ),
                        )
                      ],
                    )),
              )
          ],
          ),
        ),
      ),
    );
  }
}

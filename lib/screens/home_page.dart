import 'dart:convert';

import 'package:doctor_flutter_laravel/components/appointment_card.dart';
import 'package:doctor_flutter_laravel/components/doctor_card.dart';
import 'package:doctor_flutter_laravel/providers/dio_provider.dart';
import 'package:doctor_flutter_laravel/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> user = {};
  Map<String, dynamic> doctor = {};
  List<Map<String, dynamic>> medCat = [
    {
      "icon": FontAwesomeIcons.heartPulse,
      "category": "Cardiology",
    },
    {
      "icon": FontAwesomeIcons.userDoctor,
      "category": "General",
    },
    {
      "icon": FontAwesomeIcons.lungs,
      "category": "Respirations",
    },
    {
      "icon": FontAwesomeIcons.hand,
      "category": "Dermatology",
    },
    {
      "icon": FontAwesomeIcons.personPregnant,
      "category": "Gynecology",
    },
    {
      "icon": FontAwesomeIcons.teeth,
      "category": "Dental",
    },
  ];

  Future<void> getData() async {
    //get token from share preferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    if (token.isNotEmpty && token != '') {
      final response = await DioProvider().getUser(token);
      if (response != null) {
        setState(() {
          user = json.decode(response);
          //print(user);
          //check if any appointment today
          for (var doctorData in user['doctor']) {
            //if there is appointment return of today
            //then pass the doctor info
            if (doctorData['appointments'] != null) {
              doctor = doctorData;
            }
          }
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      body: user.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
              child: SafeArea(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          user['name'],
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage('assets/profile1.jpg'),
                          ),
                        )
                      ],
                    ),
                    Config.spaceMedium,
                    const Text(
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      'Categoria',
                    ),
                    Config.spaceSmall,
                    //Category Listining
                    SizedBox(
                      height: Config.heightSize * 0.05,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List<Widget>.generate(medCat.length, (index) {
                          return Card(
                            margin: const EdgeInsets.only(right: 20),
                            color: Config.primaryColor,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  FaIcon(
                                    medCat[index]['icon'],
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    medCat[index]['category'],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    Config.spaceSmall,
                    const Text(
                      'Agendamentos para Hoje',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Config.spaceSmall,
                    doctor.isNotEmpty
                        ? AppointmentCard(
                            doctor: doctor,
                            color: Config.primaryColor,
                          )
                        : Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  'Nenhum agendamento para hoje',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                    Config.spaceSmall,
                    const Text(
                      'Top Doutores',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    //List  of top doctors
                    Config.spaceSmall,
                    Column(
                      children: List.generate(user['doctor'].length, (index) {
                        return DoctorCard(
                            route: 'doc_details',
                            doctor: user['doctor'][index]);
                      }),
                    )
                  ],
                ),
              )),
            ),
    );
  }
}

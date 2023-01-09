import 'package:doctor_flutter_laravel/utils/config.dart';
import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({Key? key, required this.route, required this.doctor})
      : super(key: key);

  final String route;
  final Map<String, dynamic> doctor; //receive doctor details
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 150,
      child: GestureDetector(
        child: Card(
          elevation: 5,
          color: Colors.white,
          child: Row(children: [
            SizedBox(
              width: Config.widthSize * 0.33,
              // child: Image.asset(
              //   'assets/doctor_2.jpg',
              //   fit: BoxFit.fill,
              // ),
              child: Image.network(
                "http://192.168.0.112:8000${doctor['doctor_profile']}",
                fit: BoxFit.fill,
              ),
            ),
            Flexible(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Dr ${doctor['doctor_name']}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${doctor['category']}",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.normal),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const <Widget>[
                      Icon(
                        Icons.star_border,
                        color: Colors.yellow,
                        size: 16,
                      ),
                      Spacer(flex: 1),
                      Text('4.5'),
                      Spacer(flex: 1),
                      Text('Reviews'),
                      Spacer(flex: 1),
                      Text('(20)'),
                    ],
                  )
                ],
              ),
            ))
          ]),
        ),
        onTap: () {
          //redirect to doctor details
          Navigator.of(context).pushNamed(route);
        }, // Redirect to doctor details
      ),
    );
  }
}

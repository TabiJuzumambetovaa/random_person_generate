import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_person_practice/models/person_model.dart';
import 'package:flutter_person_practice/theme/app_colors.dart';
import 'package:flutter_person_practice/theme/app_fonts.dart';
import 'package:flutter_person_practice/widgets/el_button.dart';
import 'package:flutter_person_practice/widgets/text_fields.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class PersonScreen extends StatefulWidget {
  const PersonScreen({super.key});

  @override
  State<PersonScreen> createState() => _PersonScreenState();
}
 String image = "";
  String name = "";
  String username = "";
  String phoneNumber = "";
  String email = "";


class _PersonScreenState extends State<PersonScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    
    super.initState();
    getRandomPerson();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {
                getRandomPerson();
              },
              child: Text(
                "Generate",
                style: AppFonts.w500s16,
              ),
            ),
            SizedBox(
              height: 38.h,
            ),
            Center(
              child: CircleAvatar(
                radius: 76.r,
                backgroundColor: Colors.transparent,
                child: Container(
                  width: 152.w,
                  height: 152.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [AppColors.start, AppColors.end],
                    ),
                  ),
                  child: Center(
                    child: image==""?const CircularProgressIndicator(): Image.network(image,errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                    width: 152,height: 152,),
                  ),
                ),
              ),
              
            ),
              const SizedBox(height: 20,),

             TextFields(
              labelText: "Name",
              hintText: "Alex Marshall",
              controller: nameController,
              
            ),
             TextFields(
              labelText: "Username",
              hintText: "alex_marshall",
              controller: usernameController,
            ),
           TextFields(
              labelText: "Phone number",
              hintText: "+1 515 599 9655",
              controller: phoneNumberController,
            ),
             TextFields(
              labelText: "Email",
              hintText: "alexmarshall2022@gmail.com",
            controller: emailController,),
            const Spacer(),
            ElButton(onPressed: (){
              openGoogleMaps();
            },),
          ],
        ),
      ),
    );
  }

  Future<void> getRandomPerson()async{
    final Dio dio=Dio();
    final Response response= await dio.get("https://randomuser.me/api/");
   final PersonModel model =PersonModel.fromJson(response.data);
   setState(() {
      // Присвоение значения переменной image из модели данных
      if (model.results != null && model.results!.isNotEmpty) {
      image = model.results![0].picture?.large ?? "";
      nameController.text = "${model.results![0].name?.first} ${model.results![0].name?.last}";
      usernameController.text = model.results![0].login?.username ?? "";
      phoneNumberController.text = model.results![0].phone ?? "";
      emailController.text = model.results![0].email ?? "";
    }
    });


  }
    void openGoogleMaps() async {
    // Получаем текущее местоположение пользователя
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Проверяем, установлен ли браузер на устройстве
    // ignore: deprecated_member_use
    if (await canLaunch(
        'https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}')) {
      // Открываем Google Maps с текущим местоположением пользователя
      // ignore: deprecated_member_use
      await launch(
          'https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}');
    } 
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone/presentation/bloc/dialer_screen_bloc/dialer_bloc.dart';
import 'package:phone/presentation/bloc/tab_recent_bloc/tab_recent_bloc.dart';
import 'package:phone/presentation/pages/tab_contacts/tab_contacts.dart';
import 'package:phone/presentation/widgets/icon_button_widget.dart';
import 'package:phone/presentation/widgets/icon_with_text.dart';
import 'package:phone/presentation/widgets/text_widget.dart';

class ScreenContactView extends StatelessWidget {
  const ScreenContactView({super.key, required this.contact,required this.color});
  final ContactInfo contact;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(right: 30),
        backgroundColor: Colors.transparent,
        actions: [
          IconButtonWidget(icon: Icon(Icons.edit), onTap: () {}),
          SizedBox(width: 20),
          IconButtonWidget(
            icon: Icon(
              (contact.isStared == true) ? Icons.star : Icons.star_border,
            ),
            onTap: () {},
          ),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            CircleAvatar(
              
              backgroundColor: (contact.image == null)?color:null,
              radius: 100,
              backgroundImage:
                  (contact.image != null) ? MemoryImage(contact.image!) : null,
                  child: (contact.image == null)?TextWidget(text: contact.displayName[0].toUpperCase(),fontSize: 90,fontWeigh: FontWeight.bold,):null,
            ),
            SizedBox(height: 10,),
            TextWidget(text: contact.displayName,fontSize: 30,),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconWIthTextWidget(icon: InkWell(onTap: () {
                  context.read<DialerBloc>().add(MakeCallEvent(phone: contact.phone.first.number, context: context));
                }, child: CircleAvatar(backgroundColor: Colors.grey,radius: 25, child: Icon(Icons.call,size: 30,),)), text: "Call"),
                IconWIthTextWidget(icon: InkWell(child: CircleAvatar(backgroundColor: Colors.grey,radius: 25, child: Icon(Icons.message,size: 30,),)), text: "Message"),
              ],
            ),
            SizedBox(height: 10,),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                //color: const Color.fromARGB(255, 47, 35, 30),
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextWidget(text: "Contact info",fontSize: 16,fontWeigh: FontWeight.bold,),
                  ),
                  InkWell(
                    splashColor: Colors.black,
                    onTap: (){
                      context.read<DialerBloc>().add(MakeCallEvent(phone: contact.phone.first.number, context: context));
                    },
                    child: ListTile(
                      leading: Icon(Icons.call),
                      title: TextWidget(text: contact.phone.isNotEmpty?contact.phone.first.number:"No phone",fontSize: 18,fontWeigh: FontWeight.bold,),
                      subtitle: TextWidget(text: "Phone"),
                     //s trailing: IconButtonWidget(icon: Icon(Icons.message)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

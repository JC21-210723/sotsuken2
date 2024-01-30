import 'package:flutter/material.dart';
import '../ui/Manual.dart';
import '../ui/CreateUser1.dart';
import '../ui/Another_ingredient.dart';
import '../ui/SettingUser1.dart';
import '../Data/AllAnotherData.dart';


class DrawerMenu extends StatelessWidget{
   const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
   return Drawer(
     child:ListView(
       children: [
         SizedBox(
           height: 100,
           child:DrawerHeader(
             child: Container(
               alignment: Alignment.bottomLeft,
               child:const Text('- Menu -',style: TextStyle(fontSize: 25),),
             ),
           ),
         ),

         //ご利用方法
         ListTile(
           leading: const Icon(
             Icons.import_contacts,
             color: Colors.black38,
             size:25,
           ),
           title:const Text('ご利用方法',style: TextStyle(fontSize: 20),),
           onTap:(){
             Navigator.of(context).pop();
             Navigator.of(context).push(
                 MaterialPageRoute(builder: (context){
                   return Manual_Page();
                 })
             );
           },
         ),
         //新規ユーザー登録
         ListTile(
           leading: const Icon(
             Icons.person_add,
             color: Colors.black38,
             size:25,
           ),
           title:const Text('ユーザー登録',style: TextStyle(fontSize: 20),),
           onTap:(){
             Navigator.of(context).pop();
             Navigator.of(context).push(
                 MaterialPageRoute(builder: (context){
                   return const StateCreateUser1();
                 })
             );
           },
         ),
         //追加成分管理
         ListTile(
           leading: const Icon(
             Icons.manage_search,
             color: Colors.black38,
             size:30,
           ),
           title:const Text('追加成分の管理',style: TextStyle(fontSize: 20),),
           onTap:(){
             Navigator.of(context).pop();
             AllAnotherData aad = AllAnotherData();
             aad.AllResetAnother();
             Navigator.of(context).push(
                 MaterialPageRoute(builder: (context){
                   return StateAnother_ingredient(PageFlag: 'Manual', PageCount: 0);
                 })
             );
           },
         ),
         //設定
         ListTile(
           leading: const Icon(
             Icons.settings,
             color: Colors.black38,
             size:25,
           ),
           title:const Text('設定',style: TextStyle(fontSize: 20),),
           onTap:(){
             Navigator.of(context).pop();
             Navigator.of(context).push(
                 MaterialPageRoute(builder: (context){
                   return const StateUserSettings1();
                 })
             );
           },
         ),
       ],
     )
   );
  }
}

import 'package:flutter/material.dart';

Widget customtextform({
  required String lable,
   Widget? suffix,
  IconData? prefix,
  required bool ispssword,
  // Function? fun,
  TextEditingController ? controller,

}){
  return TextFormField(
              controller: controller,
              validator: (value) {
                if(value!.isEmpty){
                  return 'thes field must not empty';
                }else{
                  return null;
                }
                },
                // onChanged: (value){
                //   fun!();
                // },
                obscureText: ispssword,
              decoration: InputDecoration(
                label: Text(lable,style: TextStyle(
                  fontSize: 30
                ),),
                prefix: Icon(prefix),
                
                suffix: suffix,
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(10)
                // )
              ),
            );
}

Widget defultButton({
  required String text,
  required Function onTap
}){
  return InkWell(
    onTap: (){
      onTap();
    },
    child: Container(
      height: 65,
      width: double.infinity,
      decoration: BoxDecoration(
         color: Colors.lightBlue,
         borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(text,style: TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold
        ),),
      ),
    ),
  );
}


Widget catogerycustoum({
  required String image,
  required String text
}){
  return  Container(
                      width: 150,
                      height: 150,
                     child: Stack(
                      alignment: Alignment.bottomCenter,
                      children:[ 
                        Image(
                          image: NetworkImage(image)),
                            Container(
                              height: 35,
                              width: 150,
                              color: Colors.black.withOpacity(0.4),
                              child: Center(child: Text(text,style: TextStyle(
                                color: Colors.white,
                                fontSize: 25
                              ),)))
                      ]
                            ),
                    );
}

  
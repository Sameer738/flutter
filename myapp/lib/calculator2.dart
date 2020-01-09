import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';


class Calculator2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    //State is class and StatefulWidget is data type
    //just like list<string> that string will pass to the list.
    return _Calculator2();
  }
}

class _Calculator2 extends State<Calculator2> {
  String str="",op="",str1="";
  int a=0,b=0;
  int flag=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.redAccent,
          title: Text("Calculator2",style: TextStyle(fontSize: 25),),
       ),
        body: SafeArea(
         child: Column(
           children: <Widget>[
             Expanded(
               flex:2,
               child: Container(
                 //color: Colors.black12,
                 child: Text(str,style: TextStyle(fontSize: 50),),
                 alignment: Alignment.bottomRight,
               ),
             ),
             Expanded(
               flex: 3,
               child: Container(
                 child: Column(
                   children: <Widget>[
                      
                           Expanded(
                       child: Container(
                         child: Container(
                         child: Row(
                           children: <Widget>[
                             Expanded(
                               child: Container(
                                decoration: BoxDecoration(
                                   border: Border.all(width: 0.1),
                                 ),
                                child: SizedBox.expand(
                                  child: new RaisedButton(
                                    color: Colors.white,
                                    child: Text("AC",style: TextStyle(fontSize: 25),),
                                    onPressed: (){
                                      setState(() {
                                       str=""; 
                                       str1="";
                                       a=0;
                                       b=0;
                                       flag=0;
                                      });
                                    },
                                  ),
                                )
                               ),
                             ),
                             Expanded(
                               child: Container(
                                decoration: BoxDecoration(
                                   border: Border.all(width: 0.1),
                                 ),
                                child: SizedBox.expand(
                                  child: new RaisedButton(
                                    color: Colors.white,
                                    child: Icon(Icons.backspace),
                                    onPressed: (){
                                      setState(() {
                                       str=str.substring(0,str.length-1);
                                      });
                                    },
                                  ),
                                )
                               ),
                             ),
                             Expanded(
                               child: Container(
                                 decoration: BoxDecoration(
                                   border: Border.all(width: 0.1),
                                 ),
                                child: SizedBox.expand(
                                  child: new RaisedButton(
                                    color: Colors.white,
                                    child: Text("%",style: TextStyle(fontSize: 25),),
                                    onPressed: (){
                                      setState(() {
                                       a=int.parse(str); 
                                       str="";
                                       str1=str;
                                      op="%";
                                      });
                                    },
                                  ),
                                )
                               ),
                             ),
                             Expanded(
                               child: Container(
                                 decoration: BoxDecoration(
                                   border: Border.all(width: 0.1),
                                 ),
                                child: SizedBox.expand(
                                  child: new RaisedButton(
                                    color: Colors.white,
                                    child: Text("^",style: TextStyle(fontSize: 25),),
                                    onPressed: (){
                                      setState(() {
                                        
                                       a=int.parse(str);
                                       str="";
                                       
                                      op="^";
                                      });
                                    },
                                  ),
                                )
                               ),
                             ),
                           ],
                         ),
                       )
                       ),
                     ),
                     Expanded(
                       child: Container(
                         child: Row(
                           children: <Widget>[
                             
                             Expanded(
                               child: Container(
                                 decoration: BoxDecoration(
                                   border: Border.all(width: 0.1),
                                 ),
                                child: SizedBox.expand(
                                  child: new RaisedButton(
                                    color: Colors.white,
                                    child: Text("7",style: TextStyle(fontSize: 25),),
                                    onPressed: (){
                                      setState(() {
                                        
                                       str=str+"7"; 
                                      });
                                    },
                                  ),
                                )
                               ),
                             ),
                             Expanded(
                               child: Container(
                                decoration: BoxDecoration(
                                   border: Border.all(width: 0.1),
                                 ),
                                child: SizedBox.expand(
                                  child: new RaisedButton(
                                    color: Colors.white,
                                    child: Text("8",style: TextStyle(fontSize: 25),),
                                    onPressed: (){
                                      setState(() {
                                       str=str+"8"; 
                                      });
                                    },
                                  ),
                                )
                               ),
                             ),
                             Expanded(
                               child: Container(
                                 decoration: BoxDecoration(
                                   border: Border.all(width: 0.1),
                                 ),
                                child: SizedBox.expand(
                                  child: new RaisedButton(
                                    color: Colors.white,
                                    child: Text("9",style: TextStyle(fontSize: 25),),
                                    onPressed: (){
                                      setState(() {
                                       str=str+"9"; 
                                      });
                                    },
                                  ),
                                )
                               ),
                             ),
                             Expanded(
                               child: Container(
                                decoration: BoxDecoration(
                                   border: Border.all(width: 0.1),
                                 ),
                                child: SizedBox.expand(
                                  child: new RaisedButton(
                                    color: Colors.white,
                                    child: Text("/",style: TextStyle(fontSize: 25),),
                                    onPressed: (){
                                      setState(() {
                                       a=int.parse(str); 
                                       str="";
                                      op="/";
                                      });
                                    },
                                  ),
                                )
                               ),
                             ),
                           ],
                         ),
                       ),
                     ),
                     Expanded(
                       child: Container(
                         child: Container(
                         child: Row(
                           children: <Widget>[
                             Expanded(
                               child: Container(
                                decoration: BoxDecoration(
                                   border: Border.all(width: 0.1),
                                 ),
                                child: SizedBox.expand(
                                  child: new RaisedButton(
                                    color: Colors.white,
                                    child: Text("4",style: TextStyle(fontSize: 25),),
                                    onPressed: (){
                                      setState(() {
                                       str=str+"4"; 
                                      });
                                    },
                                  ),
                                )
                               ),
                             ),
                             Expanded(
                               child: Container(
                                decoration: BoxDecoration(
                                   border: Border.all(width: 0.1),
                                 ),
                                child: SizedBox.expand(
                                  child: new RaisedButton(
                                    color: Colors.white,
                                    child: Text("5",style: TextStyle(fontSize: 25),),
                                    onPressed: (){
                                      setState(() {
                                       str=str+"5"; 
                                      });
                                    },
                                  ),
                                )
                               ),
                             ),
                             Expanded(
                               child: Container(
                                 decoration: BoxDecoration(
                                   border: Border.all(width: 0.1),
                                 ),
                                child: SizedBox.expand(
                                  child: new RaisedButton(
                                    color: Colors.white,
                                    child: Text("6",style: TextStyle(fontSize: 25),),
                                    onPressed: (){
                                      setState(() {
                                       str=str+"6"; 
                                      });
                                    },
                                  ),
                                )
                               ),
                             ),
                             Expanded(
                               child: Container(
                                 decoration: BoxDecoration(
                                   border: Border.all(width: 0.1),
                                 ),
                                child: SizedBox.expand(
                                  child: new RaisedButton(
                                    color: Colors.white,
                                    child: Text("x",style: TextStyle(fontSize: 25),),
                                    onPressed: (){
                                      setState(() {
                                         flag++;
                                        if(flag==1){
                                           a=int.parse(str); 
                                           op="*";
                                        str = "";
                                        }
                                      else{
                                        if(op=="+")
                                        {
                                          b=int.parse(str); 
                                          a=(a+b);
                                        }
                                          if(op=="-")
                                        {
                                          b=int.parse(str); 
                                          a=(a-b);
                                        }
                                         if(op=="*")
                                        {
                                          b=int.parse(str); 
                                          a=(a*b);
                                        }
                                         if(op=="/")
                                        {
                                          b=int.parse(str); 
                                          a=(a/b) as int;
                                        }
                                        op="*";
                                        str = "";
                                      }
                                      });
                                    },
                                  ),
                                )
                               ),
                             ),
                           ],
                         ),
                       )
                       ),
                     ),
                     Expanded(
                       child: Container(
                         child: Container(
                         child: Row(
                           children: <Widget>[
                             Expanded(
                               child: Container(
                                decoration: BoxDecoration(
                                   border: Border.all(width: 0.1),
                                 ),
                                child: SizedBox.expand(
                                  child: new RaisedButton(
                                    color: Colors.white,
                                    child: Text("1",style: TextStyle(fontSize: 25),),
                                    onPressed: (){
                                      setState(() {
                                       str=str+"1"; 
                                      });
                                    },
                                  ),
                                )
                               ),
                             ),
                             Expanded(
                               child: Container(
                                decoration: BoxDecoration(
                                   border: Border.all(width: 0.1),
                                 ),
                                child: SizedBox.expand(
                                  child: new RaisedButton(
                                    color: Colors.white,
                                    child: Text("2",style: TextStyle(fontSize: 25),),
                                    onPressed: (){
                                      setState(() {
                                       str=str+"2"; 
                                      });
                                    },
                                  ),
                                )
                               ),
                             ),
                             Expanded(
                               child: Container(
                                 decoration: BoxDecoration(
                                   border: Border.all(width: 0.1),
                                 ),
                                child: SizedBox.expand(
                                  child: new RaisedButton(
                                    color: Colors.white,
                                    child: Text("3",style: TextStyle(fontSize: 25),),
                                    onPressed: (){
                                      setState(() {
                                       str=str+"3"; 
                                      });
                                    },
                                  ),
                                )
                               ),
                             ),
                             Expanded(
                               child: Container(
                                decoration: BoxDecoration(
                                   border: Border.all(width: 0.1),
                                 ),
                                child: SizedBox.expand(
                                  child: new RaisedButton(
                                    color: Colors.white,
                                    child: Text("-",style: TextStyle(fontSize: 25),),
                                    onPressed: (){
                                      setState(() {
                                        if(str=="")
                                        {
                                          str="-";
                                        }
                                        else{
                                          flag++;
                                        if(flag==1){
                                           a=int.parse(str); 
                                           op="-";
                                        str = "";
                                        }
                                      else{
                                        if(op=="+")
                                        {
                                          b=int.parse(str); 
                                          a=(a+b);
                                        }
                                          if(op=="-")
                                        {
                                          b=int.parse(str); 
                                          a=(a-b);
                                        }
                                         if(op=="*")
                                        {
                                          b=int.parse(str); 
                                          a=(a*b);
                                        }
                                         if(op=="/")
                                        {
                                          b=int.parse(str); 
                                          a=(a/b) as int;
                                        }
                                        op="-";
                                        str = "";
                                        }
                                        
                                      print(a);
                                      }
                                      
                                      });
                                    },
                                  ),
                                )
                               ),
                             ),
                           ],
                         ),
                       )
                       ),
                     ),
                     Expanded(
                       child: Container(
                         child: Container(
                         child: Row(
                           children: <Widget>[
                             Expanded(
                               child: Container(
                                decoration: BoxDecoration(
                                   border: Border.all(width: 0.1),
                                 ),
                                child: SizedBox.expand(
                                  child: new RaisedButton(
                                    color: Colors.white,
                                    child: Text("=",style: TextStyle(fontSize: 25),),
                                    onPressed: (){
                                      setState(() {

                                       b=int.parse(str); 
                                       str="";
                                      if(op=="+")
                                      {
                                        a=a+b;
                                        str=a.toString();
                                      }
                                      if(op=="-")
                                      {
                                         a=a-b;
                                        str=a.toString();
                                      }
                                      if(op=="*")
                                      {
                                         a=a*b;
                                        str=(a).toString();
                                      }
                                      if(op=="/")
                                      {
                                        str=(a/b).toString();
                                      }
                                      if(op=="%")
                                      {
                                         a=a%b;
                                        str=(a).toString();
                                      }
                                      if(op=="^")
                                      {
                                        a=pow(a,b);
                                        str=a.toString();
                                      }
                                      a=0;
                                      b=0;
                                      flag=0;
                                      if(str.contains("."))
                                      {
                                        String s=str.substring(str.indexOf("."),str.length-1);
                                        if(s.length>5)
                                        {
                                          str=str.substring(0,str.indexOf("."))+str.substring(str.indexOf(".")+4);
                                        }
                                      }
                                      
                                      });
                                    },
                                  ),
                                )
                               ),
                             ),
                             Expanded(
                               child: Container(
                                 decoration: BoxDecoration(
                                   border: Border.all(width: 0.1),
                                 ),
                                child: SizedBox.expand(
                                  child: new RaisedButton(
                                    color: Colors.white,
                                    child: Text("0",style: TextStyle(fontSize: 25),),
                                    onPressed: (){
                                      setState(() {
                                       str=str+"0"; 
                                      });
                                    },
                                  ),
                                )
                               ),
                             ),
                             Expanded(
                               child: Container(
                                 decoration: BoxDecoration(
                                   border: Border.all(width: 0.1),
                                 ),
                                child: SizedBox.expand(
                                  child: new RaisedButton(
                                    color: Colors.white,
                                    child: Text(".",style: TextStyle(fontSize: 25),),
                                    onPressed: (){
                                      setState(() {
                                       str=str+"."; 
                                      });
                                    },
                                  ),
                                )
                               ),
                             ),
                             Expanded(
                               child: Container(
                                 decoration: BoxDecoration(
                                   border: Border.all(width: 0.1),
                                 ),
                                child: SizedBox.expand(
                                  child: new RaisedButton(
                                    color: Colors.white,
                                    child: Text("+",style: TextStyle(fontSize: 25),),
                                    onPressed: (){
                                      setState(() {
                                        flag++;
                                        if(flag==1){
                                           a=int.parse(str); 
                                           op="+";
                                        str = "";
                                        }
                                      else{
                                        if(op=="+")
                                        {
                                          b=int.parse(str); 
                                          a=(a+b);
                                        }
                                          if(op=="-")
                                        {
                                          b=int.parse(str); 
                                          a=(a-b);
                                        }
                                         if(op=="*")
                                        {
                                          b=int.parse(str); 
                                          a=(a*b);
                                        }
                                         if(op=="/")
                                        {
                                          b=int.parse(str); 
                                          a=(a/b) as int;
                                        }
                                        op="+";
                                        str = "";
                                      print(a);
                                      }
                                      
                                      });
                                    },
                                  ),
                                )
                               ),
                             ),
                           ],
                         ),
                       )
                       ),
                     ),
                   ],
                 ),
               ),
             )
           ],
         ),
        ),
      );
  }
}

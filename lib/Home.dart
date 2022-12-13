import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:invoice_generator/DataModel.dart';
import 'package:invoice_generator/PDF.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController txtI_Num = TextEditingController();
  TextEditingController txtI_BF_Name = TextEditingController();
  TextEditingController txtI_BT_Name = TextEditingController();
  TextEditingController txtI_BF_Add = TextEditingController();
  TextEditingController txtI_BT_Add = TextEditingController();
  TextEditingController txtI_Date = TextEditingController();
  TextEditingController txtI_Due_Date = TextEditingController();
  TextEditingController txtI_Item = TextEditingController();
  TextEditingController txtI_Quantity = TextEditingController();
  TextEditingController txtI_Price = TextEditingController();
  String i_num = "";
  String? path;
  List<String> price=[];
  List item=[];
  List quantity=[];
  int total=0;
  List Total_Price=[];
  Widget bottomsheet() {
    return Container(
      height: 136,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      alignment: Alignment.topLeft,
      child: Stack(
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Choose Profile Photo",
              style: TextStyle(fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF555259)),
            ),
          ),
          const SizedBox(height: 30,),
          Row(
            children: [
              const SizedBox(width: 12,),
              Padding(
                padding: const EdgeInsets.only(top: 55),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        ImagePicker pick = ImagePicker();
                        XFile? img = await pick.pickImage(
                            source: ImageSource.camera);
                        setState(() {
                          path = img!.path;
                        });
                      },
                      child: Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(color: Colors.black12, width: 2)
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.camera_alt, color: Colors.black54,),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 12,),
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 55),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        ImagePicker pick2 = ImagePicker();
                        XFile? img2 = await pick2.pickImage(
                            source: ImageSource.gallery);
                        setState(() {
                          path = img2!.path;
                        });
                      },
                      child: Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(color: Colors.black12, width: 2)
                        ),
                        alignment: Alignment.center,
                        child: const Icon(Icons.image, color: Colors.black54,),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 15,),
          Row(
            children: [
              const SizedBox(width: 8,),
              Padding(
                padding: const EdgeInsets.only(top: 115),
                child: Column(
                  children: const [
                    Text(
                        "Camera",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black45
                        )
                    )
                  ],
                ),
              ),
              const SizedBox(width: 38,),
              Padding(
                padding: const EdgeInsets.only(top: 115),
                child: Column(
                  children: const [
                    Text(
                        "Gallery",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black45
                        )
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
  var valid = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: valid,
      child: WillPopScope(
        onWillPop: back,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Create Invoice Generator"),
              centerTitle: true,
              backgroundColor: Colors.red,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: InkWell(
                      onTap: (){
                        setState(() {
                          txtI_Num.clear();
                          txtI_BF_Add.clear();
                          txtI_BF_Name.clear();
                          txtI_BT_Add.clear();
                          txtI_BT_Name.clear();
                          txtI_Date.clear();
                          txtI_Due_Date.clear();
                          total=0;
                          item.clear();
                          quantity.clear();
                          price.clear();
                          path=null;
                        });
                      },
                      child: const Icon(Icons.refresh,color: Colors.white,size: 30,)
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding:  EdgeInsets.only(top: 15,left: 15),
                      child: Text(
                        "INVOICE",
                        style: TextStyle(color: Colors.black54, fontSize: 33),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12, left: 12, top: 6),
                    child: TextFormField(
                      controller: txtI_Num,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: const BorderSide(color: Colors.black54),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(color: Colors.black54),
                          ),
                        prefixIcon: const Icon(Icons.edit_outlined,color: Colors.black54,),
                       hintText: "Invoice Number",
                        labelStyle: const TextStyle(fontSize: 12,color: Colors.black54)
                      ),
                      validator: (value) {
                        if(value!.isEmpty)
                          {
                            return "Please Enter Your Invoice Number";
                          }
                        else
                          {
                            return null;
                          }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18,left: 15,right: 15),
                    child: InkWell(
                      onTap: (){
                        showModalBottomSheet(context: context, builder: (context) => bottomsheet(),);
                      },
                      child: path==null?Container(
                        height: 86,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black26)
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "+ Add Your Logo"
                        ),
                      )
                      : Container(
                        height: 215,
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black26)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Stack(
                            children: [
                              Image.file(File("$path")),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    path=null;
                                  });
                                },
                                  child: const Icon(Icons.delete_outline,color: Colors.red,size: 21,)
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15,right: 12,left: 12),
                    child: Divider(thickness: 1.5,),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15,left: 12),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Bill Form*",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12, left: 12, top: 12),
                    child: TextFormField(
                      controller: txtI_BF_Name,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: const BorderSide(color: Colors.black54),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(color: Colors.black54),
                          ),
                          hintText: "Who is this invoice form? (required)",
                          labelStyle: const TextStyle(fontSize: 12,color: Colors.black54)
                      ),
                      validator: (value) {
                        if(value!.isEmpty)
                        {
                          return "Please Enter Invoice Form";
                        }
                        else
                        {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12, left: 12, top: 15),
                    child: TextField(
                      controller: txtI_BF_Add,
                      keyboardType: TextInputType.streetAddress,
                      textInputAction: TextInputAction.next,
                      maxLines: 2,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: const BorderSide(color: Colors.black54),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(color: Colors.black54),
                          ),
                          hintText: "Address",
                          labelStyle: const TextStyle(fontSize: 12,color: Colors.black54),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15,left: 12),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Bill To*",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12, left: 12, top: 12),
                    child: TextFormField(
                      controller: txtI_BT_Name,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(color: Colors.black54),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide(color: Colors.black54),
                          ),
                          hintText: "Who is this invoice To? (required)",
                          labelStyle: TextStyle(fontSize: 12,color: Colors.black54)
                      ),
                      validator: (value) {
                        if(value!.isEmpty)
                        {
                          return "Please Enter Invoice To";
                        }
                        else
                        {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12, left: 12, top: 15),
                    child: TextField(
                      controller: txtI_BT_Add,
                      keyboardType: TextInputType.streetAddress,
                      textInputAction: TextInputAction.next,
                      maxLines: 2,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: const BorderSide(color: Colors.black54),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(color: Colors.black54),
                          ),
                          hintText: "Address",
                          labelStyle: const TextStyle(fontSize: 12,color: Colors.black54),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15,right: 12,left: 12),
                    child: Divider(thickness: 1.5,),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15,left: 12),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Date",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12, top: 5),
                    child: TextFormField(
                      controller: txtI_Date,
                      style: const TextStyle(color: Color(0xFF555259)),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(top: 20),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFF555259)),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFF555259)),
                            borderRadius: BorderRadius.circular(9)
                        ),
                        prefixIcon: const Icon(Icons.calendar_month, color: Colors.black54,),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Date";
                        }
                        else {
                          return null;
                        }
                      },
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.fromSwatch(
                                  primarySwatch: Colors.blueGrey,
                                  backgroundColor: Colors.lightBlue,
                                  cardColor: Colors.white,
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );

                        if (pickedDate != null) {
                          String formattedDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                          setState(
                                () {
                              txtI_Date.text = formattedDate;
                            },
                          );
                        } else {
                          print("Date is not selected");
                        }
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15,left: 12),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Due Date",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12, top: 5),
                    child: TextFormField(
                      controller: txtI_Due_Date,
                      style: const TextStyle(color: Color(0xFF555259)),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(top: 20),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFF555259)),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFF555259)),
                            borderRadius: BorderRadius.circular(9)
                        ),
                        prefixIcon: const Icon(Icons.calendar_month, color: Colors.black54,),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Due Date";
                        }
                        else {
                          return null;
                        }
                      },
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.fromSwatch(
                                  primarySwatch: Colors.blueGrey,
                                  backgroundColor: Colors.lightBlue,
                                  cardColor: Colors.white,
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (pickedDate != null) {
                          String formattedDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                          setState(
                                () {
                              txtI_Due_Date.text = formattedDate;
                            },
                          );
                        } else {
                          print("Date is not selected");
                        }
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15,left: 12),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Items*",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18
                        ),
                      ),
                    ),
                  ),
                  (item.isEmpty||quantity.isEmpty||price.isEmpty||Total_Price.isEmpty)? Container():
                  Column(
                    children: item.asMap().entries.map((e) => items("${item[e.key]}".toString(), "${price[e.key]}".toString(), "${quantity[e.key]}".toString(), "${Total_Price[e.key]}".toString(),e.key),).toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12, top: 15),
                    child: InkWell(
                      onTap: (){
                        showDialog(context: context, builder: (context) => Add_Items(),);
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black54,)
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "+ Add To Item",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 21
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15,right: 12,left: 12),
                    child: Divider(thickness: 1.5,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15,right: 12,left: 12),
                    child: Total(),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15,right: 12,left: 12),
                    child: Divider(thickness: 1.5,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          minimumSize: const Size(115, 60),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                      ),
                      onPressed: (){
                        showDialog(context: context, builder: (context) => menu(),);
                      },
                      child: const Text("Submit",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget Add_Items()
  {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
      content: Container(
        height: 350,
        width: 600,
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Item",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Container(
                height: 45,
                alignment: Alignment.center,
                child: TextFormField(
                  controller: txtI_Item,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Colors.black54),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: const BorderSide(color: Colors.black54),
                      ),
                    hintText: "Ex.Mango"
                  ),
                  validator: (value) {
                    if(value!.isEmpty)
                    {
                      return "Please Enter Invoice Item";
                    }
                    else
                    {
                      return null;
                    }
                  },
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Quantity",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Container(
                height: 45,
                alignment: Alignment.center,
                child: TextFormField(
                  controller: txtI_Quantity,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Colors.black54),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: const BorderSide(color: Colors.black54),
                    ),
                      hintText: "Ex.5"
                  ),
                  validator: (value) {
                    if(value!.isEmpty)
                    {
                      return "Please Enter Invoice Quantity";
                    }
                    else
                    {
                      return null;
                    }
                  },
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Price",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                height: 45,
                alignment: Alignment.center,
                child: TextFormField(
                  controller: txtI_Price,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Colors.black54),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: const BorderSide(color: Colors.black54),
                    ),
                      hintText: "Ex.30"
                  ),
                  validator: (value) {
                    if(value!.isEmpty)
                    {
                      return "Please Enter Invoice Price";
                    }
                    else
                    {
                      return null;
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: (){
                    setState(() {
                        total=0;
                        item.add(txtI_Item.text.toString());
                        quantity.add(txtI_Quantity.text.toString());
                        price.add(txtI_Price.text.toString());
                        Total_Price.add("${int.parse("${txtI_Quantity.text}")*int.parse("${txtI_Price.text}")}");
                        print("$item");
                        print("$quantity");
                        print("$price");
                        print("$Total_Price");
                        for(int i=0; i<price.length; i++)
                        {
                          total=total+int.parse("${Total_Price[i]}");
                        }
                        print(total);
                        Navigator.pop(context);
                        txtI_Item.clear();
                        txtI_Quantity.clear();
                        txtI_Price.clear();
                      });
                },
                child: const Text("Save",style: TextStyle(color: Colors.white),),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget Update_Items([String? txtIN,String? txtIP,String? txtIQ,int i=0])
  {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
      content: Container(
        height: 350,
        width: 600,
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Item",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                height: 45,
                alignment: Alignment.center,
                child: TextFormField(
                  controller: txtI_Item,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(color: Colors.black54),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide(color: Colors.black54),
                      ),
                      hintText: "Ex.Mango"
                  ),
                  validator: (value) {
                    if(value!.isEmpty)
                    {
                      return "Please Enter Invoice Item";
                    }
                    else
                    {
                      return null;
                    }
                  },
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Quantity",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                height: 45,
                alignment: Alignment.center,
                child: TextFormField(
                  controller: txtI_Quantity,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Colors.black54),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: const BorderSide(color: Colors.black54),
                      ),
                      hintText: "Ex.5"
                  ),
                  validator: (value) {
                    if(value!.isEmpty)
                    {
                      return "Please Enter Invoice Quantity";
                    }
                    else
                    {
                      return null;
                    }
                  },
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Price",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                height: 45,
                alignment: Alignment.center,
                child: TextFormField(
                  controller: txtI_Price,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Colors.black54),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: const BorderSide(color: Colors.black54),
                      ),
                      hintText: "Ex.30"
                  ),
                  validator: (value) {
                    if(value!.isEmpty)
                    {
                      return "Please Enter Invoice Price";
                    }
                    else
                    {
                      return null;
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: (){
                  setState(() {
                    total=0;
                    item.add(txtI_Item.text.toString());
                    quantity.add(txtI_Quantity.text.toString());
                    price.add(txtI_Price.text.toString());
                    Total_Price.add("${int.parse("${txtI_Quantity.text}")*int.parse("${txtI_Price.text}")}");
                    print("==> $i");
                    // item.insert(i, "Jay");
                    // quantity.insert(i, txtI_Quantity.text.toString());
                    // price.insert(i, txtI_Price.text.toString());
                    // Total_Price.insert(i!, Total_PriceString());
                    print("$item");
                    print("$quantity");
                    print("$price");
                    print("$Total_Price");
                    for(int i=0; i<price.length; i++)
                    {
                      total=total+int.parse("${Total_Price[i]}");
                    }
                    print(total);
                    Navigator.pop(context);
                    txtI_Item.clear();
                    txtI_Quantity.clear();
                    txtI_Price.clear();
                  });
                },
                child: const Text("Save",style: TextStyle(color: Colors.white),),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget items(String i_n,String i_p,String i_q,String i_t,int index)
  {
    return Padding(
      padding: const EdgeInsets.only(top: 15,left: 15,right: 15),
      child: InkWell(
        onTap: (){
          showDialog(context: context, builder: (context) => Update_Items(txtI_Item.text = i_n,txtI_Price.text = i_p,txtI_Quantity.text = i_q,index),);
          print("Tap");
          // showDialog(context: context, builder: (context) => Add_Items(),);
        },
        child: Container(
          height: 75,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black12,width: 2)
          ),
          alignment: Alignment.topCenter,
          child: Stack(
            children: [
              ListTile(
                title: Text("$i_q x $i_n"),
                subtitle: const Text("Total"),
                trailing: Padding(
                  padding: const EdgeInsets.only(top: 9),
                  child: Column(
                    children: [
                        Text("@ $i_p",style: TextStyle(color: Colors.black26),),
                      const SizedBox(
                          height: 6,
                        ),
                        Text("Rs. $i_t",style: TextStyle(color: Colors.black),),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        item.removeAt(index);
                        price.removeAt(index);
                        quantity.removeAt(index);
                        total=total-int.parse("${Total_Price[index]}");
                        Total_Price.removeAt(index);
                      });
                    },
                      child: Icon(Icons.delete_outline,color: Colors.red,size: 21,)
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget Total()
  {
    return Container(
        height: 60,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black26,width: 1.5),
            borderRadius: BorderRadius.circular(12)
        ),
        alignment: Alignment.topCenter,
        child: ListTile(
          title: const Text("Total",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
          trailing: Text("Rs. $total",style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 21),),
        )
    );
  }
  void alert() {
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text("Are You Sure Exit"),
        actions: [
          TextButton(
            onPressed: (){
              exit(0);
            },
            child: const Text("Yes",style: TextStyle(color: Colors.red),),
          ),
          TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: const Text("No",style: TextStyle(color: Colors.green),),

          )
        ],
      );
    });
  }
  Future<bool> back() async {
    alert();
    return await false;
  }
  Widget menu() {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
      title: const Text("Choice Any One"),

      content: Container(
        height: 200,
        width: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton.extended(
              onPressed: (){
                DataModal d1 = DataModal(
                    in_num: txtI_Num.text.toString(),
                    logo_path: path,
                    bf_name: txtI_BF_Name.text.toString(),
                    bf_add: txtI_BF_Add.text.toString(),
                    bt_name: txtI_BT_Name.text.toString(),
                    bt_add: txtI_BT_Add.text.toString(),
                    f_date: txtI_Date.text.toString(),
                    due_date: txtI_Due_Date.text.toString(),
                    total: total.toString(),
                    items: item,
                    prices: price,
                    quntitys: quantity,
                    totals: Total_Price
                );
                if(valid.currentState!.validate())
                {
                  if(path!=null)
                  {
                    Navigator.pushNamed(context, 'Preview',arguments: d1);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Download PDF(Path=>Storage/Android/data/com.example.invoice_generator/files)"),duration: Duration(seconds: 6),),);
                  }
                  else
                  {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Select Any Logo"),duration: Duration(seconds: 6),),);
                  }
                }
                else
                {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Fill All Detail"),duration: Duration(seconds: 6),),);
                }
              },
              label: const Text("Preview"),
              icon: const Icon(Icons.remove_red_eye_outlined),
              backgroundColor: Colors.red,
            ),
            FloatingActionButton.extended(
              onPressed: (){
                DataModal d1 = DataModal(
                  in_num: txtI_Num.text.toString(),
                  logo_path: path,
                  bf_name: txtI_BF_Name.text.toString(),
                  bf_add: txtI_BF_Add.text.toString(),
                  bt_name: txtI_BT_Name.text.toString(),
                  bt_add: txtI_BT_Add.text.toString(),
                  f_date: txtI_Date.text.toString(),
                  due_date: txtI_Due_Date.text.toString(),
                  total: total.toString(),
                  items: item,
                  prices: price,
                  quntitys: quantity,
                  totals: Total_Price
                );
                if(valid.currentState!.validate())
                  {
                    if(path!=null)
                      {
                        PDF(d1);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Download PDF(Path=>Storage/Android/data/com.example.invoice_generator/files)"),duration: Duration(seconds: 6),),);
                      }
                    else
                      {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Select Any Logo"),duration: Duration(seconds: 6),),);
                      }
                  }
                else
                  {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Fill All Detail"),duration: Duration(seconds: 6),),);
                  }
              },
              label: const Text("Download PDF"),
              icon: const Icon(Icons.download),
              backgroundColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

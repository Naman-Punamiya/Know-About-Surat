import 'package:flutter/material.dart';

card(BuildContext context, String name, String pic, String info,
    String location, String price, Color bgColor, Color desColor) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              getInfo(name, pic, info, location, price, bgColor, desColor),
        ),
      );
    },
    child: Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.white,
            width: 1,
            style: BorderStyle.solid,
            strokeAlign: BorderSide.strokeAlignCenter),
        boxShadow: const [
          BoxShadow(
              color: Colors.black,
              offset: Offset.zero,
              blurRadius: 8,
              spreadRadius: 0,
              blurStyle: BlurStyle.outer)
        ],
        image: DecorationImage(
          image: AssetImage(pic),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: "Rubik",
            fontWeight: FontWeight.w600,
            shadows: [
              Shadow(color: Colors.black, offset: Offset.zero, blurRadius: 1.6)
            ],
          ),
        ),
      ),
    ),
  );
}

getInfo(String name, String picpath, String description, String location,
    String price, Color bgColor, Color desColor) {
  return Scaffold(
    backgroundColor: bgColor,
    appBar: AppBar(
      title: Text(name),
      centerTitle: true,
      backgroundColor: const Color(0xfffb8818),
      foregroundColor: Colors.black,
    ),
    body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 250,
              width: 500,
              padding: const EdgeInsets.all(8.0),
              child: Image(
                image: AssetImage(picpath),
                fit: BoxFit.fitHeight,
              )),
          const SizedBox(
            height: 12,
          ),
          Text(
            "Description :",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: desColor, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            description,
            style: TextStyle(color: desColor, fontSize: 16),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            "Location :",
            style: TextStyle(
                color: desColor, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            location,
            style: TextStyle(color: desColor, fontSize: 16),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            "Price :",
            style: TextStyle(
                color: desColor, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            price,
            style: TextStyle(color: desColor, fontSize: 16),
          ),
        ],
      ),
    ),
  );
}

places(BuildContext context, String name, String pic) {
  return Container(
    padding: const EdgeInsets.all(8),
    margin: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      border: Border.all(
          color: Colors.white,
          width: 1,
          style: BorderStyle.solid,
          strokeAlign: BorderSide.strokeAlignCenter),
      boxShadow: const [
        BoxShadow(
            color: Colors.black,
            offset: Offset.zero,
            blurRadius: 8,
            spreadRadius: 0,
            blurStyle: BlurStyle.outer)
      ],
      image: DecorationImage(
        image: AssetImage(pic),
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Align(
      alignment: Alignment.bottomLeft,
      child: Text(
        name,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: "Rubik",
          fontWeight: FontWeight.w600,
          shadows: [
            Shadow(color: Colors.black, offset: Offset.zero, blurRadius: 1.6)
          ],
        ),
      ),
    ),
  );
}

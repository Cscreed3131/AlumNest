import 'package:flutter/material.dart';

class AlumniItem {
  final int id;
  final String imgUrl;
  final String name;
  final String branch;
  final int year;
  final String linkedIn;
  final String mail;

  const AlumniItem(
    this.id,
    this.imgUrl,
    this.name,
    this.branch,
    this.year,
    this.linkedIn,
    this.mail,
  );
}

const List<AlumniItem> alumniDetails = [
  AlumniItem(
      1, 'assets/images/image3.png', 'John Doe', 'CSE', 2024, "Link", "Link"),
  AlumniItem(
      2, 'assets/images/image3.png', 'Johwwn Doe', 'EEE', 2023, "Link", "Link"),
  AlumniItem(3, 'assets/images/image3.png', 'Jowwwehn Doe', 'ECE', 2019, "Link",
      "Link"),
  AlumniItem(
      4, 'assets/images/image3.png', 'Johadn Doe', 'CSE', 2024, "Link", "Link"),
  AlumniItem(
      5, 'assets/images/image3.png', 'Jdohn Doe', 'MECH', 2024, "Link", "Link"),
  AlumniItem(6, 'assets/images/image3.png', 'John Dadoe adwdwdwd', 'CVIL', 2020,
      "Link", "Link"),
  AlumniItem(
      7, 'assets/images/image3.png', 'Jdaohn Doe', 'CSE', 2020, "Link", "Link"),
  AlumniItem(
      8, 'assets/images/image3.png', 'Joddhn Doe', 'CSE', 2021, "Link", "Link"),
  AlumniItem(9, 'assets/images/image3.png', 'Joehn Dq2oe', 'ECE', 2022, "Link",
      "Link"),
  AlumniItem(10, 'assets/images/image3.png', 'Joahn Doe', 'MECH', 2018, "Link",
      "Link"),
];

TextStyle appBarTextSyle = const TextStyle(
  fontFamily: 'IBMPLexMono',
  fontSize: 25,
  fontWeight: FontWeight.bold,
);

InputDecoration formInputDecoration(String name) => InputDecoration(
      labelText: name,
      alignLabelWithHint: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );

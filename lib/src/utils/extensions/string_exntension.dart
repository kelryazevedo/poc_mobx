
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

extension StringExtension on String {
  String get firstLetter {
    if (this != null)
      return this[0].toUpperCase();
    else
      return null;
  }

  String get firstLetterToUpperCase {
    if (this != null)
      return this[0].toUpperCase() + this.substring(1);
    else
      return null;
  }

  String get firstWord {
    List<String> words = this.split(' ');
    if (words.length > 0) {
      return words[0];
    } else {
      return this;
    }
  }

  bool get isNotNullOrEmpty {
    return this != null && this.isNotEmpty;
  }

  String get toBase64 {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    return stringToBase64.encode(this);
  }

  String get fromBase64 {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    return stringToBase64.decode(this);
  }

  String get cleanString {
    return this.replaceAll(new RegExp(r'[^\w\s]+'), '');
  }

  String get cleanStringAndSpaces {
    return this.replaceAll(new RegExp(r'[^\w\s]+'), '').replaceAll(' ', '');
  }

  bool get isValidEmail {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool get isValidCpfCnpj {
    return RegExp(
            r'^(\d{3}\.\d{3}\.\d{3}\-\d{2}$)|(^\d{2}\.\d{3}\.\d{3}\/\d{4}\-\d{2})$')
        .hasMatch(this);
  }

  bool get isValidCPF {
    List<int> sanitizedCPF = this
        .replaceAll(new RegExp(r'\.|-'), '')
        .split('')
        .map((String digit) => int.parse(digit))
        .toList();
    return !blacklistedCPF(sanitizedCPF.join()) &&
        sanitizedCPF[9] ==
            gerarDigitoVerificador(sanitizedCPF.getRange(0, 9).toList()) &&
        sanitizedCPF[10] ==
            gerarDigitoVerificador(sanitizedCPF.getRange(0, 10).toList());
  }

  int gerarDigitoVerificador(List<int> digits) {
    int baseNumber = 0;
    for (var i = 0; i < digits.length; i++) {
      baseNumber += digits[i] * ((digits.length + 1) - i);
    }
    int verificationDigit = baseNumber * 10 % 11;
    return verificationDigit >= 10 ? 0 : verificationDigit;
  }

  bool blacklistedCPF(String cpf) {
    return cpf == '00000000000' ||
        cpf == '11111111111' ||
        cpf == '22222222222' ||
        cpf == '33333333333' ||
        cpf == '44444444444' ||
        cpf == '55555555555' ||
        cpf == '66666666666' ||
        cpf == '77777777777' ||
        cpf == '88888888888' ||
        cpf == '99999999999';
  }

  bool get isValidCelular {
    return RegExp(r'^\([1-9]{2}\) [0-9]{5}\-[0-9]{4}$').hasMatch(this);
  }

//  bool compareStrings(String text) {
//    return this
//        .removerAcentos
//        .toLowerCase()
//        .contains(text.removerAcentos.toLowerCase());
//  }

//  String get removerAcentos {
//    return removeDiacritics(this);
//  }

  String capitalize({bool allWords}) {
    if (this == null || this.isEmpty) {
      return '';
    }
    var input = this.toLowerCase();
    if (allWords != null && allWords == true) {
      List<String> words = input.split(' ');
      var capitalized = words.map((word) {
        if (word.isEmpty) {
          return '';
        }
        return word[0].toUpperCase() + word.substring(1);
      }).join(' ');
      return capitalized;
    } else {
      return input[0].toUpperCase() + input.substring(1);
    }
  }

  DateTime toDate({@required String format}) {
    if (this == null) {
      return null;
    }
    return DateFormat(format).parse(this);
  }

  T getEnumFromString<T>(Iterable<T> values) {
    return values.firstWhere((type) => type.toString().split(".").last == this,
        orElse: () => null);
  }



  normalize(String text) {
    return text.replaceAll(" ", "+");
  }


  bool isValidDate() {
    try {
      List<String> diaMesAno = this.split('/');

      final y = int.parse(diaMesAno[2]);
      final m = int.parse(diaMesAno[1].padLeft(2, '0'));
      final d = int.parse(diaMesAno[0].padLeft(2, '0'));

      return d > 0 && d < 32 && m > 0 && m < 13 && (y > 1900 && y < 3000);
    } catch (e) {
      return false;
    }

    return false;
  }

  String toOriginalFormatString(DateTime dateTime) {
    final y = dateTime.year.toString().padLeft(4, '0');
    final m = dateTime.month.toString().padLeft(2, '0');
    final d = dateTime.day.toString().padLeft(2, '0');
    return "$y-$m-$d";
  }

  String setMask({@required String mask}) {
    if (this != null) {
      String text = this.cleanStringAndSpaces;
      int maskItemCount = 0;
      String maskedString = '';
      for (var i = 0; i < mask.length; i++) {
        if (mask[i] == '#')
          maskedString += text[i - maskItemCount];
        else {
          maskedString += mask[i];
          maskItemCount++;
        }
      }
      return maskedString;
    } else {
      return null;
    }
  }

  isNumeric() => num.tryParse(this) != null;

  static num tryParse(String input) {
    String source = input.trim();
    return int.tryParse(source) ?? double.tryParse(source);
  }
}

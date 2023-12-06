import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loop/model/count.dart';
import 'package:provider/provider.dart';

class AppLandingViewModel {
  // Add your state and logic here

  int? randomNumber;
  bool? success;
  bool byHour = false;

  generateRandomNumber(BuildContext context, int count) {
    Random random = Random();
    randomNumber = random.nextInt(byHour ? 24 : 60);
    if (randomNumber ==
        (byHour ? DateTime.now().hour : DateTime.now().second)) {
      Provider.of<Count>(context, listen: false).updateData();
      success = true;
    } else {
      success = false;
    }
  }
}

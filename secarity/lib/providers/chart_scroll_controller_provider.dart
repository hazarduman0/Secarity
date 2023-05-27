import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChartController extends ChangeNotifier {
  double _page = 0;

  double get page => _page;

  PageController pageController;

  ChartController({required this.pageController}) {
    pageController.addListener(() {
      changePage(pageController.page!);
    });
  }

  changePage(double page) {
    _page = page;
    notifyListeners();
  }
}

final chartControllerProvider =
    ChangeNotifierProvider.family<ChartController, PageController>(
        (ref, pageController) =>
            ChartController(pageController: pageController));

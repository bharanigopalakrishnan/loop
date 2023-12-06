import 'package:flutter/material.dart';
import 'package:loop/components/app_landing/app_landing.dart';
import 'package:loop/components/app_landing/app_landing_view_model.dart';
import 'package:loop/model/count.dart';
import 'package:provider/provider.dart';

class AppLandingView extends State<AppLanding> {
  late AppLandingViewModel _viewModel;
  AppLandingView() {
    _viewModel = AppLandingViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75),
        child: titleSection(),
      ),
      backgroundColor: Colors.white,
      body: Consumer<Count>(
        builder: (BuildContext context, Count value, Widget? child) {
          return body(value);
        },
      ),
    );
  }

  Widget titleSection() {
    return Container(
        padding: const EdgeInsets.only(left: 15, top: 15),
        alignment: Alignment.centerLeft,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      )),
                  const Text("Loop",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                      )),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _viewModel.byHour = !_viewModel.byHour;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(6)),
                  margin: const EdgeInsets.only(right: 20),
                  child: Text(
                    _viewModel.byHour ? "By hour" : "By seconds",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Widget body(Count value) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedSwitcher(
                  switchInCurve: Curves.linear,
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    _viewModel.success == true ? "Success" : "Try Again...",
                    key: ValueKey<bool>(_viewModel.success == true),
                    style: const TextStyle(color: Colors.black, fontSize: 30),
                  ),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    "Total Success count ${value.data}",
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _viewModel.generateRandomNumber(
                            context, value.data ?? 0);
                      });
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height / 4,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Text(
                          "Generate random number",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 4,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        (_viewModel.randomNumber ?? "Random number").toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

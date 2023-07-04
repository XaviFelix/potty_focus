import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:potty_focus/data_model/my_data_model.dart';
import 'package:potty_focus/screens/app_vault.dart';

class MyTimerWidget extends StatefulWidget {

  const MyTimerWidget({
    super.key,
  });

  @override
  State<MyTimerWidget> createState() => _MyTimerWidgetState();
}

class _MyTimerWidgetState extends State<MyTimerWidget> {
  final CountDownController _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    MyDataModel myDataModel = MyDataModel();
    myDataModel.loadApps();
    return Column(
        children: [
          CircularCountDownTimer(
              onComplete: () {
                myDataModel.setTimerRunning(false);

                //reset Timer
                _controller.reset();

                //UnlockAllApps
                myDataModel.unlockAllApps();
                //myDataModel.printAppLockState();
              },
              autoStart: false,
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 2,
              strokeWidth: 20.0,
              strokeCap: StrokeCap.round,
              textStyle: const TextStyle(
                  fontSize: 33.0, color: Colors.white, fontWeight: FontWeight.bold),

              duration: 600, //600
              initialDuration: 0, //0
              isReverse: true,
              isReverseAnimation: false,
              isTimerTextShown: true,
              controller: _controller,
              fillColor: Colors.purple,
              ringColor: Colors.white24
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      _controller.start();
                      myDataModel.setTimerRunning(true);
                    },
                    child: const Text('Start')
                ),
                const SizedBox(width: 10,),
                ElevatedButton(
                    onPressed: () {
                      _controller.reset();
                      myDataModel.setTimerRunning(false);
                      //myDataModel.setResetStatus(false);
                      myDataModel.unlockAllApps();
                    },
                    child: const Text('Reset')
                ),
              ]
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AppVault(myDataModel: myDataModel,))//Route to appVault)
                );
              },
              child: const Text('Open Vault')
          ),

          //Debug button
          // ElevatedButton(
          //   onPressed: () {
          //     myDataModel.printAppLockState();
          //   },
          //   child: const Text("Debug Button"),
          // ),
        ]
    );
  }
}
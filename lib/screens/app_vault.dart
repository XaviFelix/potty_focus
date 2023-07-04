import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:potty_focus/data_model/my_data_model.dart';

class AppVault extends StatefulWidget {

  final MyDataModel myDataModel;

  const AppVault({
    super.key,
    required this.myDataModel,
  });

  @override
  State<AppVault> createState() => _AppVaultState();
}

class _AppVaultState extends State<AppVault> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade100,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("App List"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(5),
        itemCount: widget.myDataModel.listOfSystemApps.length,
        itemBuilder: (context, index) {
          final currentApp = widget.myDataModel.listOfSystemApps[index];
          final isLocked = widget.myDataModel.lockStatusMap[currentApp.packageName] ?? false;

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.purple,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 14,
                    ),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 20.0,
                          offset: const Offset(5, 5),
                        )
                      ],
                    ),
                    child: currentApp is ApplicationWithIcon
                        ? CircleAvatar(
                      backgroundImage: MemoryImage(currentApp.icon),
                      backgroundColor: Colors.purple[200],
                    ) :
                    const CircleAvatar(
                      backgroundColor: Colors.black,
                      child: Text("Error"),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentApp.appName,
                        ),
                        Text(
                          "${currentApp.versionName}",
                        )
                      ],
                    ),
                  ),

                  //This will be the switch that disables selected app
                  Switch(
                    activeColor: Colors.deepPurple,
                    value: isLocked,
                    onChanged: (value) {
                      setState(() {
                        widget.myDataModel.setLockStatusCurrentApp(currentApp, value);
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

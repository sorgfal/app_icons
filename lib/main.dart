import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Material App Bar'),
          ),
          body: AppList()),
    );
  }
}

class AppList extends StatelessWidget {
  const AppList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DeviceApps.getInstalledApplications(
          includeAppIcons: true,
          includeSystemApps: true,
          onlyAppsWithLaunchIntent: false),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return ListView(
              children: [
                for (var a in snapshot.data ?? <Application>[])
                  ListTile(
                    trailing: Image.memory((a as ApplicationWithIcon).icon),
                  )
              ],
            );

          default:
            return Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'nurse_list_screen.dart';
import 'care_schedule_screen.dart';
import 'nurse_profile_screen.dart';

class NurseMainTabs extends ConsumerStatefulWidget {
  const NurseMainTabs({Key? key}) : super(key: key);

  @override
  ConsumerState<NurseMainTabs> createState() => _NurseMainTabsState();
}

class _NurseMainTabsState extends ConsumerState<NurseMainTabs> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const NurseListScreen(),
      CareScheduleScreen(onSubmitSuccess: () {}),
      const NurseProfileScreen(),
    ];

    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.list_alt_rounded),
            label: "Elders",
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_rounded),
            label: "Schedules",
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}
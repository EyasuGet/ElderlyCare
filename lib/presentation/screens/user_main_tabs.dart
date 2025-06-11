import 'package:elderly_care/presentation/screens/user_task_screen.dart';
import 'package:elderly_care/presentation/screens/user_profile_screen.dart';
import 'package:elderly_care/application/state/schedule_state.dart';
import 'package:elderly_care/domain/models/schedule_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class UserMainTabs extends ConsumerStatefulWidget {
  const UserMainTabs({Key? key}) : super(key: key);

  @override
  ConsumerState<UserMainTabs> createState() => _UserMainTabsState();
}

class _UserMainTabsState extends ConsumerState<UserMainTabs> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Optionally prefetch tasks on startup
    Future.microtask(() {
      ref.read(scheduleViewModelProvider.notifier).onEvent(ScheduleEvent.fetchTasks);
      
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const UserHomeScreen(),
      UserProfileScreen(
        onLogoutClick: () {
          context.go('/signup');
        },
      )
    ];  

    return Scaffold(
      body: tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (int idx) {
          setState(() {
            _selectedIndex = idx;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
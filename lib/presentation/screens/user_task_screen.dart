import 'package:elderly_care/domain/models/schedule_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserHomeScreen extends ConsumerWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  String extractDateOnly(String? isoString) {
    if (isoString == null) return '--';
    if (isoString.contains('T')) {
      return isoString.split('T')[0];
    }
    return isoString.length >= 10 ? isoString.substring(0, 10) : isoString;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scheduleViewModelProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFCAE7E5),
      appBar: AppBar(
        title: const Text('Time Schedule'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1C6B66),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : state.error != null
                ? Center(child: Text("Error: ${state.error}"))
                : (state.tasks == null || state.tasks?.isEmpty == true)
                    ? const Center(child: Text("No tasks available"))
                    : ListView(
                        children: state.tasks!
                            .map(
                              (task) => _ScheduleCard(
                                dotColor: _getDotColor(task.schedule),
                                title: task.schedule,
                                subText: task.frequency ?? '--',
                                startDate: extractDateOnly(task.startTime),
                                endDate: extractDateOnly(task.endTime),
                              ),
                            )
                            .toList(),
                      ),
      ),
    );
  }
}

Color _getDotColor(String schedule) {
  switch (schedule.toLowerCase()) {
    case 'medication':
      return const Color(0xFFFFA500);
    case "doctor's appointment":
    case 'exercise':
      return const Color(0xFF00C853);
    default:
      return Colors.grey;
  }
}

class _ScheduleCard extends StatelessWidget {
  final Color dotColor;
  final String title;
  final String subText;
  final String? startDate;
  final String? endDate;

  const _ScheduleCard({
    required this.dotColor,
    required this.title,
    required this.subText,
    this.startDate,
    this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Card(
            color: const Color(0xFFEFF7F6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text(subText, style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                      Icon(Icons.close, color: Colors.red, size: 20),
                      const SizedBox(width: 8),
                      Icon(Icons.check, color: Colors.green, size: 20),
                    ],
                  ),
                  Row(
                    children: [
                      const Spacer(flex: 1),
                      Column(
                        children: [
                          const Text("Start", style: TextStyle(fontSize: 10, color: Color(0xFF1C6B66), fontWeight: FontWeight.bold)),
                          Text(startDate ?? '--', style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        width: 1,
                        height: 40,
                        color: Colors.grey,
                      ),
                      Column(
                        children: [
                          const Text("End", style: TextStyle(fontSize: 10, color: Color(0xFF1C6B66), fontWeight: FontWeight.bold)),
                          Text(endDate ?? '--', style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                      const Spacer(flex: 1),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
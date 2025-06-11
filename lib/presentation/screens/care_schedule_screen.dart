import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../application/providers/viewmodel_providers.dart';
import '../../application/events/care_schedule_event.dart';

class CareScheduleScreen extends ConsumerStatefulWidget {
  final VoidCallback? onSubmitSuccess;

  const CareScheduleScreen({
    Key? key,
    this.onSubmitSuccess,
  }) : super(key: key);

  @override
  ConsumerState<CareScheduleScreen> createState() => _CareScheduleScreenState();
}

class _CareScheduleScreenState extends ConsumerState<CareScheduleScreen> {
  bool showFrequencyDropdown = false;
  bool showPostToDropdown = false;
  bool showConfirmDialog = false;
  final frequencyOptions = ["Every 8hrs", "Daily", "Weekly", "Monthly"];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(careScheduleViewModelProvider.notifier).fetchUserList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(careScheduleViewModelProvider.notifier);
    final state = ref.watch(careScheduleViewModelProvider);

    // Show confirm dialog
    if (showConfirmDialog) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Confirm Submission"),
            content: const Text("Are you sure you want to submit this care schedule?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() => showConfirmDialog = false);
                },
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() => showConfirmDialog = false);
                  viewModel.handleEvent(CareScheduleEventOnSubmit());
                },
                child: const Text("Confirm"),
              ),
            ],
          ),
        );
      });
    }

    // Success - show message, reset form, stay on page
    if (state.isSuccess) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              state.postTo == "All"
                  ? "Schedule added to all users!"
                  : "Schedule added successfully!",
            ),
            backgroundColor: Colors.green,
          ),
        );
        viewModel.resetForm();
        viewModel.resetSuccess();
        if (widget.onSubmitSuccess != null) {
          widget.onSubmitSuccess!();
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Care Schedule"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          children: [
            // Care Plan
            Row(
              children: [
                const Expanded(child: Text("Care Plan", style: TextStyle(fontSize: 18))),
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: TextEditingController(text: state.carePlan),
                    onChanged: (val) =>
                        viewModel.handleEvent(CareScheduleEventOnCarePlanChange(val)),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFE7F0EA),
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Frequency
            Row(
              children: [
                const Expanded(child: Text("Frequency", style: TextStyle(fontSize: 18))),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () => setState(() => showFrequencyDropdown = !showFrequencyDropdown),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFE7F0EA),
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                        isDense: true,
                        suffixIcon: Icon(Icons.keyboard_arrow_down),
                      ),
                      child: Text(state.frequency.isEmpty ? "Select" : state.frequency),
                    ),
                  ),
                ),
              ],
            ),
            if (showFrequencyDropdown)
              Card(
                margin: const EdgeInsets.only(top: 4, left: 120, right: 0),
                child: Column(
                  children: frequencyOptions
                      .map((opt) => ListTile(
                            title: Text(opt),
                            onTap: () {
                              setState(() => showFrequencyDropdown = false);
                              viewModel.handleEvent(CareScheduleEventOnFrequencyChange(opt));
                            },
                          ))
                      .toList(),
                ),
              ),
            const SizedBox(height: 32),

            // Start Time
            Row(
              children: [
                const Expanded(child: Text("Start Time", style: TextStyle(fontSize: 18))),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () => _pickDateTime(context, initial: state.startTime, onResult: (val) {
                      viewModel.handleEvent(CareScheduleEventOnStartTimeChange(val));
                    }),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFE7F0EA),
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                        isDense: true,
                        suffixIcon: Icon(Icons.keyboard_arrow_down),
                      ),
                      child: Text(state.startTime.isEmpty ? "Select" : state.startTime),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // End Time
            Row(
              children: [
                const Expanded(child: Text("End Time", style: TextStyle(fontSize: 18))),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () => _pickDateTime(context, initial: state.endTime, onResult: (val) {
                      viewModel.handleEvent(CareScheduleEventOnEndTimeChange(val));
                    }),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFE7F0EA),
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                        isDense: true,
                        suffixIcon: Icon(Icons.keyboard_arrow_down),
                      ),
                      child: Text(state.endTime.isEmpty ? "Select" : state.endTime),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Post To
            Row(
              children: [
                const Expanded(child: Text("Post To", style: TextStyle(fontSize: 18))),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () => setState(() => showPostToDropdown = !showPostToDropdown),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFE7F0EA),
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                        isDense: true,
                        suffixIcon: Icon(Icons.keyboard_arrow_down),
                      ),
                      child: Text(state.postTo.isEmpty ? "Select" : state.postTo),
                    ),
                  ),
                ),
              ],
            ),
            if (showPostToDropdown)
              Card(
                margin: const EdgeInsets.only(top: 4, left: 120, right: 0),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('All'),
                      onTap: () {
                        setState(() => showPostToDropdown = false);
                        viewModel.handleEvent(CareScheduleEventOnPostToChange('All'));
                      },
                    ),
                    ...state.userList.map((user) => ListTile(
                          title: Text(user.email),
                          onTap: () {
                            setState(() => showPostToDropdown = false);
                            viewModel.handleEvent(CareScheduleEventOnPostToChange(user.id));
                          },
                        )),
                  ],
                ),
              ),
            const SizedBox(height: 32),

            // Submit Button
            ElevatedButton(
              onPressed: () => setState(() => showConfirmDialog = true),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6CA6A3),
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text("Submit", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
            ),
            const SizedBox(height: 24),

            // Loading and error state at the bottom
            if (state.isLoading) const CircularProgressIndicator(),
            if (state.error != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(state.error!, style: const TextStyle(color: Colors.red)),
              ),
          ],
        ),
      ),
    );
  }

  void _pickDateTime(BuildContext context, {required String initial, required Function(String) onResult}) async {
    DateTime? date = DateTime.now();
    if (initial.isNotEmpty) {
      try {
        date = DateFormat("yyyy-MM-dd HH:mm").parse(initial);
      } catch (_) {}
    }
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: date ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(date ?? DateTime.now()),
      );
      if (pickedTime != null) {
        final dt = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        onResult(DateFormat("yyyy-MM-dd HH:mm").format(dt));
      }
    }
  }
}
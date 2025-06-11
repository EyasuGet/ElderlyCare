import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/providers/viewmodel_providers.dart';
import '../../application/events/nurse_delete_event.dart';
import '../../application/events/view_detail_event.dart';

class ViewDetailScreen extends ConsumerStatefulWidget {
  final String elderId;
  final String elderName;
  final String elderEmail;

  const ViewDetailScreen({
    Key? key,
    required this.elderId,
    required this.elderName,
    required this.elderEmail,
  }) : super(key: key);

  @override
  ConsumerState<ViewDetailScreen> createState() => _ViewDetailScreenState();
}

class _ViewDetailScreenState extends ConsumerState<ViewDetailScreen> {
  bool showHeartRateDialog = false;
  bool showBloodPressureDialog = false;
  bool showSugarLevelDialog = false;
  bool showDeleteDialog = false;
  bool _hasNavigatedAfterDelete = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final vm = ref.read(viewDetailViewModelProvider.notifier);
      vm.handleEvent(FetchElderDetail(widget.elderId));
      await vm.fetchUserAndNurseInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(viewDetailViewModelProvider.notifier);
    final state = ref.watch(viewDetailViewModelProvider);

    final nurseDeleteViewModel = ref.read(nurseDeleteViewModelProvider.notifier);
    final deleteState = ref.watch(nurseDeleteViewModelProvider);

    // Handle delete success/effect
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (deleteState.successMessage != null && !_hasNavigatedAfterDelete) {
        _hasNavigatedAfterDelete = true;
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) context.go('/nurse/home');
        });
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Visit details"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/nurse/home'),
        ),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile section
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundImage: AssetImage('lib/assets/images/logo.png'),
                        backgroundColor: Colors.grey[200],
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.elderName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
                            Text(widget.elderEmail, style: const TextStyle(color: Colors.black54)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Caretaker Info Box
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9F2F1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Caretaker: ${state.careTaker}", style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text("ID: ${state.userId}", style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text("Nurse: ${state.nurseName}", style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text("Blood Type: ${state.bloodType}", style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  Text("Diagnosis", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: Text(state.description ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 24),

                  // Vitals
                  Row(
                    children: [
                      Expanded(
                        child: _VitalCard(
                          title: "Heart Rate",
                          value: "${(state.heartRate == null || state.heartRate?.isEmpty == true) ? "70" : state.heartRate} BPM",
                          asset: 'lib/assets/images/heart_rate.png',
                          onUpdate: () => setState(() => showHeartRateDialog = true),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _VitalCard(
                          title: "Blood Pressure",
                          value: "${(state.bloodPressure == null || state.bloodPressure!.isEmpty) ? "120/80" : state.bloodPressure} MMHG",
                          asset: 'lib/assets/images/blood_pressure.png',
                          onUpdate: () => setState(() => showBloodPressureDialog = true),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  _VitalCard(
                    title: "Sugar Level",
                    value: "${(state.sugarLevel == null || state.sugarLevel!.isEmpty) ? "73" : state.sugarLevel} mg/dL",
                    asset: 'lib/assets/images/sugar_level.png',
                    onUpdate: () => setState(() => showSugarLevelDialog = true),
                  ),

                  const SizedBox(height: 30),

                  // Delete Button
                  ElevatedButton(
                    onPressed: () => setState(() => showDeleteDialog = true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size.fromHeight(48),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text("Delete User", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                  if (deleteState.isLoading)
                    const Center(child: Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: CircularProgressIndicator(),
                    )),
                  if (deleteState.errorMessage != null)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(deleteState.errorMessage!, style: const TextStyle(color: Colors.red)),
                      ),
                    ),
                  if (deleteState.successMessage != null)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(deleteState.successMessage!, style: const TextStyle(color: Colors.green)),
                      ),
                    ),
                  if (state.error != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text("Error: ${state.error}", style: const TextStyle(color: Colors.red)),
                    ),
                  if (state.isSuccess)
                    const Padding(
                      padding: EdgeInsets.only(top: 12.0),
                      child: Text("Details updated!", style: TextStyle(color: Colors.green)),
                    ),
                ],
              ),
            ),
      floatingActionButton: const SizedBox.shrink(),
      bottomSheet: _buildDialogs(context, viewModel, state, nurseDeleteViewModel),
    );
  }

  Widget _buildDialogs(BuildContext context, viewModel, state, nurseDeleteViewModel) {
    if (showHeartRateDialog) {
      return _UpdateVitalDialog(
        title: "Update Heart Rate",
        initialValue: state.heartRate ?? "",
        unit: "BPM",
        onDismiss: () => setState(() => showHeartRateDialog = false),
        onUpdate: (newValue) {
          viewModel.handleEvent(OnHeartRateChange(newValue));
          viewModel.handleEvent(UpdateUserDetail(
            elderId: widget.elderId,
            heartRate: newValue,
            bloodPressure: state.bloodPressure ?? "",
            sugarLevel: state.sugarLevel ?? "",
          ));
          setState(() => showHeartRateDialog = false);
        },
      );
    }
    if (showBloodPressureDialog) {
      return _UpdateVitalDialog(
        title: "Update Blood Pressure",
        initialValue: state.bloodPressure ?? "",
        unit: "MMHG",
        onDismiss: () => setState(() => showBloodPressureDialog = false),
        onUpdate: (newValue) {
          viewModel.handleEvent(OnBloodPressureChange(newValue));
          viewModel.handleEvent(UpdateUserDetail(
            elderId: widget.elderId,
            heartRate: state.heartRate ?? "",
            bloodPressure: newValue,
            sugarLevel: state.sugarLevel ?? "",
          ));
          setState(() => showBloodPressureDialog = false);
        },
      );
    }
    if (showSugarLevelDialog) {
      return _UpdateVitalDialog(
        title: "Update Sugar Level",
        initialValue: state.sugarLevel ?? "",
        unit: "mg/dL",
        onDismiss: () => setState(() => showSugarLevelDialog = false),
        onUpdate: (newValue) {
          viewModel.handleEvent(OnSugarLevelChange(newValue));
          viewModel.handleEvent(UpdateUserDetail(
            elderId: widget.elderId,
            heartRate: state.heartRate ?? "",
            bloodPressure: state.bloodPressure ?? "",
            sugarLevel: newValue,
          ));
          setState(() => showSugarLevelDialog = false);
        },
      );
    }
    if (showDeleteDialog) {
      return _DeleteConfirmationDialog(
        onConfirm: () {
          nurseDeleteViewModel.handleEvent(DeleteUser(widget.elderId));
          setState(() => showDeleteDialog = false);
        },
        onDismiss: () => setState(() => showDeleteDialog = false),
      );
    }
    return const SizedBox.shrink();
  }
}

// VitalCard widget
class _VitalCard extends StatelessWidget {
  final String title;
  final String value;
  final String asset;
  final VoidCallback onUpdate;

  const _VitalCard({
    required this.title,
    required this.value,
    required this.asset,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Image.asset(asset, width: 40, height: 40),
                const SizedBox(width: 12),
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 20),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton(
                onPressed: onUpdate,
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFFD9F2F1),
                  minimumSize: const Size(60, 28),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                ),
                child: const Text("Update", style: TextStyle(fontSize: 12, color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// UpdateVitalDialog widget
class _UpdateVitalDialog extends StatefulWidget {
  final String title;
  final String initialValue;
  final String unit;
  final VoidCallback onDismiss;
  final ValueChanged<String> onUpdate;

  const _UpdateVitalDialog({
    required this.title,
    required this.initialValue,
    required this.unit,
    required this.onDismiss,
    required this.onUpdate,
  });

  @override
  State<_UpdateVitalDialog> createState() => __UpdateVitalDialogState();
}

class __UpdateVitalDialogState extends State<_UpdateVitalDialog> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: controller,
        keyboardType: widget.unit == "mg/dL" || widget.unit == "BPM"
            ? TextInputType.number
            : TextInputType.text,
        decoration: InputDecoration(
          labelText: "Enter ${widget.title}",
          suffixText: widget.unit,
        ),
      ),
      actions: [
        TextButton(onPressed: widget.onDismiss, child: const Text("Cancel")),
        ElevatedButton(
          onPressed: () {
            if (controller.text.isNotEmpty) {
              widget.onUpdate(controller.text);
            }
          },
          child: const Text("Update"),
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }
}

// DeleteConfirmationDialog widget
class _DeleteConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onDismiss;

  const _DeleteConfirmationDialog({
    required this.onConfirm,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Delete User"),
      content: const Text("Are you sure you want to delete this user? This action cannot be undone."),
      actions: [
        TextButton(onPressed: onDismiss, child: const Text("Cancel")),
        ElevatedButton(
          onPressed: onConfirm,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Text("Delete", style: TextStyle(color: Colors.white)),
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }
}
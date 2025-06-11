import 'package:elderly_care/application/providers/viewmodel_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/providers/viewmodel_providers.dart' as providers;
import '../../application/events/nurse_profile_event.dart';

class NurseProfileScreen extends ConsumerStatefulWidget {
  const NurseProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<NurseProfileScreen> createState() => _NurseProfileScreenState();
}

class _NurseProfileScreenState extends ConsumerState<NurseProfileScreen> {
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
      ref.read(nurseProfileViewModelProvider.notifier).handleEvent(FetchNurseProfile())
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(nurseProfileViewModelProvider.notifier);
    final state = ref.watch(nurseProfileViewModelProvider);

    if (state.isSuccess) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile updated successfully"), backgroundColor: Colors.green),
        );
        viewModel.resetSuccess();
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
              ? Center(child: Text(state.error!, style: const TextStyle(color: Colors.red)))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Main content
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(radius: 32, child: Icon(Icons.person, size: 40)),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Nurse, ${state.name}", style: const TextStyle(fontWeight: FontWeight.bold)),
                                    Text(state.userName, style: const TextStyle(fontSize: 12)),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFCAE7E5),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: const EdgeInsets.all(16),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  _profileField("Full Name", state.name, isEditing,
                                      onChanged: (v) => viewModel.handleEvent(OnNameChange(v))),
                                  _profileField("Email Address", state.email, isEditing,
                                      onChanged: (v) => viewModel.handleEvent(OnEmailChange(v))),
                                  _profileField("Phone Number", state.phoneNumber, isEditing,
                                      onChanged: (v) => viewModel.handleEvent(OnPhoneNumberChange(v))),
                                  _profileField("Username", state.userName, isEditing,
                                      onChanged: (v) => viewModel.handleEvent(OnUserNameChange(v))),
                                  _profileField("Years of Expertise", state.yearsOfExperience, isEditing,
                                      onChanged: (v) => viewModel.handleEvent(OnYearsOfExperienceChange(v))),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    if (isEditing) {
                                      viewModel.handleEvent(OnSubmit());
                                    }
                                    setState(() => isEditing = !isEditing);
                                  },
                                  child: Text(isEditing ? "Done" : "Edit"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Logout button at bottom
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.logout),
                          label: const Text("Logout"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () async {
                            // Clear session via ViewModel
                            await viewModel.clearSessionOnLogout();
                            ref.invalidate(userProfileViewModelProvider);
                            ref.invalidate(loginViewModelProvider);
                            
                            ref.read(providers.loginViewModelProvider.notifier).reset();
                            if (mounted) context.go('/signup');
                          },
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget _profileField(String label, String value, bool editable, {required ValueChanged<String> onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          editable
              ? TextField(
                  controller: TextEditingController(text: value),
                  onChanged: onChanged,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  ),
                )
              : Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  width: double.infinity,
                  child: Text(value),
                ),
        ],
      ),
    );
  }
}
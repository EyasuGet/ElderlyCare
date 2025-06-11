import 'package:elderly_care/application/providers/repository_providers.dart';
import 'package:elderly_care/application/providers/viewmodel_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/events/user_edit_profile_event.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  final VoidCallback onLogoutClick;
  const UserProfileScreen({Key? key, required this.onLogoutClick}) : super(key: key);

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(userProfileViewModelProvider.notifier);
    final state = ref.watch(userProfileViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
                const SizedBox(width: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(state.fullName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    Text(state.email, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  if (isEditing) {
                    viewModel.onEvent(SubmitProfile());
                  }
                  setState(() => isEditing = !isEditing);
                },
                child: Text(isEditing ? "Done" : "Edit"),
              ),
            ),
            _ProfileField(
              label: "Full Name",
              value: state.fullName,
              isEditing: isEditing,
              onChanged: (v) => viewModel.onEvent(UpdateFullName(v)),
            ),
            _ProfileField(
              label: "Gender",
              value: state.gender,
              isEditing: isEditing,
              onChanged: (v) => viewModel.onEvent(UpdateGender(v)),
            ),
            _ProfileField(
              label: "Phone Number",
              value: state.phoneNumber,
              isEditing: isEditing,
              onChanged: (v) => viewModel.onEvent(UpdatePhoneNumber(v)),
            ),
            _ProfileField(
              label: "Care Taker",
              value: state.caretaker,
              isEditing: isEditing,
              onChanged: (v) => viewModel.onEvent(UpdateCaretaker(v)),
            ),
            _ProfileField(
              label: "Address",
              value: state.address,
              isEditing: isEditing,
              onChanged: (v) => viewModel.onEvent(UpdateAddress(v)),
            ),
            _ProfileField(
              label: "Email",
              value: state.email,
              isEditing: isEditing,
              onChanged: (v) => viewModel.onEvent(UpdateEmail(v)),
            ),
            const SizedBox(height: 24),
            if (state.isLoading) const CircularProgressIndicator(),
            if (state.error != null)
              Text(state.error!, style: const TextStyle(color: Colors.red)),
            if (state.isSuccess)
              const Text("Profile updated!", style: TextStyle(color: Colors.green)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                // First, clear the session data
                await ref.read(sessionManagerProvider).clearSession();

                // Invalidate providers to reset their state
                ref.invalidate(userProfileViewModelProvider);
                ref.invalidate(loginViewModelProvider);
                // Invalidate any other providers that hold user data
                ref.read(loginViewModelProvider.notifier).reset();
                // Then , call the onLogoutClick which should handle navigation
                widget.onLogoutClick();
              },
              child: const Text("Logout"),
            )
          ],
        ),
      ),
    );
  }
}

class _ProfileField extends StatelessWidget {
  final String label;
  final String value;
  final bool isEditing;
  final ValueChanged<String> onChanged;
  const _ProfileField({
    required this.label,
    required this.value,
    required this.isEditing,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Use a controller only if isEditing, otherwise you get a new controller every build!
    final controller = isEditing ? TextEditingController(text: value) : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        isEditing
            ? TextField(
                controller: controller,
                onChanged: onChanged,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  isDense: true,
                ),
              )
            : Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(value),
              ),
        const SizedBox(height: 16),
      ],
    );
  }
}
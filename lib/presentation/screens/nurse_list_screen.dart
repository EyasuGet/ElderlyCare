import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/providers/viewmodel_providers.dart'; // adjust import as needed
import '../../data/remote/response/nurse_list_response.dart';

class NurseListScreen extends ConsumerStatefulWidget {
  const NurseListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<NurseListScreen> createState() => _NurseListScreenState();
}

class _NurseListScreenState extends ConsumerState<NurseListScreen> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(nurseListViewModelProvider);

    List<NurseListResponse> filteredElders = state.elderList.where((elder) {
      final query = searchQuery.toLowerCase();
      return elder.name.toLowerCase().contains(query) ||
          elder.email.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text("List of Elders")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search by name or email",
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                setState(() {
                  searchQuery = query;
                });
              },
            ),
          ),
          if (state.isLoading)
            const Center(child: CircularProgressIndicator()),
          if (state.error != null)
            Center(child: Text("Error: ${state.error}", style: const TextStyle(color: Colors.red))),
          if (!state.isLoading && state.error == null)
            Expanded(
              child: filteredElders.isEmpty
                  ? const Center(child: Text("No results found."))
                  : ListView.builder(
                      itemCount: filteredElders.length,
                      itemBuilder: (context, index) {
                        final elder = filteredElders[index];
                        return ListTile(
                          leading: const CircleAvatar(child: Icon(Icons.person)),
                          title: Text(elder.name),
                          subtitle: Text(elder.email),
                          onTap: () {
                            context.go(
                              '/nurse/user/${elder.nurseId}/${Uri.encodeComponent(elder.name)}/${Uri.encodeComponent(elder.email)}/details',
                            );
                          },
                        );
                      },
                    ),
            ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_project/model/user.dart';
import 'package:flutter_project/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ParticipantContent extends StatelessWidget {
  const ParticipantContent({super.key});

  void _onAddPressed(BuildContext context, String name) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final newUser = User(bibNumber: 'B007', userName: name);
    userProvider.addUser(newUser);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final nameController = TextEditingController();

    if (userProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (userProvider.hasData) {
      final List<User> userList = userProvider.userState!.data!;

      return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        children: [
          const Text(
            "Participant List :",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
            ),
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Bib')),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Action')),
              ],
              rows: [
                ...List.generate(userList.length, (index) {
                  final user = userList[index];
                  return DataRow(
                    cells: [
                      DataCell(Text(user.bibNumber.toString())),
                      DataCell(Text(user.userName)),
                      DataCell(
                        IconButton(
                          icon: const Icon(Icons.more_horiz_rounded),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  );
                }),
                DataRow(
                  cells: [
                    const DataCell(Text('-||-')),
                    DataCell(
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          maintainHintHeight: true,
                          hintText: "Enter name",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    DataCell(
                      ElevatedButton(
                        onPressed: () {
                          final name = nameController.text;
                          if (name.isNotEmpty) {
                            _onAddPressed(context, name);
                          }
                        },
                        child: const Text("Add"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }
    return const Center(child: Text("No participants found."));
  }
}

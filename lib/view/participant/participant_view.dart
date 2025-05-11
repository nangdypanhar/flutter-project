import 'package:flutter/material.dart';
import 'package:flutter_project/model/user.dart';
import 'package:flutter_project/providers/user_provider.dart';
import 'package:flutter_project/repository/user_repository.dart';
import 'package:flutter_project/view/participant/participant_view_model.dart';
import 'package:flutter_project/widgets/confirm_dialog.dart';
import 'package:flutter_project/widgets/race_snack_bar.dart';
import 'package:provider/provider.dart';

part 'participant_content.dart';
part 'local_widget/participant_table.dart';
part 'local_widget/search_field.dart';
part 'local_widget/add_participant_row.dart';

class ParticipantView extends StatelessWidget {
  const ParticipantView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProvider>(
      create: (context) => UserProvider(UserRepository()),
      child: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          final viewModel = ParticipantViewModel(userProvider);
          return _ParticipantContent(viewModel: viewModel);
        },
      ),
    );
  }
}
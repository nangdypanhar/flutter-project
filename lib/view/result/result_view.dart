import 'package:flutter/material.dart';
import 'package:flutter_project/helper/time_format.dart';
import 'package:flutter_project/providers/user_provider.dart';
import 'package:flutter_project/repository/user_repository.dart';
import 'package:flutter_project/view/result/result_view_model.dart';
import 'package:provider/provider.dart';

part 'result_content.dart';
part 'local_widget/result_table.dart';

class ResultView extends StatelessWidget {
  const ResultView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProvider>(
      create: (context) => UserProvider(UserRepository()),
      child: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          final resultViewModel = ResultViewModel(userProvider);
          return _ResultContent(viewModel: resultViewModel);
        },
      ),
    );
  }
}

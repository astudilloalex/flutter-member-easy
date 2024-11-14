import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_easy/ui/pages/home/bloc/home_cubit.dart';
import 'package:member_easy/ui/pages/home/bloc/home_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  '${state.members[index].firstName} ${state.members[index].lastName}',
                ),
                subtitle: Text(state.members[index].idCard),
                trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(state.members[index].idCard),
                                    subtitle: Text('Id Card'),
                                  ),
                                  ListTile(
                                    title: Text(state.members[index].firstName),
                                    subtitle: Text('Names'),
                                  ),
                                  ListTile(
                                    title: Text(state.members[index].lastName),
                                    subtitle: Text('Surnames'),
                                  ),
                                  ListTile(
                                    title: Text(
                                      '${state.members[index].birthDate}',
                                    ),
                                    subtitle: Text('Birthdate'),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.visibility_outlined),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.edit_outlined),
                    ),
                  ],
                ),
              );
            },
            itemCount: state.members.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
    );
  }
}

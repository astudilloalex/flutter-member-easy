import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_easy/app/bloc/app_cubit.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyUserQRCodeDialog extends StatelessWidget {
  const MyUserQRCodeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: QrImageView(
              data: context.read<AppCubit>().state.currentUser?.code ?? '',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    context.read<AppCubit>().state.currentUser?.code ?? '',
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Clipboard.setData(
                      ClipboardData(
                        text:
                            context.read<AppCubit>().state.currentUser?.code ??
                                '',
                      ),
                    );
                  },
                  icon: const Icon(Icons.copy_outlined),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

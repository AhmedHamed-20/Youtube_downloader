import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../core/const/const.dart';

class DownloadAlertDialogWidget extends StatelessWidget {
  const DownloadAlertDialogWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<double>(
        stream: downloadProgress.stream,
        builder: (context, snapshot) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.r10),
            ),
            title: Text(
              'Downloading...',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: snapshot.hasData,
                  replacement: const CircularProgressIndicator(),
                  child: LinearProgressIndicator(
                    value: snapshot.data,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: snapshot.data == 1,
                  replacement: TextButton(
                    onPressed: () async {
                      cancelToken.cancel();
                      if (cancelToken.isCancelled) {
                        Navigator.of(context).pop();
                        downloadProgress.close();
                        cancelToken = CancelToken();
                        downloadProgress = StreamController<double>();
                      }
                    },
                    child: Text(
                      'Cancel',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Downloaded Sccess and saved in Download folder',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: AppColors.toastSuccess),
                      ),
                      const SizedBox(
                        height: AppHeight.h10,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          downloadProgress.close();
                          downloadProgress = StreamController<double>();
                        },
                        child: Text(
                          'Ok',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}

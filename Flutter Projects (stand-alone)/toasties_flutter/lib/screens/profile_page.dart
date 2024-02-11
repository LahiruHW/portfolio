// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:toasties_flutter/common/providers/state_provider.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ToastieStateProvider>(
        builder: (context, provider, child) => Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
      
              children: [
                Card(
                  clipBehavior: Clip.hardEdge,
                  borderOnForeground: true,
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          provider.user!.photoURL != null
                              ? CachedNetworkImage(
                                  imageUrl: provider.user!.photoURL ?? "",
                                  width: 100,
                                  height: 100,
                                  alignment: Alignment.center,
                                  cacheKey: "profile-img-${provider.user!.uid}",
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Icon(
                                    Icons.account_box_rounded,
                                    size: 100,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.account_box_rounded,
                                    size: 100,
                                  ),
                                  errorListener: (errorObj) =>
                                      throw Exception(errorObj),
                                  useOldImageOnUrlChange: true,
                                )
                              : const Icon(
                                  Icons.account_box_rounded,
                                  size: 100,
                                ),
                          Expanded(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    // '${provider.user!.displayName}',
                                    '${provider.userProfile.userName}',
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 35,
                                          color: Colors.black,
                                        ),
                                  ),
                                  Text(
                                    '${provider.user!.email}',
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                          color: Colors.black,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.black, height: 1.0),
                      TextButton(
                        onPressed: () {
                          // print(provider.user);
                          // print(provider.userProfile);
                          // print(provider.currentChat);
                          // print(provider.savedChats);

                          // get the current path from the router
                          final currentPath = GoRouter.of(context).routeInformationProvider.value.uri;
                          GoRouter.of(context).push("$currentPath/test2");

                        },
                        // make the text button expand to fill the entire width
                        style: TextButton.styleFrom(
                          minimumSize: const Size(double.infinity, 60),
                          fixedSize: const Size(double.infinity, 60),
                          maximumSize: const Size(double.infinity, 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        child: const Text("Edit Profile"),
                      )
                    ],
                  ),
                ),
                Text(
                  '${provider.user!.uid}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

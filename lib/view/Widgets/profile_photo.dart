import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

import 'package:cached_network_image/cached_network_image.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({
    super.key,
    required XFile? profileImage,
    this.defaultImg,
  }) : _profileImage = profileImage;

  final XFile? _profileImage;
  final String? defaultImg;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[300],
      ),
      child: _profileImage == null && defaultImg == null
          ? Icon(
              Icons.account_circle,
              size: 150,
              color: Colors.grey[600],
            )
          : defaultImg != null
              ? ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: defaultImg!,
                    width: double.infinity,
                    height: 100,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: double.infinity,
                        height: 100,
                        color: Colors.white,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                )
              : ClipOval(
                  child: Image.file(
                    File(_profileImage!.path),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
    );
  }
}

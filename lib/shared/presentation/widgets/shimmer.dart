import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../shared/utils/extension.dart';
import '../theme/app_colors.dart';

class LoadingTextView extends StatelessWidget {
  final double? width;
  final double? height;
  const LoadingTextView({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      direction: ShimmerDirection.ltr,
      gradient: LinearGradient(
        colors: [
          Theme.of(context).colorScheme.error,
          AppColors.yellow,
          AppColors.black(context),
        ],
        stops: const [0.1, 0.3, 0.4],
        begin: const Alignment(-1.0, -0.5),
        end: const Alignment(1.0, 0.5),
        tileMode: TileMode.repeated,
      ),
      child: ShimmerSkeleton(width: width, height: height),
    );
  }
}

class LoadingListView extends StatelessWidget {
  const LoadingListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.separated(
        padding: context.responsivePadding(mobile: const EdgeInsets.all(20)),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        separatorBuilder: (context, index) =>
            SizedBox(height: context.responsiveSpacing(mobile: 16)),
        itemCount: 15,
        itemBuilder: (context, index) {
          return Shimmer(
            direction: ShimmerDirection.ltr,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.error,
                AppColors.yellow,
                AppColors.black(context),
              ],
              stops: const [0.1, 0.3, 0.4],
              begin: const Alignment(-1.0, -0.5),
              end: const Alignment(1.0, 0.5),
              tileMode: TileMode.repeated,
            ),
            child: const ShimmerWidget(),
          );
        },
      ),
    );
  }
}

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShimmerSkeleton(
          height: context.responsiveValue(mobile: 120.0),
          width: context.responsiveValue(mobile: 120.0),
        ),
        SizedBox(width: context.responsiveSpacing(mobile: 16)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerSkeleton(width: context.responsiveValue(mobile: 80.0)),
              Padding(
                padding: context.responsivePadding(
                  mobile: const EdgeInsets.symmetric(vertical: 8.0),
                ),
                child: const ShimmerSkeleton(),
              ),
              const ShimmerSkeleton(),
              SizedBox(height: context.responsiveSpacing(mobile: 8)),
              Row(
                children: [
                  const Expanded(child: ShimmerSkeleton()),
                  SizedBox(width: context.responsiveSpacing(mobile: 16)),
                  const Expanded(child: ShimmerSkeleton()),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ShimmerSkeleton extends StatelessWidget {
  const ShimmerSkeleton({super.key, this.height, this.width});

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: context.responsivePadding(mobile: const EdgeInsets.all(8)),
      decoration: BoxDecoration(
        color: AppColors.primaryText(context).withValues(alpha: 0.04),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
    );
  }
}

class CircleSkeleton extends StatelessWidget {
  const CircleSkeleton({super.key, this.size = 24});

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withValues(alpha: 0.04),
        shape: BoxShape.circle,
      ),
    );
  }
}

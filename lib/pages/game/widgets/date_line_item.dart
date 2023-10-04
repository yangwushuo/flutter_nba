import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateLineItem extends StatelessWidget {
  final String dayNumber;
  final String dayName;
  final String monthName;
  final DateTime fullDate;
  final bool isSelected;
  final int? games;
  final Function(int, {bool? isShock})? onTap;

  const DateLineItem({
    super.key,
    required this.dayNumber,
    required this.dayName,
    required this.monthName,
    required this.fullDate,
    required this.isSelected,
    this.games,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          onTap == null ? null : () => onTap!(fullDate.millisecondsSinceEpoch),
      child: Container(
        width: MediaQuery.of(context).size.width / 7,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.sp),
              child: Text(
                dayName[dayName.length - 1],
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Colors.white24),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 0.sp),
              child: AnimatedScale(
                scale: isSelected ? 1.3 : 1,
                duration: const Duration(milliseconds: 200),
                child: Text(
                  dayNumber,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: isSelected ? Colors.white : Colors.white24),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 6.sp),
              child: Text(
                "$dayNumber场",
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 10.sp,
                    ),
              ),
            ),
            AnimatedOpacity(
              opacity: isSelected ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              child: Container(
                width: MediaQuery.of(context).size.width / 7,
                height: 2.sp,
                color: Colors.yellow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: file_names
import 'package:flutter/material.dart';

// ignore: camel_case_types
class homePageFunctionButton extends StatelessWidget {
  final String icon;
  final String label;
  final Function onTap;

  const homePageFunctionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Material(
        color: Colors.transparent, // 确保背景颜色透明
        child: Ink(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(197, 197, 209, 0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: InkWell(
            onTap: () => onTap(),
            splashColor: Colors.white.withOpacity(0.5), // 设置点击时水波纹颜色
            highlightColor: Colors.white.withOpacity(0.3), // 设置按住时的高亮颜色
            borderRadius: BorderRadius.circular(20), // 确保水波纹效果与圆角一致
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 33, vertical: 9),
              child: Row(
                children: [
                  Image.asset(
                    icon,
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 20),
                  Text(
                    label,
                    style: const TextStyle(
                      color: Color.fromRGBO(197, 197, 209, 1),
                      fontSize: 15,
                    ),
                  ),
                  const Spacer(),
                  Image.asset(
                    "assets/images/homepage_arrow_right@2x.png",
                    width: 5,
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

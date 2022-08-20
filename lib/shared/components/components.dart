import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Decoration deffaultDecoration({
  Color backgroundColor = Colors.white,
  double topEnd = 30,
  double topStart = 30,
  double bottomEnd = 0,
  double bottomStart = 0,
}) =>
    BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadiusDirectional.only(
        topEnd: Radius.circular(topEnd),
        topStart: Radius.circular(topStart),
        bottomEnd: Radius.circular(bottomEnd),
        bottomStart: Radius.circular(bottomStart),
      ),
    );

Widget deffaultSeparatorBuilder() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 60),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        height: 1,
        color: Colors.grey,
        width: double.infinity,
      ),
    );
Widget deffaultFormField(
        {required TextEditingController? controller,
        TextInputType? type,
        bool isPassword = false,
        required String? labelText,
        required IconData? prefix,
        IconData? suffix,
        final FormFieldValidator<String>? validate,
        VoidCallback? suffixPressed,
        VoidCallback? onTap,
        Function(String)? onChanged,
        bool isClickable = true,
        ValueChanged<String>? onFieldSubmitted}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefix),
        suffixIcon: IconButton(onPressed: suffixPressed, icon: Icon(suffix)),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
      onFieldSubmitted: onFieldSubmitted,
      validator: validate,
      onTap: onTap,
      enabled: isClickable,
    );

Widget deffaultTextButton({
  required VoidCallback? onPressed,
  required String text,
  Color color = Colors.blue,
}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: color,
        ),
      ),
    );
Widget deffaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  double height = 45,
  required VoidCallback? function,
  required String? text,
  bool isUpperCase = true,
  Color textColor = Colors.white,
  double fontSize = 20.0,
}) =>
    Container(
      width: width,
      // color: background,
      decoration: deffaultDecoration(
        backgroundColor: deffaultColor,
        bottomEnd: 20,
        bottomStart: 20,
        topEnd: 20,
        topStart: 20,
      ),
      child: MaterialButton(
        height: height,
        onPressed: function,
        child: Text(
          isUpperCase ? text!.toUpperCase() : text!,
          style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: fontSize),
        ),
      ),
    );

void navigateTo(context, Widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Widget,
    ));
void navigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
      (Route<dynamic> route) => false,
    );

void showToast({
  required String text,
  required ToastState state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: choseToasteColor(state),
        textColor: Colors.white,
        fontSize: 16.0);
enum ToastState { SUCCESS, ERORR, WORNING }
Color choseToasteColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERORR:
      color = Colors.red;
      break;
    case ToastState.WORNING:
      color = Colors.amber;
      break;
  }
  return color;
}

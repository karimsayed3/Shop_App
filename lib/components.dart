import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled3/Modules/Shop_App/Login_Screen/ShopLoginScreen.dart';
import 'package:untitled3/remote/dio/casheHelper.dart';
import 'package:untitled3/remote/icon_broken.dart';
import 'Modules/NewsApp/WebScreen/WebScreen.dart';

//SharedPreferences preferences;

// Future<void> initPref() async
// {
//   return await SharedPreferences.getInstance().then((value)
//   {
//     preferences = value;
//     print('done =>');
//   }).catchError((error){
//     print('error => ${error.toString()}');
//
//   });
// }
//
// Future<bool> saveToken(String token) => preferences.setString('myToken', token);
//
// String getToken() => preferences.getString('myToken');

Widget defaultFormField({
  @required TextEditingController conntroller,
  @required TextInputType type,
  @required String label,
  @required dynamic validator,
  @required IconData prefix,
  bool isPassword = false,
  dynamic onSubmit,
  dynamic onChanged,
  dynamic togglePassword,
  IconData suffix,
  dynamic suffixPressed,
}) =>
    TextFormField(
      onChanged: onChanged,
      controller: conntroller,
      keyboardType: type,
      obscureText: isPassword,
      validator: validator,
      onFieldSubmitted: onSubmit,
      decoration: InputDecoration(
        prefixIcon: Icon(prefix),
        labelText: label,
        border: const OutlineInputBorder(),
        suffixIcon: prefix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
      ),
    );

Widget defaultButton({
  double width = double.infinity,
  Color Background = Colors.blue,
  double radius = 10.0,
  @required dynamic press,
  @required String text,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: Background,
      ),
      // color: Background,
      child: MaterialButton(
        height: 40.0,
        onPressed: press,
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultTextButton({
  @required dynamic function,
  @required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 15.0,
        ),
      ),
    );

Future Navegato(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

Widget buildnewsItems(list, context) => InkWell(
      onTap: () {
        Navegato(context, WebScreen(list['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              height: 120.0,
              width: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                  image: NetworkImage('${list['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${list['title']}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Text(
                      '${list['publishedAt']}',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget elghat() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0),
      child: Container(
        height: 1.0,
        width: double.infinity,
        color: Colors.grey,
      ),
    );

Widget articalbuilder(list, {isSearch = false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => buildnewsItems(list[index], context),
          separatorBuilder: (context, index) => elghat(),
          itemCount: list.length),
      fallback: (context) => isSearch
          ? Center(
              child: Container(
                child: Text(
                  'Search Screen ',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.grey,
                  ),
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );

void toast({@required String msg, @required ToastState state}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastState { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastState state) {
  Color color;

  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.SUCCESS:
      color = Colors.amber;
      break;
  }
  return color;
}

void SignOut(context) {
  cacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ShopLoginScreen()),
          (route) => false);
    }
  });
}

void printFullText(text) {
  final pattern = RegExp('.{1.800}');
  pattern.allMatches(text).forEach((element) {
    print(element.group(0));
  });
}

Widget defaultAppBar({
  @required BuildContext context,
  String title,
  List<Widget> action,
}) =>
    AppBar(
      titleSpacing: 0.0,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          IconBroken.Arrow___Left_2,
        ),
      ),
      title: Text(
        title,
      ),
      actions: action,
    );

var token;
var uid;

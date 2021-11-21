import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gpa_calculator/components/custom_scroll_behavior.dart';
import 'package:gpa_calculator/components/header.dart';
import 'package:gpa_calculator/components/navigation_drawer.dart';
import 'package:gpa_calculator/constants.dart';
import 'package:gpa_calculator/models/course.dart';
import 'package:gpa_calculator/screens/add_edit_course_screen/add_course.dart';
import 'package:gpa_calculator/translations/locale_keys.g.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../functions.dart';
import 'add_course_fab.dart';
import 'course_card.dart';
import '../../../components/gpa_percent.dart';
import 'no_courses.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:showcaseview/showcaseview.dart';

class HomeScreenBody extends StatefulWidget {
  @override
  _HomeScreenBodyState createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  bool _showFAB = true;
  final _key1 = GlobalKey();
  final _key2 = GlobalKey();
  final _key3 = GlobalKey();

  @override
  void initState() {
    checkShowCase();
    super.initState();
  }

  void checkShowCase() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('firstToUse') == null) {
      WidgetsBinding.instance!.addPostFrameCallback((_) =>
          ShowCaseWidget.of(context)!.startShowCase([_key1, _key2, _key3]));
      await prefs.setInt('firstToUse', 1);
    }
  }

  @override
  void dispose() {
    closeBox();
    super.dispose();
  }

  void closeBox() async => Hive.close();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      drawer: NavigationDrawer(),
      body: Builder(
        builder: (context) => SafeArea(
          child: MediaQuery.of(context).size.width < 600
              ? buildMobileView()
              : buildWideView(),
        ),
      ),
      floatingActionButton: _showFAB
          ? Showcase(
              key: _key1,
              description: 'Add Courses',
              descTextStyle: TextStyle(color: kPrimaryColor),
              overlayPadding: EdgeInsets.all(8.0),
              shapeBorder: const CircleBorder(),
              child: AddCourseFAB(),
              showcaseBackgroundColor: Colors.white,
            )
          : null,
    );
  }

  Column buildWideView() {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Container(
                height: double.infinity,
                width: 280.0,
                child: Column(
                  children: [
                    CustomAppbar(_key2),
                    Spacer(),
                    buildGPAPercent(),
                    Spacer(),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  color: Colors.white,
                  child: buildCoursesCardWide(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Stack buildMobileView() {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 30.0),
          child: Center(
            child: Column(
              children: [
                CustomAppbar(_key2),
                SizedBox(height: 40.0),
                buildGPAPercent(),
              ],
            ),
          ),
        ),
        buildCoursesCard(),
      ],
    );
  }

  ValueListenableBuilder<Box<Course>> buildCoursesCardWide() {
    return ValueListenableBuilder<Box<Course>>(
      valueListenable: Hive.box<Course>('Courses').listenable(),
      builder: (context, box, _) {
        final courses = box.values.toList().cast<Course>();
        if (courses.length == 0) _showFAB = true;
        return buildCoursesCardsWide(courses);
      },
    );
  }

  ValueListenableBuilder<Box<Course>> buildCoursesCard() {
    return ValueListenableBuilder<Box<Course>>(
      valueListenable: Hive.box<Course>('Courses').listenable(),
      builder: (context, box, _) {
        final courses = box.values.toList().cast<Course>();
        if (courses.length == 0) _showFAB = true;
        return buildCoursesCards(courses);
      },
    );
  }

  ValueListenableBuilder<Box<Course>> buildGPAPercent() {
    return ValueListenableBuilder<Box<Course>>(
      valueListenable: Hive.box<Course>('Courses').listenable(),
      builder: (context, box, _) {
        final courses = box.values.toList().cast<Course>();
        double percent = 0.0;
        double weightsSum = 0;
        for (int i = 0; i < courses.length; ++i) {
          percent +=
              (courses[i].hwResult * 0.3 + courses[i].examResult * 0.7).ceil() *
                  courses[i].weight;
          weightsSum += courses[i].weight;
        }
        percent /= weightsSum;
        percent /= 100;
        return courses.length == 0
            ? NoCourses()
            : GPAPercent(
                percent: percent,
                progressColor: Color(0xFFf73e56),
                textColor: Colors.white,
              );
      },
    );
  }

  buildCoursesCardsWide(List<Course> courses) {
    return SlidableAutoCloseBehavior(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: courses.length == 0 ? 1 : courses.length,
        itemBuilder: (context, index) {
          if (courses.length == 0) {
            return Center(
              child: AddCoursesNote(),
            );
          }
          final finalResult = courseFinalResult(courses[index]);
          final Course currentCourse = courses[index];
          return Slidable(
            groupTag: 0,
            startActionPane: ActionPane(
              motion: const DrawerMotion(),
              extentRatio: 0.25,
              children: [
                SlidableAction(
                  autoClose: true,
                  label: LocaleKeys.edit.tr(),
                  backgroundColor: Colors.blue,
                  icon: Icons.edit,
                  onPressed: (context) => Navigator.pushNamed(
                    context,
                    AddCourseScreen.routeName,
                    arguments: ScreenArguments(course: currentCourse),
                  ),
                ),
              ],
            ),
            endActionPane: ActionPane(
              motion: const DrawerMotion(),
              extentRatio: 0.25,
              children: [
                SlidableAction(
                  autoClose: true,
                  label: LocaleKeys.delete.tr(),
                  backgroundColor: Colors.redAccent,
                  icon: Icons.delete,
                  onPressed: (context) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          context.locale.toString() == 'ar'
                              ? '${LocaleKeys.been_deleted.tr()} ${currentCourse.courseName}.'
                              : '${currentCourse.courseName} ${LocaleKeys.been_deleted.tr()}.',
                        ),
                      ),
                    );
                    currentCourse.delete();
                  },
                ),
              ],
            ),
            child: CourseCard(
              finalResult: finalResult,
              course: currentCourse,
              index: index,
            ),
          );
        },
      ),
    );
  }

  buildCoursesCards(List<Course> courses) {
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.4,
      builder: (context, _draggableScrollController) {
        _draggableScrollController.addListener(
          () {
            if (_draggableScrollController.position.userScrollDirection ==
                ScrollDirection.forward) {
              setState(() {
                _showFAB = true;
              });
            } else {
              setState(() {
                _showFAB = false | (courses.length == 0);
              });
            }
          },
        );
        return Container(
          padding: EdgeInsets.only(
            top: 10.0,
          ),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.white70,
                offset: Offset(0, 10),
                blurRadius: 20.0,
              ),
            ],
            color: Colors.white,
          ),
          child: ScrollConfiguration(
            behavior: NoGlowOnScrolling(),
            child: SlidableAutoCloseBehavior(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                controller: _draggableScrollController,
                itemCount: courses.length == 0 ? 1 : courses.length,
                itemBuilder: (context, index) {
                  if (courses.length == 0)
                    return Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: AddCoursesNote(),
                    );
                  final finalResult = courseFinalResult(courses[index]);
                  final Course currentCourse = courses[index];
                  return Slidable(
                    groupTag: 0,
                    startActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      extentRatio: 0.25,
                      children: [
                        SlidableAction(
                          autoClose: true,
                          label: LocaleKeys.edit.tr(),
                          backgroundColor: Colors.blue,
                          icon: Icons.edit,
                          onPressed: (context) {
                            Navigator.pushNamed(
                              context,
                              AddCourseScreen.routeName,
                              arguments: ScreenArguments(course: currentCourse),
                            );
                          },
                        ),
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      extentRatio: 0.25,
                      children: [
                        SlidableAction(
                          autoClose: true,
                          label: LocaleKeys.delete.tr(),
                          backgroundColor: Colors.redAccent,
                          icon: Icons.delete,
                          onPressed: (context) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  context.locale.toString() == 'ar'
                                      ? '${LocaleKeys.been_deleted.tr()} ${currentCourse.courseName}.'
                                      : '${currentCourse.courseName} ${LocaleKeys.been_deleted.tr()}.',
                                ),
                              ),
                            );
                            currentCourse.delete();
                          },
                        ),
                      ],
                    ),
                    child: CourseCard(
                      finalResult: finalResult,
                      course: currentCourse,
                      index: index,
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class CustomAppbar extends StatelessWidget {
  final _key;

  CustomAppbar(this._key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            Header(
              headerText: LocaleKeys.home_header.tr(),
              textColor: Colors.white,
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        Showcase(
          key: _key,
          description: 'Open Drawer',
          descTextStyle: TextStyle(color: kPrimaryColor),
          overlayPadding: EdgeInsets.all(2.0),
          showArrow: false,
          showcaseBackgroundColor: Colors.white,
          child: IconButton(
            icon: Icon(Icons.view_headline),
            iconSize: 30.0,
            tooltip: LocaleKeys.more.tr(),
            color: Colors.white,
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        )
      ],
    );
  }
}

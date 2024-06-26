import 'package:alumnest/providers/user_data_provider.dart';
import 'package:alumnest/src/home/widgets/alumni_card_widget.dart';
import 'package:alumnest/src/home/widgets/profile_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/home';

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<String> departments = ['All', 'CSE', 'CST', 'CEN', 'ECE', 'EEE', 'EIE'];

  List<int> passoutYears = [2024, 2023, 2022, 2021, 2020, 2019];

  String selectedDepartment = 'All';
  int selectedYear = 2024;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            title: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cliff",
                  style: TextStyle(
                    fontFamily: 'IBMPlexMono',
                    fontSize: 10,
                    color: Theme.of(context).colorScheme.onSurface,
                    // color: textColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "AlumNest",
                      style: TextStyle(
                        fontFamily: 'IBMPlexMono',
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).colorScheme.primary,
                        // color: textColor,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.connect_without_contact,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  ],
                ),
              ],
            ),
            actions: const [
              ProfileDialogBox(),
            ],
          ),
          SliverToBoxAdapter(
            child: ref.watch(userDataProvider).when(
              data: (data) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ListTile(
                        title: const Text(
                          "Department Alumni",
                          style: TextStyle(
                            fontFamily: 'IBMPlexMono',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Chip(
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor:
                              Theme.of(context).colorScheme.secondaryContainer,
                          label: Text(
                            data.userBranch,
                            // 'CSE',
                            style: const TextStyle(
                              fontFamily: 'IBMPlexMono',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    AlumniCard(
                      selectedDepartment: data.userBranch,
                      selectedYear: 2020,
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    //most contacted alumni
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: ListTile(
                        title: Text(
                          "Early Placers",
                          style: TextStyle(
                            fontFamily: 'IBMPlexMono',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    AlumniCard(
                        selectedDepartment: 'All',
                        selectedYear: DateTime.now().year),

                    const SizedBox(
                      height: 20,
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: ListTile(
                        title: Text(
                          "View all Alumni",
                          style: TextStyle(
                            fontFamily: 'IBMPlexMono',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    //drop down menus for departments and passout year
                    Row(children: [
                      const SizedBox(
                        width: 20,
                      ),
                      //drop down menu for departments
                      DropdownButton<String>(
                        value: selectedDepartment,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        underline: Container(
                          height: 2,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedDepartment = newValue!;
                          });
                        },
                        items: departments
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                fontFamily: 'IBMPlexMono',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(
                        width: 10,
                      ),

                      //drop down menu for passout year
                      DropdownButton<int>(
                        value: selectedYear,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        underline: Container(
                          height: 2,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        onChanged: (int? newYear) {
                          setState(() {
                            selectedYear = newYear!;
                          });
                        },
                        items: passoutYears
                            .map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(
                              value.toString(),
                              style: const TextStyle(
                                fontFamily: 'IBMPlexMono',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ]),

                    AlumniCard(
                      selectedDepartment: selectedDepartment,
                      selectedYear: selectedYear,
                      isVertical: true,
                    ),

                    const SizedBox(
                      height: 50,
                    ),
                  ],
                );
              },
              error: (error, stackTrace) {
                return const Center(
                  child: Text('Oops some error'),
                );
              },
              loading: () {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

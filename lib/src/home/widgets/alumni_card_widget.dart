import 'package:alumnest/providers/alumni_data_provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlumniCard extends ConsumerStatefulWidget {
  final String selectedDepartment;
  final int selectedYear;
  final bool? isVertical;
  const AlumniCard(
      {super.key,
      required this.selectedDepartment,
      required this.selectedYear,
      this.isVertical});

  @override
  ConsumerState<AlumniCard> createState() => _AlumniCardState();
}

class _AlumniCardState extends ConsumerState<AlumniCard> {
  int start = 200;
  int delay = 100;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Visibility(
        visible: hasAlumnis(context),
        replacement: const Center(
          heightFactor: 10,
          child: Text(
            'No alumni found',
            style: TextStyle(
              fontFamily: 'IBMPlexMono',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        child: ref.watch(alumniDataProvider).when(
          data: (data) {
            return SizedBox(
              height: widget.isVertical == null
                  ? screenHeight * 0.22
                  : data.length * screenHeight / 5,
              child: widget.isVertical == null
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return widget.selectedDepartment == 'All' &&
                                    widget.selectedYear.toString() ==
                                        data[index].alumniBatch ||
                                widget.selectedDepartment ==
                                        data[index].alumniBranch &&
                                    widget.selectedYear.toString() ==
                                        data[index].alumniBatch
                            ? FadeIn(
                                child: Container(
                                  width: 170,
                                  height: 100,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 0,
                                    vertical: 5,
                                  ),
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 5,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                              data[index].alumniImageUrl,
                                            ),
                                          ),
                                          Text(
                                            data[index].alumniName,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: const TextStyle(
                                              fontFamily: 'IBMPlexMono',
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                data[index].alumniBranch,
                                                style: const TextStyle(
                                                  fontFamily: 'IBMPlexMono',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              CircleAvatar(
                                                radius: 2,
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .outline,
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                data[index].alumniBatch,
                                                style: const TextStyle(
                                                  fontFamily: 'IBMPlexMono',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox();
                      },
                    )
                  : ListView.builder(
                      itemCount: data.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return widget.selectedDepartment == 'All' &&
                                    widget.selectedYear.toString() ==
                                        data[index].alumniBatch ||
                                widget.selectedDepartment ==
                                        data[index].alumniBranch &&
                                    widget.selectedYear.toString() ==
                                        data[index].alumniBatch
                            ? FadeIn(
                                child: Container(
                                  width: screenWidth * 0.9,
                                  height: 100,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 5),
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                              data[index].alumniImageUrl,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data[index].alumniName,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                    fontFamily: 'IBMPlexMono',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      data[index].alumniBranch,
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            'IBMPlexMono',
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 5),
                                                    CircleAvatar(
                                                      radius: 2,
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .outline,
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      data[index]
                                                          .alumniBatch
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            'IBMPlexMono',
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ]),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox();
                      },
                    ),
            );
          },
          error: (error, stackTrace) {
            return const SizedBox();
          },
          loading: () {
            return const SizedBox();
          },
        ),
      ),
    );
  }

  bool hasAlumnis(BuildContext context) {
    // Implement the logic to check if there are any alumnis based on the selectedDepartment and selectedYear.
    return ref.watch(alumniDataProvider).when(
      data: (data) {
        for (var alumni in data) {
          if (widget.selectedDepartment == 'All' &&
                  widget.selectedYear.toString() == alumni.alumniBatch ||
              widget.selectedDepartment == alumni.alumniBranch &&
                  widget.selectedYear.toString() == alumni.alumniBatch) {
            return true;
          }
        }
        return false;
      },
      error: (error, stackTrace) {
        return false;
      },
      loading: () {
        return true;
      },
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weathercubit/cubit/data_cubit.dart';
import 'package:weathercubit/cubit/data_state.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    context.read<DataCubit>().fetchData(city);
    super.initState();
  }

  String city = "auto:ip";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 57, 184, 179),
      body: BlocConsumer<DataCubit, DataState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is DataLoaded) {
            if (state.weatherdata?["error"] != null &&
                state.weatherdata?["error"]["code"] == 1006) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.menu,
                                color: Colors.white,
                              )),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 20.0),
                              child: Autocomplete<String>(
                                optionsBuilder:
                                    (TextEditingValue textEditingValue) {
                                  // If the input is empty, return an empty list
                                  if (textEditingValue.text.isEmpty) {
                                    return const Iterable<String>.empty();
                                  }
                                  // Filter city names based on the input text
                                  return (state.citys as List<String>?)?.where(
                                          (city) => city.toLowerCase().contains(
                                              textEditingValue.text
                                                  .toLowerCase())) ??
                                      [];
                                },
                                onSelected: (String selection) {
                                  city = selection;
                                  context.read<DataCubit>().fetchData(city);
                                },
                                fieldViewBuilder: (context, controller,
                                    focusNode, onFieldSubmitted) {
                                  return TextField(
                                    controller: controller,
                                    focusNode: focusNode,
                                    decoration: InputDecoration(
                                      labelText: "Search City",
                                      border: OutlineInputBorder(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                city = "auto:ip";
                                context.read<DataCubit>().fetchData(city);
                              },
                              icon: const Icon(
                                Icons.search,
                                color: Colors.white,
                              )),
                        ]),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "City not found",
                      style: GoogleFonts.roboto(color: Colors.white),
                    ),
                  ],
                ),
              );
            }
            return SingleChildScrollView(
              child: Column(children: [
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.menu,
                              color: Colors.white,
                            )),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 20.0),
                            child: Autocomplete<String>(
                              optionsBuilder:
                                  (TextEditingValue textEditingValue) {
                                // If the input is empty, return an empty list
                                if (textEditingValue.text.isEmpty) {
                                  return const Iterable<String>.empty();
                                }
                                // Filter city names based on the input text
                                return (state.citys as List<String>?)?.where(
                                        (city) => city.toLowerCase().contains(
                                            textEditingValue.text
                                                .toLowerCase())) ??
                                    [];
                              },
                              onSelected: (String selection) {
                                city = selection;
                                context.read<DataCubit>().fetchData(city);
                              },
                              fieldViewBuilder: (context, controller, focusNode,
                                  onFieldSubmitted) {
                                return TextField(
                                  controller: controller,
                                  focusNode: focusNode,
                                  decoration: InputDecoration(
                                    labelText: "Search City",
                                    border: OutlineInputBorder(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              city = "auto:ip";
                              context.read<DataCubit>().fetchData(city);
                            },
                            icon: const Icon(
                              Icons.location_pin,
                              color: Colors.white,
                            )),
                      ]),
                  Text(
                    "${state.weatherdata!["location"]["name"]}  , ${state.weatherdata?["location"]["country"]}",
                    style:
                        GoogleFonts.roboto(fontSize: 30, color: Colors.white),
                  ),
                  Text(
                    "${state.weatherdata!["location"]["localtime"]}",
                    style:
                        GoogleFonts.roboto(fontSize: 30, color: Colors.white),
                  ),
                ]),
                const SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.network(
                          height: 50,
                          width: 50,
                          "http:${state.weatherdata!["current"]["condition"]["icon"]}"),
                      Text(
                        "${state.weatherdata!["current"]["condition"]["text"]}",
                        style: GoogleFonts.roboto(
                            fontSize: 36, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${state.weatherdata!["current"]["temp_c"]}\u00B0",
                          style: GoogleFonts.poppins(
                              fontSize: 150, color: Colors.amber),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          "${state.weatherdata!["current"]["feelslike_c"]}\u2103",
                          style: GoogleFonts.roboto(
                              fontSize: 25, color: Colors.white),
                        ),
                        Text(
                          "${state.weatherdata!["current"]["windchill_c"]}\u2103",
                          style: GoogleFonts.roboto(
                              fontSize: 25, color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "7Days Forecast",
                        style: GoogleFonts.roboto(
                            fontSize: 30, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: SizedBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state
                              .weatherdata!['forecast']['forecastday'].length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: 130,
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      side: const BorderSide(
                                          color: Colors.white, width: 1),
                                    ),
                                    color:
                                        const Color.fromARGB(255, 42, 48, 68),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${state.weatherdata!['forecast']['forecastday'][index]['date']}",
                                            style: GoogleFonts.roboto(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                          Image.network(
                                              "http:${state.weatherdata!['forecast']['forecastday'][index]['day']['condition']['icon']}"),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "${state.weatherdata!['forecast']['forecastday'][index]['day']['maxtemp_c']}\u2103",
                                            style: GoogleFonts.roboto(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            );
                          })),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SingleChildScrollView(
                    child: SizedBox(
                        height: 170,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: state
                                .weatherdata!['forecast']['forecastday'].length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                width: 200,
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        side: const BorderSide(
                                            color: Colors.white, width: 1),
                                      ),
                                      color: Colors.transparent,
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "${state.weatherdata!['forecast']['forecastday'][index]['date']}",
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 15,
                                                          color: Colors.white),
                                                    ),
                                                  ]),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "${state.weatherdata!['forecast']['forecastday'][index]['date']}",
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 15,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    "${state.weatherdata!['forecast']['forecastday'][index]['day']['maxtemp_c']}\u2103",
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 45,
                                                        color: Colors.white),
                                                  ),
                                                  Image.network(
                                                    "http:${state.weatherdata!['forecast']['forecastday'][index]['day']['condition']['icon']}",
                                                  )
                                                ],
                                              ),
                                            ]),
                                      ),
                                    )),
                              );
                            })),
                  ),
                ),
              ]),
            );
          } else if (state is DataError) {
            return Text(state.error);
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

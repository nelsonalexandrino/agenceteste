import 'dart:async';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../pages/products_page.dart';
import '../providers/products_provider.dart';

class ProductsDetails extends StatefulWidget {
  const ProductsDetails({super.key});

  @override
  State<ProductsDetails> createState() => _ProductsDetailsState();
}

class _ProductsDetailsState extends State<ProductsDetails> {
  CameraPosition? _myLocation;
  LocationPermission? permission;

  late GoogleMapController mapController;

  final _markers = <Marker>[];

  final LatLng _defaultLocation = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((position) {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            bearing: 0,
            target: LatLng(position.latitude, position.longitude),
            zoom: 11.0,
          ),
        ),
      );

      final marker = Marker(
        markerId: const MarkerId('Localização'),
        position: LatLng(position.latitude, position.longitude),
      );
      setState(() {
        _markers.add(marker);
      });
      debugPrint(position.altitude.toString());
      debugPrint(position.longitude.toString());
    });
  }

  bool _accepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(FluentIcons.cart_24_filled))
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              SizedBox(
                height: constraints.maxHeight / 3,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  myLocationButtonEnabled: false,
                  markers: _markers.toSet(),
                  initialCameraPosition: _myLocation ??
                      CameraPosition(target: _defaultLocation, zoom: 11),
                ),
              ),
              Consumer<ProductProvider>(builder: (context, provider, _) {
                if (provider.selectedProductIndex != null) {
                  return Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(provider.selectedProduct.image),
                      )),
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${provider.selectedProduct.name} ${(provider.selectedProductIndex! + 1).toString()}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(provider.selectedProduct.description),
                              ],
                            ),
                          ))
                    ],
                  );
                }
                return const Center(
                  child: Text('Não tem produto selecionado'),
                );
              })
            ],
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          height: 45,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
              child: const Text('Comprar'),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isDismissible: false,
                  builder: (context) {
                    _accepted = false;
                    return Container(
                      color: Colors.white,
                      height: 200,
                      child: StatefulBuilder(
                        builder: (context, changeState) => SafeArea(
                          child: !_accepted
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, top: 10),
                                          child: Text(
                                            'Confirma',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall,
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, top: 20),
                                          child: Text(
                                              'Por favor, confirme se deseja comprar'),
                                        ),
                                      ],
                                    ),
                                    if (!_accepted)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Não'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              changeState(
                                                  () => _accepted = true);
                                            },
                                            child: const Text('Sim'),
                                          )
                                        ],
                                      )
                                  ],
                                )
                              : Builder(
                                  builder: (context) {
                                    Timer(
                                      const Duration(seconds: 3),
                                      () {
                                        Navigator.pushReplacementNamed(
                                            context, ProductsPage.routeName);
                                      },
                                    );
                                    return const Center(
                                      child: Text(
                                        'Compra feita com sucesso',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ),
                    );
                  },
                );

                // showDialog(
                //   context: context,
                //   barrierDismissible: false,
                //   builder: (context) => AlertDialog(
                //     title: const Text('Comprar?'),
                //     content:
                //         const Text('Por favor, confirme se deseja comprar'),
                //     actions: !_accepted
                //         ? [
                //             TextButton(
                //               onPressed: () {
                //                 Navigator.pop(context);
                //               },
                //               child: const Text('Não'),
                //             ),
                //             TextButton(
                //               onPressed: () {
                //                 setState(() {
                //                   _accepted = true;
                //                 });
                //               },
                //               child: const Text('Sim'),
                //             )
                //           ]
                //         : null,
                //   ),
                // );
              }),
        ),
      ),
    );
  }
}

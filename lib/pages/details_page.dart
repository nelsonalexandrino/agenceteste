import 'package:agenceteste/providers/products_provider.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class ProductsDetails extends StatefulWidget {
  const ProductsDetails({super.key});

  @override
  State<ProductsDetails> createState() => _ProductsDetailsState();
}

class _ProductsDetailsState extends State<ProductsDetails> {
  CameraPosition? _myLocation;
  LocationPermission? permission;

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Geolocator.getCurrentPosition().then((position) {
      setState(() {
        print(position.altitude);
        print(position.longitude);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              SizedBox(
                height: constraints.maxHeight / 3,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition:
                      _myLocation ?? CameraPosition(target: _center, zoom: 11),
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
    );
  }
}

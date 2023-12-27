import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_assignment/src/device/ext.dart';
import 'package:weather_app_assignment/src/device/l10n.dart';
import 'package:weather_app_assignment/src/model/weather_model.dart';
import 'package:weather_app_assignment/src/service/repository/weather_repo.dart';
import 'package:weather_app_assignment/src/shared/base/do_action.dart';
import 'package:weather_app_assignment/src/shared/base/guarded_future.dart';
import 'package:weather_app_assignment/src/shared/theme/color.dart';
import 'package:weather_app_assignment/src/shared/util/dialog_util.dart';
import 'package:geocoding/geocoding.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  createState() => _State();
}

class _State extends State<HomeScreen> with ActionMixin {
  WeatherModel? _weatherModel;
  Placemark? _placemark;
  final TextEditingController _editingController = TextEditingController();

  @override
  Widget build(BuildContext context) => GuardedFutureBuilder(
      init: _init,
      builder: (ctx) => Scaffold(
            body: Container(
              padding: const EdgeInsets.only(top: 46, left: 16, right: 16),
              decoration: const BoxDecoration(gradient: backgroundDecoration),
              child: Column(
                children: [
                  _searchView(),
                  Image.asset(
                    'assets/icon/ic_sun.png',
                    width: 180,
                    height: 180,
                  ),
                  ..._weatherCurrentView(),
                  const SizedBox(
                    height: 4,
                  ),
                  Expanded(child: _hourlyView())
                ],
              ),
            ),
          ),
      actionMixin: this);

  _weatherCurrentView() => [
        const SizedBox(
          height: 4,
        ),
        Text(
          _weatherModel?.current?.temperature2m != null
              ? '${_weatherModel?.current?.temperature2m} ${_weatherModel?.currentUnits?.temperature2m}'
              : _weatherModel?.current?.temperature2m?.toString() ??
                  'Not found',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          _weatherModel?.current?.windSpeed10m != null
              ? '${_weatherModel?.current?.windSpeed10m} ${_weatherModel?.currentUnits?.windSpeed10m}'
              : _weatherModel?.current?.windSpeed10m?.toString() ?? '',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          _placemark?.administrativeArea ?? '',
          style: Theme.of(context).textTheme.bodyLarge,
        )
      ];

  _hourlyView() => GridView.builder(
      itemCount: _weatherModel?.hourly?.time?.length ?? 0,
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, childAspectRatio: 1 / 1.1),
      itemBuilder: (ctx, index) => Card(
            color: neuralColor.shade100.withAlpha(50),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      _weatherModel?.hourly?.time?[index].toHourMinute() ?? ''),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                      '${_weatherModel?.hourly?.temperature2m?[index]} ${_weatherModel?.hourlyUnits?.temperature2m}'),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                      '${_weatherModel?.hourly?.relativeHumidity2m?[index]} ${_weatherModel?.hourlyUnits?.relativeHumidity2m}')
                ],
              ),
            ),
          ));

  _searchView() => TextField(
        controller: _editingController,
        decoration: InputDecoration(
            hintText: 'Search by city, zip code, province',
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            suffixIcon: Visibility(
              visible: _editingController.text.isNotEmpty,
              child: InkWell(
                onTap: () => setState(() {
                  _editingController.clear();
                }),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            )),
        onChanged: (text) => setState(() {}),
        onSubmitted: (text) => _searchWeather(text),
        cursorColor: Colors.white,
      );

  _init() async {
    if (await _checkPermission()) {
      showLoading();
      final location = await Geolocator.getCurrentPosition();
      final weather = await WeatherRepo.searchWeather(
          location.latitude, location.longitude);
      _placemark = (await placemarkFromCoordinates(
              location.latitude, location.longitude))
          .firstOrNull;
      if (!mounted) return;
      hideLoading();
      setState(() {
        _weatherModel = WeatherModel.fromJson(weather);
      });
    }
  }

  _searchWeather(String query) async {
    if (await _checkPermission()) {
      try {
        List<Location> locations = await locationFromAddress(query);
        if (locations.isNotEmpty) {
          final data = await doAction<dynamic>(() async {
            return await WeatherRepo.searchWeather(
                locations.first.latitude, locations.first.longitude);
          });
          _placemark = (await placemarkFromCoordinates(
                  locations.first.latitude, locations.first.longitude))
              .firstOrNull;
          if (!mounted) return;
          setState(() {
            _weatherModel = WeatherModel.fromJson(data);
          });
        } else {
          if (!mounted) return;
          showOk(context, message: L(context).not_found);
        }
      } catch (_) {
        if (!mounted) return;
        showOk(context, message: L(context).not_found);
      }
    }
  }

  _checkPermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    var permission = await Geolocator.checkPermission();
    if (serviceEnabled) {
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
    }
    return serviceEnabled && permission == LocationPermission.whileInUse;
  }
}

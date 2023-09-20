import 'dart:async';

import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

class DescarteController extends GetxController {

  final latitude = 0.0.obs;
  final longitude = 0.0.obs;
  late StreamSubscription<Position> positionStream;

  static DescarteController get to => Get.find<DescarteController>();

  /**
   * Acompanha a posição atual do usuário.
   */
  void watchPosition() async{

    positionStream = Geolocator.getPositionStream().listen((position) {

      if(position != null){

        latitude.value = position.latitude;
        longitude.value = position.longitude;

      }

    });

  }

  /**
   * Fecha o positionStream para evitar o uso desnecessário de memória.
   */
  @override
  void onClose(){

    positionStream.cancel();
    super.onClose();

  }

  /**
   * @author Giovane Neves
   * @since 2023-09-19 12:12
   *
   * Pega a posição atual do usuário.
   */
  Future<Position> _currentPosition() async {

    LocationPermission permission;
    bool isActive = await Geolocator.isLocationServiceEnabled();

    if (!isActive) {
      return Future.error("Por favor, habilite a localização no seu smartphone.");
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Você precisa autorizar o acesso à localização");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Autorize o acesso à localização nas configurações.");
    }

    return await Geolocator.getCurrentPosition();
  }

  /**
   * Pega posição atual do usuário.
   */
  getPosition() async {

    try {

      final position = await _currentPosition();

      latitude.value = position.latitude;
      longitude.value = position.longitude;

    } catch (e) {
      Get.snackbar(
                    'Erro',
                    e.toString(),
                    backgroundColor: Colors.grey[900],
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
      );
    }

  }
}
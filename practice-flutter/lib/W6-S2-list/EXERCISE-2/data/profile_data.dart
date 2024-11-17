import 'package:flutter/material.dart';
import 'package:testapp1/W6-S2-list/EXERCISE-2/model/profile_tile_model.dart';
ProfileData ronanProfile = ProfileData(
    name: "Ronan",
    position: "Flutter Developer",
    avatarUrl: 'assets/w4-s2/man.jpg',
    tiles: [
      TileData( icon: Icons.phone, title: "Phone Number", value: "+123 456 7890"),
      TileData(icon: Icons.location_on, title: "Address", value: "123 Cambodia"),
      TileData(icon: Icons.email, title: "Mail", value: "ronan.ogogr@cadt.edu"),
    ]);

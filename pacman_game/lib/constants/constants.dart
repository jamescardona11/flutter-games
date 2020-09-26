import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final titleStyle = GoogleFonts.pressStart2p(textStyle: TextStyle(color: Colors.white, letterSpacing: 2, fontSize: 32));

enum GhostTypes { BLUE, LIGHT_BLUE, GREEN, LIGHT_GREEN, PINK, RED }

class GhostConstants {
  static const Map<GhostTypes, String> ghostsMap = {
    GhostTypes.BLUE: 'enemies/ghosts/ghost_blue.png',
    GhostTypes.LIGHT_BLUE: 'enemies/ghosts/ghost_light_blue.png',
    GhostTypes.GREEN: 'enemies/ghosts/ghost_green.png',
    GhostTypes.LIGHT_GREEN: 'enemies/ghosts/ghost_light_green.png',
    GhostTypes.PINK: 'enemies/ghosts/ghost_pink.png',
    GhostTypes.RED: 'enemies/ghosts/ghost_red.png',
  };
}

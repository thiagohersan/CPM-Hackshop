#!/bin/bash
say() { local IFS=+;/usr/bin/mplayer -ao alsa -volume 200 -really-quiet -noconsolecontrols "http://translate.google.com/translate_tts?ie=UTF-8&client=tw-ob&q=$*&tl=Pt-br"; }
say $*

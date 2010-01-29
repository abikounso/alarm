#!/usr/bin/env python
import datetime
import pygame
import time

while 1:
    dt = datetime.datetime.now()
    mo = dt.month
    d = dt.day
    h = dt.hour
    mi = dt.minute
    t = (h, mi)
    w = dt.weekday()
    wav = ''

    if w in list(range(0, 5)):
        if mo == 1:
            ho = 20
        elif (mo == 2 and d >= 16) or (mo == 3 and d <= 15):
            ho = 21

        if ((mo in list(range(4, 12))) and t == (8, 20)) or ((h in [9, 12, 17, 18]) and mi == 0):
            wav = 'chaim.wav'
        elif t == (8, 56):
            wav = 'manner_mode.wav'
        elif t == (13, 0):
            if w in [0, 2, 4]:
                wav = 'radio_exercise01.wav'
            elif w in [1, 3]:
                wav = 'radio_exercise02.wav'
        elif w == 3 and t == (13, 4):
            wav = 'all_cleaning.wav'
        elif t == (ho, 45):
            wav = 'before_15minutes.wav'
        elif t == (ho, 58):
            wav = 'hotaru.wav'
    
    if wav != '':
        pygame.init()
        pygame.mixer.music.load(wav)
        pygame.mixer.music.play()
        time.sleep(210)
    else:
        time.sleep(1)


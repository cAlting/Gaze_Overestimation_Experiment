# -*- coding: utf-8 -*-
"""
Created on Thu Apr 27 16:03:26 2023

@author: calti
"""

def center_image_mlx(image, landmarks, lm1 = 39, lm2 = 42, suppress_output = True):

    # get image width, height and center coordinates
    height, width, chann = image.shape
    
    # Center of Original Input Image
    wi=(width/2)
    he=(height/2)

    # x, y, und z Koordinaten des relevanten Punktes
    # ipp1, ..., enthalten jeweils die x-, y- und z-Koordinaten der Landmark in normalisierter Einheit [0,1]
    lm1_x = landmarks[lm1][0]
    lm1_y = landmarks[lm1][1]
    
    lm2_x = landmarks[lm2][0]
    lm2_y = landmarks[lm2][1]
    
    # Bestimmung der x-Koordinate des Mittelpunktes zwischen C. lacrimalis rechts und links
    # ipp2_x_px: x-Koordinate der C. lacrimalis rechts (landmark 362) [Pixel]
    # ipp1_x_px: x-Koordinate der C. lacrimalis links (landmark 133)  [Pixel]
    # ipp_half: x-Koordinate der C. lacrimalis links + die Hälfte der Distanz zwischen lm362 und lm133 [Pixel]
    #  - dies ist die x-Koordinate des Punktes, der später bei x = Bildbreite/2 liegen soll
    ipp_half = lm1_x+(lm2_x-lm1_x)/2
    
    # Bestimmung der y-Koordinate des Punktes, der später bei y = Bildhöhe/2 liegen soll
    if lm1_y < lm2_y:
        ipp_half_2 = lm1_y+(lm2_y-lm1_y)/2
    else:
        ipp_half_2 = lm2_y+(lm1_y-lm2_y)/2
    
    # Bestimmung des Winkels zwischen der Linie zwischen C.l. sinister und dextra
    dX = lm2_x - lm1_x
    dY = lm2_y - lm2_y
    angle = np.degrees(np.arctan2(dY, dX))
    
    # Offset = Differenz zwischen (x,y) des Bildzentrums und (x,y) der Landmark
    #offsetX = (wi-ipp_half)
    #offsetY = (he-ipp_half_2)
    offsetX = (wi-ipp_half)
    offsetY = (he-ipp_half_2)
    
    if suppress_output == False:
        msg = f'''
        EyeL x:   {lm1_x}
        EyeR x:   {lm2_x}
        EyeL y:   {lm1_y}
        EyeR y:   {lm2_y}
        IPP x:    {ipp_half}
        IPP y:    {ipp_half_2}
        Offset x: {offsetX}
        Offset y: {offsetY}
        Angle:    {angle}
        \n\n
        '''
        print(msg)
    
    # Affine matrix with Translations
    T = np.float32([[1, 0, offsetX], [0, 1, offsetY]]) 
    
    # WarpAffine
    centered_image = cv2.warpAffine(image, T, (width, height))
    
    # Return translated Image, x-Koordinate des Punktes zwischen C.l. sinistra und dextra, Winkel
    return centered_image, ipp_half, ipp_half_2, angle
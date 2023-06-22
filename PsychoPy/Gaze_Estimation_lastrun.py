#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
This experiment was created using PsychoPy3 Experiment Builder (v2022.2.4),
    on Mai 15, 2023, at 13:04
If you publish work using this script the most relevant publication is:

    Peirce J, Gray JR, Simpson S, MacAskill M, Höchenberger R, Sogo H, Kastman E, Lindeløv JK. (2019) 
        PsychoPy2: Experiments in behavior made easy Behav Res 51: 195. 
        https://doi.org/10.3758/s13428-018-01193-y

"""

import psychopy
psychopy.useVersion('2022.2.4')


# --- Import packages ---
from psychopy import locale_setup
from psychopy import prefs
from psychopy import sound, gui, visual, core, data, event, logging, clock, colors, layout
from psychopy.constants import (NOT_STARTED, STARTED, PLAYING, PAUSED,
                                STOPPED, FINISHED, PRESSED, RELEASED, FOREVER)

import numpy as np  # whole numpy lib is available, prepend 'np.'
from numpy import (sin, cos, tan, log, log10, pi, average,
                   sqrt, std, deg2rad, rad2deg, linspace, asarray)
from numpy.random import random, randint, normal, shuffle, choice as randchoice
import os  # handy system and path functions
import sys  # to get file system encoding

from psychopy.hardware import keyboard



# Ensure that relative paths start from the same directory as this script
_thisDir = os.path.dirname(os.path.abspath(__file__))
os.chdir(_thisDir)
# Store info about the experiment session
psychopyVersion = '2022.2.4'
expName = 'Gaze_Estimation'  # from the Builder filename that created this script
expInfo = {
    'participant': f"{randint(0, 999999):06.0f}",
    'subject_gender': ["m", "w", "d"],
    'subject_age': f"{randint(18, 35):02.0f}",
}
# --- Show participant info dialog --
dlg = gui.DlgFromDict(dictionary=expInfo, sortKeys=False, title=expName)
if dlg.OK == False:
    core.quit()  # user pressed cancel
expInfo['date'] = data.getDateStr()  # add a simple timestamp
expInfo['expName'] = expName
expInfo['psychopyVersion'] = psychopyVersion

# Data file name stem = absolute path + name; later add .psyexp, .csv, .log, etc
filename = _thisDir + os.sep + u'data/%s_%s_%s' % (expInfo['participant'], expName, expInfo['date'])

# An ExperimentHandler isn't essential but helps with data saving
thisExp = data.ExperimentHandler(name=expName, version='',
    extraInfo=expInfo, runtimeInfo=None,
    originPath='C:\\Users\\calti\\Documents\\Masterarbeit\\PsychoPy\\Gaze_Estimation_lastrun.py',
    savePickle=True, saveWideText=True,
    dataFileName=filename)
# save a log file for detail verbose info
logFile = logging.LogFile(filename+'.log', level=logging.EXP)
logging.console.setLevel(logging.WARNING)  # this outputs to the screen, not a file

endExpNow = False  # flag for 'escape' or other condition => quit the exp
frameTolerance = 0.001  # how close to onset before 'same' frame

# Start Code - component code to be run after the window creation

# --- Setup the Window ---
win = visual.Window(
    size=[1280, 1024], fullscr=False, screen=0, 
    winType='pyglet', allowStencil=False,
    monitor='testMonitor', color=[0,0,0], colorSpace='rgb',
    blendMode='avg', useFBO=True, 
    units='norm')
win.mouseVisible = True
# store frame rate of monitor if we can measure it
expInfo['frameRate'] = win.getActualFrameRate()
if expInfo['frameRate'] != None:
    frameDur = 1.0 / round(expInfo['frameRate'])
else:
    frameDur = 1.0 / 60.0  # could not measure, so guess
# --- Setup input devices ---
ioConfig = {}
ioSession = ioServer = eyetracker = None

# create a default keyboard (e.g. to check for escape)
defaultKeyboard = keyboard.Keyboard(backend='ptb')

# --- Initialize components for Routine "instructions_start" ---
# Run 'Begin Experiment' code from code
# duration of instruction (start)
d_inst_start = 1

# duration of instruction (training)
d_inst_train = 1

# duration of instruction (exp)
d_inst_exp = 1

# duration of iti (ext and training)
d_iti = 0.5
inst_exp = visual.TextStim(win=win, name='inst_exp',
    text='Herzlich Willkommen.\n\nIn dieser Studie untersuchen wir, wie wir die Blicke anderer Personen wahrnehmen.\n\nDazu werden Ihnen im Folgenden die Fotos verschiedener Personen gezeigt. Ihre Aufgabe besteht darin, die Blickrichtung der gerade auf dem Bildschirm präsentierten Person einzuschätzen.\n\nGenauer geht es darum, einzuschätzen, welchen Punkt der vor Ihnen platzierten Leiste die Person in dem Foto anschaut. Wenn Sie sich entschieden haben, geben Sie Ihr Urteil bitte in die dafür vorgesehene Textbox auf dem Bildschirm ein.\n\n\n',
    font='Open Sans',
    pos=(0, 0), height=0.05, wrapWidth=1.75, ori=0.0, 
    color='white', colorSpace='rgb', opacity=None, 
    languageStyle='LTR',
    depth=-1.0);
inst_exp_continue = visual.TextStim(win=win, name='inst_exp_continue',
    text='Herzlich Willkommen.\n\nIn dieser Studie untersuchen wir, wie wir die Blicke anderer Personen wahrnehmen.\n\nDazu werden Ihnen im Folgenden die Fotos verschiedener Personen gezeigt. Ihre Aufgabe besteht darin, die Blickrichtung der gerade auf dem Bildschirm präsentierten Person einzuschätzen.\n\nGenauer geht es darum, einzuschätzen, welchen Punkt der vor Ihnen platzierten Leiste die Person in dem Foto anschaut. Wenn Sie sich entschieden haben, geben Sie Ihr Urteil bitte in die dafür vorgesehene Textbox auf dem Bildschirm ein.\n\n\nWeiter durch Drücken der LEERTASTE',
    font='Open Sans',
    pos=(0, 0), height=0.05, wrapWidth=1.75, ori=0.0, 
    color='white', colorSpace='rgb', opacity=None, 
    languageStyle='LTR',
    depth=-2.0);
kb_inst_start = keyboard.Keyboard()

# --- Initialize components for Routine "instructions_training" ---
inst_train = visual.TextStim(win=win, name='inst_train',
    text='Trainingsblock\n\nIn den folgenden 10 Durchgängen haben Sie die Möglichkeit, sich mit dem Ablauf des Experimentes vertraut zu machen. \n\nDie Aufgabe:\nBitte schätzen Sie unter Zuhilfenahme der vor Ihnen platzierten Leiste und Skala den Punkt auf der Leiste/Skala ein, der von der auf dem Bildschirm präsentierten Person angeschaut wird. \nGeben Sie Ihr Urteil bitte in die dafür vorgesehene Textbox ein.\n\nIm Anschluss an das Training haben Sie die Möglichkeit, mögliche Fragen mit dem:der Versuchsleiter:in zu klären.\n\n',
    font='Open Sans',
    pos=(0, 0), height=0.05, wrapWidth=1.75, ori=0.0, 
    color='white', colorSpace='rgb', opacity=None, 
    languageStyle='LTR',
    depth=0.0);
inst_train_continue = visual.TextStim(win=win, name='inst_train_continue',
    text='Trainingsblock\n\nIn den folgenden 10 Durchgängen haben Sie die Möglichkeit, sich mit dem Ablauf des Experimentes vertraut zu machen. \n\nDie Aufgabe:\nBitte schätzen Sie unter Zuhilfenahme der vor Ihnen platzierten Leiste und Skala den Punkt auf der Leiste/Skala ein, der von der auf dem Bildschirm präsentierten Person angeschaut wird. \nGeben Sie Ihr Urteil bitte in die dafür vorgesehene Textbox ein.\n\nIm Anschluss an das Training haben Sie die Möglichkeit, mögliche Fragen mit dem:der Versuchsleiter:in zu klären.\n\nWeiter durch Drücken der LEERTASTE',
    font='Open Sans',
    pos=(0, 0), height=0.05, wrapWidth=1.75, ori=0.0, 
    color='white', colorSpace='rgb', opacity=None, 
    languageStyle='LTR',
    depth=-1.0);
key_inst_train = keyboard.Keyboard()

# --- Initialize components for Routine "ITI_Training" ---
text_iti_train = visual.TextStim(win=win, name='text_iti_train',
    text=None,
    font='Open Sans',
    pos=(0, 0), height=0.05, wrapWidth=None, ori=0.0, 
    color='white', colorSpace='rgb', opacity=None, 
    languageStyle='LTR',
    depth=0.0);
noise = visual.NoiseStim(
    win=win, name='noise',units='norm', 
    noiseImage=None, mask=None,
    ori=0.0, pos=(0, 0), size=(2, 2), sf=None,
    phase=0.0,
    color=[1,1,1], colorSpace='rgb',     opacity=None, blendmode='add', contrast=1.0,
    texRes=128, filter=None,
    noiseType='White', noiseElementSize=[0.0625], 
    noiseBaseSf=8.0, noiseBW=1.0,
    noiseBWO=30.0, noiseOri=0.0,
    noiseFractalPower=0.0,noiseFilterLower=1.0,
    noiseFilterUpper=8.0, noiseFilterOrder=0.0,
    noiseClip=3.0, imageComponent='Phase', interpolate=False, depth=-1.0)
noise.buildNoise()

# --- Initialize components for Routine "training" ---
img_training = visual.ImageStim(
    win=win,
    name='img_training', units='norm', 
    image='sin', mask=None, anchor='center',
    ori=0.0, pos=(0, 0), size=(2, 2),
    color=[1,1,1], colorSpace='rgb', opacity=None,
    flipHoriz=False, flipVert=False,
    texRes=128.0, interpolate=True, depth=0.0)
judgement = visual.TextBox2(
     win, text=None, font='Open Sans',
     pos=(0, -0.9),units='norm',     letterHeight=0.05,
     size=(0.15, 0.1), borderWidth=1.0,
     color='white', colorSpace='rgb',
     opacity=0.5,
     bold=False, italic=False,
     lineSpacing=1.0,
     padding=0.0, alignment='center',
     anchor='center',
     fillColor=[0.0039, 0.0039, 0.0039], borderColor=[-0.3020, -0.3020, -0.3020],
     flipHoriz=False, flipVert=False, languageStyle='LTR',
     editable=False,
     name='judgement',
     autoLog=True,
)

# --- Initialize components for Routine "instructions_exp" ---
instr_ex = visual.TextStim(win=win, name='instr_ex',
    text='Trainingsdurchgänge abgeschlossen.\nBei Fragen wenden Sie sich bitte an den:die Versuchsleiter:in im Nebenraum.\n\n\nExperiment durch Drücken der LEERTASTE beginnen.',
    font='Open Sans',
    pos=(0, 0), height=0.05, wrapWidth=None, ori=0.0, 
    color='white', colorSpace='rgb', opacity=None, 
    languageStyle='LTR',
    depth=0.0);
instr_ex_cont = visual.TextStim(win=win, name='instr_ex_cont',
    text='Trainingsdurchgänge abgeschlossen.\nBei Fragen wenden Sie sich bitte an den:die Versuchsleiter:in im Nebenraum.\n\n\nExperiment durch Drücken der LEERTASTE beginnen.',
    font='Open Sans',
    pos=(0, 0), height=0.05, wrapWidth=None, ori=0.0, 
    color='white', colorSpace='rgb', opacity=None, 
    languageStyle='LTR',
    depth=-1.0);
kb_inst_exp = keyboard.Keyboard()

# --- Initialize components for Routine "ITI_Exp" ---
text_iti_exp = visual.TextStim(win=win, name='text_iti_exp',
    text=None,
    font='Open Sans',
    pos=(0, 0), height=0.05, wrapWidth=None, ori=0.0, 
    color='white', colorSpace='rgb', opacity=None, 
    languageStyle='LTR',
    depth=0.0);

# --- Initialize components for Routine "experiment" ---
img_exp = visual.ImageStim(
    win=win,
    name='img_exp', units='norm', 
    image='sin', mask=None, anchor='center',
    ori=0.0, pos=(0, 0), size=(2, 2),
    color=[1,1,1], colorSpace='rgb', opacity=None,
    flipHoriz=False, flipVert=False,
    texRes=128.0, interpolate=True, depth=0.0)
judgement_exp = visual.TextBox2(
     win, text=None, font='Open Sans',
     pos=(0, -0.9),units='norm',     letterHeight=0.05,
     size=(0.15, 0.1), borderWidth=1.0,
     color='white', colorSpace='rgb',
     opacity=0.5,
     bold=False, italic=False,
     lineSpacing=1.0,
     padding=0.0, alignment='center',
     anchor='center',
     fillColor=[0.0039, 0.0039, 0.0039], borderColor=[-0.3020, -0.3020, -0.3020],
     flipHoriz=False, flipVert=False, languageStyle='LTR',
     editable=False,
     name='judgement_exp',
     autoLog=True,
)

# --- Initialize components for Routine "end_screen" ---
text = visual.TextStim(win=win, name='text',
    text='Vielen Dank für Ihre Teilnahme.\n\nBitte melden Sie sich bei dem:der Versuchsleiter:in.',
    font='Open Sans',
    units='norm', pos=(0, 0), height=0.05, wrapWidth=None, ori=0.0, 
    color='white', colorSpace='rgb', opacity=None, 
    languageStyle='LTR',
    depth=0.0);

# Create some handy timers
globalClock = core.Clock()  # to track the time since experiment started
routineTimer = core.Clock()  # to track time remaining of each (possibly non-slip) routine 

# --- Prepare to start Routine "instructions_start" ---
continueRoutine = True
routineForceEnded = False
# update component parameters for each repeat
kb_inst_start.keys = []
kb_inst_start.rt = []
_kb_inst_start_allKeys = []
# keep track of which components have finished
instructions_startComponents = [inst_exp, inst_exp_continue, kb_inst_start]
for thisComponent in instructions_startComponents:
    thisComponent.tStart = None
    thisComponent.tStop = None
    thisComponent.tStartRefresh = None
    thisComponent.tStopRefresh = None
    if hasattr(thisComponent, 'status'):
        thisComponent.status = NOT_STARTED
# reset timers
t = 0
_timeToFirstFrame = win.getFutureFlipTime(clock="now")
frameN = -1

# --- Run Routine "instructions_start" ---
while continueRoutine:
    # get current time
    t = routineTimer.getTime()
    tThisFlip = win.getFutureFlipTime(clock=routineTimer)
    tThisFlipGlobal = win.getFutureFlipTime(clock=None)
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # *inst_exp* updates
    if inst_exp.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
        # keep track of start time/frame for later
        inst_exp.frameNStart = frameN  # exact frame index
        inst_exp.tStart = t  # local t and not account for scr refresh
        inst_exp.tStartRefresh = tThisFlipGlobal  # on global time
        win.timeOnFlip(inst_exp, 'tStartRefresh')  # time at next scr refresh
        # add timestamp to datafile
        thisExp.timestampOnFlip(win, 'inst_exp.started')
        inst_exp.setAutoDraw(True)
    if inst_exp.status == STARTED:
        # is it time to stop? (based on global clock, using actual start)
        if tThisFlipGlobal > inst_exp.tStartRefresh + d_inst_start-frameTolerance:
            # keep track of stop time/frame for later
            inst_exp.tStop = t  # not accounting for scr refresh
            inst_exp.frameNStop = frameN  # exact frame index
            # add timestamp to datafile
            thisExp.timestampOnFlip(win, 'inst_exp.stopped')
            inst_exp.setAutoDraw(False)
    
    # *inst_exp_continue* updates
    if inst_exp_continue.status == NOT_STARTED and tThisFlip >= d_inst_start-frameTolerance:
        # keep track of start time/frame for later
        inst_exp_continue.frameNStart = frameN  # exact frame index
        inst_exp_continue.tStart = t  # local t and not account for scr refresh
        inst_exp_continue.tStartRefresh = tThisFlipGlobal  # on global time
        win.timeOnFlip(inst_exp_continue, 'tStartRefresh')  # time at next scr refresh
        # add timestamp to datafile
        thisExp.timestampOnFlip(win, 'inst_exp_continue.started')
        inst_exp_continue.setAutoDraw(True)
    
    # *kb_inst_start* updates
    waitOnFlip = False
    if kb_inst_start.status == NOT_STARTED and tThisFlip >= d_inst_start-frameTolerance:
        # keep track of start time/frame for later
        kb_inst_start.frameNStart = frameN  # exact frame index
        kb_inst_start.tStart = t  # local t and not account for scr refresh
        kb_inst_start.tStartRefresh = tThisFlipGlobal  # on global time
        win.timeOnFlip(kb_inst_start, 'tStartRefresh')  # time at next scr refresh
        # add timestamp to datafile
        thisExp.timestampOnFlip(win, 'kb_inst_start.started')
        kb_inst_start.status = STARTED
        # keyboard checking is just starting
        waitOnFlip = True
        win.callOnFlip(kb_inst_start.clock.reset)  # t=0 on next screen flip
        win.callOnFlip(kb_inst_start.clearEvents, eventType='keyboard')  # clear events on next screen flip
    if kb_inst_start.status == STARTED and not waitOnFlip:
        theseKeys = kb_inst_start.getKeys(keyList=['space'], waitRelease=False)
        _kb_inst_start_allKeys.extend(theseKeys)
        if len(_kb_inst_start_allKeys):
            kb_inst_start.keys = _kb_inst_start_allKeys[-1].name  # just the last key pressed
            kb_inst_start.rt = _kb_inst_start_allKeys[-1].rt
            # a response ends the routine
            continueRoutine = False
    
    # check for quit (typically the Esc key)
    if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
        core.quit()
    
    # check if all components have finished
    if not continueRoutine:  # a component has requested a forced-end of Routine
        routineForceEnded = True
        break
    continueRoutine = False  # will revert to True if at least one component still running
    for thisComponent in instructions_startComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# --- Ending Routine "instructions_start" ---
for thisComponent in instructions_startComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
# the Routine "instructions_start" was not non-slip safe, so reset the non-slip timer
routineTimer.reset()

# --- Prepare to start Routine "instructions_training" ---
continueRoutine = True
routineForceEnded = False
# update component parameters for each repeat
key_inst_train.keys = []
key_inst_train.rt = []
_key_inst_train_allKeys = []
# keep track of which components have finished
instructions_trainingComponents = [inst_train, inst_train_continue, key_inst_train]
for thisComponent in instructions_trainingComponents:
    thisComponent.tStart = None
    thisComponent.tStop = None
    thisComponent.tStartRefresh = None
    thisComponent.tStopRefresh = None
    if hasattr(thisComponent, 'status'):
        thisComponent.status = NOT_STARTED
# reset timers
t = 0
_timeToFirstFrame = win.getFutureFlipTime(clock="now")
frameN = -1

# --- Run Routine "instructions_training" ---
while continueRoutine:
    # get current time
    t = routineTimer.getTime()
    tThisFlip = win.getFutureFlipTime(clock=routineTimer)
    tThisFlipGlobal = win.getFutureFlipTime(clock=None)
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # *inst_train* updates
    if inst_train.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
        # keep track of start time/frame for later
        inst_train.frameNStart = frameN  # exact frame index
        inst_train.tStart = t  # local t and not account for scr refresh
        inst_train.tStartRefresh = tThisFlipGlobal  # on global time
        win.timeOnFlip(inst_train, 'tStartRefresh')  # time at next scr refresh
        # add timestamp to datafile
        thisExp.timestampOnFlip(win, 'inst_train.started')
        inst_train.setAutoDraw(True)
    if inst_train.status == STARTED:
        # is it time to stop? (based on global clock, using actual start)
        if tThisFlipGlobal > inst_train.tStartRefresh + d_inst_train-frameTolerance:
            # keep track of stop time/frame for later
            inst_train.tStop = t  # not accounting for scr refresh
            inst_train.frameNStop = frameN  # exact frame index
            # add timestamp to datafile
            thisExp.timestampOnFlip(win, 'inst_train.stopped')
            inst_train.setAutoDraw(False)
    
    # *inst_train_continue* updates
    if inst_train_continue.status == NOT_STARTED and tThisFlip >= d_inst_train-frameTolerance:
        # keep track of start time/frame for later
        inst_train_continue.frameNStart = frameN  # exact frame index
        inst_train_continue.tStart = t  # local t and not account for scr refresh
        inst_train_continue.tStartRefresh = tThisFlipGlobal  # on global time
        win.timeOnFlip(inst_train_continue, 'tStartRefresh')  # time at next scr refresh
        # add timestamp to datafile
        thisExp.timestampOnFlip(win, 'inst_train_continue.started')
        inst_train_continue.setAutoDraw(True)
    
    # *key_inst_train* updates
    waitOnFlip = False
    if key_inst_train.status == NOT_STARTED and tThisFlip >= d_inst_train-frameTolerance:
        # keep track of start time/frame for later
        key_inst_train.frameNStart = frameN  # exact frame index
        key_inst_train.tStart = t  # local t and not account for scr refresh
        key_inst_train.tStartRefresh = tThisFlipGlobal  # on global time
        win.timeOnFlip(key_inst_train, 'tStartRefresh')  # time at next scr refresh
        # add timestamp to datafile
        thisExp.timestampOnFlip(win, 'key_inst_train.started')
        key_inst_train.status = STARTED
        # keyboard checking is just starting
        waitOnFlip = True
        win.callOnFlip(key_inst_train.clock.reset)  # t=0 on next screen flip
        win.callOnFlip(key_inst_train.clearEvents, eventType='keyboard')  # clear events on next screen flip
    if key_inst_train.status == STARTED and not waitOnFlip:
        theseKeys = key_inst_train.getKeys(keyList=['space'], waitRelease=False)
        _key_inst_train_allKeys.extend(theseKeys)
        if len(_key_inst_train_allKeys):
            key_inst_train.keys = _key_inst_train_allKeys[-1].name  # just the last key pressed
            key_inst_train.rt = _key_inst_train_allKeys[-1].rt
            # a response ends the routine
            continueRoutine = False
    
    # check for quit (typically the Esc key)
    if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
        core.quit()
    
    # check if all components have finished
    if not continueRoutine:  # a component has requested a forced-end of Routine
        routineForceEnded = True
        break
    continueRoutine = False  # will revert to True if at least one component still running
    for thisComponent in instructions_trainingComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# --- Ending Routine "instructions_training" ---
for thisComponent in instructions_trainingComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
# the Routine "instructions_training" was not non-slip safe, so reset the non-slip timer
routineTimer.reset()

# set up handler to look after randomisation of conditions etc
trials_training = data.TrialHandler(nReps=2.0, method='fullRandom', 
    extraInfo=expInfo, originPath=-1,
    trialList=data.importConditions('cond_training.xlsx'),
    seed=None, name='trials_training')
thisExp.addLoop(trials_training)  # add the loop to the experiment
thisTrials_training = trials_training.trialList[0]  # so we can initialise stimuli with some values
# abbreviate parameter names if possible (e.g. rgb = thisTrials_training.rgb)
if thisTrials_training != None:
    for paramName in thisTrials_training:
        exec('{} = thisTrials_training[paramName]'.format(paramName))

for thisTrials_training in trials_training:
    currentLoop = trials_training
    # abbreviate parameter names if possible (e.g. rgb = thisTrials_training.rgb)
    if thisTrials_training != None:
        for paramName in thisTrials_training:
            exec('{} = thisTrials_training[paramName]'.format(paramName))
    
    # --- Prepare to start Routine "ITI_Training" ---
    continueRoutine = True
    routineForceEnded = False
    # update component parameters for each repeat
    # keep track of which components have finished
    ITI_TrainingComponents = [text_iti_train, noise]
    for thisComponent in ITI_TrainingComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    # reset timers
    t = 0
    _timeToFirstFrame = win.getFutureFlipTime(clock="now")
    frameN = -1
    
    # --- Run Routine "ITI_Training" ---
    while continueRoutine:
        # get current time
        t = routineTimer.getTime()
        tThisFlip = win.getFutureFlipTime(clock=routineTimer)
        tThisFlipGlobal = win.getFutureFlipTime(clock=None)
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *text_iti_train* updates
        if text_iti_train.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            text_iti_train.frameNStart = frameN  # exact frame index
            text_iti_train.tStart = t  # local t and not account for scr refresh
            text_iti_train.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(text_iti_train, 'tStartRefresh')  # time at next scr refresh
            # add timestamp to datafile
            thisExp.timestampOnFlip(win, 'text_iti_train.started')
            text_iti_train.setAutoDraw(True)
        if text_iti_train.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > text_iti_train.tStartRefresh + d_iti-frameTolerance:
                # keep track of stop time/frame for later
                text_iti_train.tStop = t  # not accounting for scr refresh
                text_iti_train.frameNStop = frameN  # exact frame index
                # add timestamp to datafile
                thisExp.timestampOnFlip(win, 'text_iti_train.stopped')
                text_iti_train.setAutoDraw(False)
        
        # *noise* updates
        if noise.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            noise.frameNStart = frameN  # exact frame index
            noise.tStart = t  # local t and not account for scr refresh
            noise.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(noise, 'tStartRefresh')  # time at next scr refresh
            # add timestamp to datafile
            thisExp.timestampOnFlip(win, 'noise.started')
            noise.setAutoDraw(True)
        if noise.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > noise.tStartRefresh + d_iti-frameTolerance:
                # keep track of stop time/frame for later
                noise.tStop = t  # not accounting for scr refresh
                noise.frameNStop = frameN  # exact frame index
                # add timestamp to datafile
                thisExp.timestampOnFlip(win, 'noise.stopped')
                noise.setAutoDraw(False)
        if noise.status == STARTED:
            if noise._needBuild:
                noise.buildNoise()
            else:
                if (frameN-noise.frameNStart) %         1==0:
                    noise.updateNoise()
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            routineForceEnded = True
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in ITI_TrainingComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # --- Ending Routine "ITI_Training" ---
    for thisComponent in ITI_TrainingComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    # the Routine "ITI_Training" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    
    # --- Prepare to start Routine "training" ---
    continueRoutine = True
    routineForceEnded = False
    # update component parameters for each repeat
    img_training.setImage(img_rel_path)
    judgement.reset()
    # Run 'Begin Routine' code from code_training
    modify = False
    judgement.text = ''
    event.clearEvents('keyboard')
    # keep track of which components have finished
    trainingComponents = [img_training, judgement]
    for thisComponent in trainingComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    # reset timers
    t = 0
    _timeToFirstFrame = win.getFutureFlipTime(clock="now")
    frameN = -1
    
    # --- Run Routine "training" ---
    while continueRoutine:
        # get current time
        t = routineTimer.getTime()
        tThisFlip = win.getFutureFlipTime(clock=routineTimer)
        tThisFlipGlobal = win.getFutureFlipTime(clock=None)
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *img_training* updates
        if img_training.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            img_training.frameNStart = frameN  # exact frame index
            img_training.tStart = t  # local t and not account for scr refresh
            img_training.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(img_training, 'tStartRefresh')  # time at next scr refresh
            # add timestamp to datafile
            thisExp.timestampOnFlip(win, 'img_training.started')
            img_training.setAutoDraw(True)
        
        # *judgement* updates
        if judgement.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            judgement.frameNStart = frameN  # exact frame index
            judgement.tStart = t  # local t and not account for scr refresh
            judgement.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(judgement, 'tStartRefresh')  # time at next scr refresh
            # add timestamp to datafile
            thisExp.timestampOnFlip(win, 'judgement.started')
            judgement.setAutoDraw(True)
        # Run 'Each Frame' code from code_training
        keys = event.getKeys(['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', 'return', 'backspace'])
        
        if len(keys):
            if 'backspace' in keys:
                judgement.text = judgement.text[:-1]
            elif 'return' in keys and judgement.text != '':
                continueRoutine = False
            elif 'return' in keys and judgement.text == '':
                pass
            else:
                judgement.text = judgement.text + keys[0]
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            routineForceEnded = True
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in trainingComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # --- Ending Routine "training" ---
    for thisComponent in trainingComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    # Run 'End Routine' code from code_training
    thisExp.addData("answer", judgement.text)
    thisExp.addData("RT", t)
    thisExp.addData("looker_gender", looker[0])
    # the Routine "training" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    thisExp.nextEntry()
    
# completed 2.0 repeats of 'trials_training'


# --- Prepare to start Routine "instructions_exp" ---
continueRoutine = True
routineForceEnded = False
# update component parameters for each repeat
kb_inst_exp.keys = []
kb_inst_exp.rt = []
_kb_inst_exp_allKeys = []
# keep track of which components have finished
instructions_expComponents = [instr_ex, instr_ex_cont, kb_inst_exp]
for thisComponent in instructions_expComponents:
    thisComponent.tStart = None
    thisComponent.tStop = None
    thisComponent.tStartRefresh = None
    thisComponent.tStopRefresh = None
    if hasattr(thisComponent, 'status'):
        thisComponent.status = NOT_STARTED
# reset timers
t = 0
_timeToFirstFrame = win.getFutureFlipTime(clock="now")
frameN = -1

# --- Run Routine "instructions_exp" ---
while continueRoutine:
    # get current time
    t = routineTimer.getTime()
    tThisFlip = win.getFutureFlipTime(clock=routineTimer)
    tThisFlipGlobal = win.getFutureFlipTime(clock=None)
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # *instr_ex* updates
    if instr_ex.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
        # keep track of start time/frame for later
        instr_ex.frameNStart = frameN  # exact frame index
        instr_ex.tStart = t  # local t and not account for scr refresh
        instr_ex.tStartRefresh = tThisFlipGlobal  # on global time
        win.timeOnFlip(instr_ex, 'tStartRefresh')  # time at next scr refresh
        # add timestamp to datafile
        thisExp.timestampOnFlip(win, 'instr_ex.started')
        instr_ex.setAutoDraw(True)
    if instr_ex.status == STARTED:
        # is it time to stop? (based on global clock, using actual start)
        if tThisFlipGlobal > instr_ex.tStartRefresh + d_inst_exp-frameTolerance:
            # keep track of stop time/frame for later
            instr_ex.tStop = t  # not accounting for scr refresh
            instr_ex.frameNStop = frameN  # exact frame index
            # add timestamp to datafile
            thisExp.timestampOnFlip(win, 'instr_ex.stopped')
            instr_ex.setAutoDraw(False)
    
    # *instr_ex_cont* updates
    if instr_ex_cont.status == NOT_STARTED and tThisFlip >= d_inst_exp-frameTolerance:
        # keep track of start time/frame for later
        instr_ex_cont.frameNStart = frameN  # exact frame index
        instr_ex_cont.tStart = t  # local t and not account for scr refresh
        instr_ex_cont.tStartRefresh = tThisFlipGlobal  # on global time
        win.timeOnFlip(instr_ex_cont, 'tStartRefresh')  # time at next scr refresh
        # add timestamp to datafile
        thisExp.timestampOnFlip(win, 'instr_ex_cont.started')
        instr_ex_cont.setAutoDraw(True)
    
    # *kb_inst_exp* updates
    waitOnFlip = False
    if kb_inst_exp.status == NOT_STARTED and tThisFlip >= d_inst_exp-frameTolerance:
        # keep track of start time/frame for later
        kb_inst_exp.frameNStart = frameN  # exact frame index
        kb_inst_exp.tStart = t  # local t and not account for scr refresh
        kb_inst_exp.tStartRefresh = tThisFlipGlobal  # on global time
        win.timeOnFlip(kb_inst_exp, 'tStartRefresh')  # time at next scr refresh
        # add timestamp to datafile
        thisExp.timestampOnFlip(win, 'kb_inst_exp.started')
        kb_inst_exp.status = STARTED
        # keyboard checking is just starting
        waitOnFlip = True
        win.callOnFlip(kb_inst_exp.clock.reset)  # t=0 on next screen flip
        win.callOnFlip(kb_inst_exp.clearEvents, eventType='keyboard')  # clear events on next screen flip
    if kb_inst_exp.status == STARTED and not waitOnFlip:
        theseKeys = kb_inst_exp.getKeys(keyList=['space'], waitRelease=False)
        _kb_inst_exp_allKeys.extend(theseKeys)
        if len(_kb_inst_exp_allKeys):
            kb_inst_exp.keys = _kb_inst_exp_allKeys[-1].name  # just the last key pressed
            kb_inst_exp.rt = _kb_inst_exp_allKeys[-1].rt
            # a response ends the routine
            continueRoutine = False
    
    # check for quit (typically the Esc key)
    if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
        core.quit()
    
    # check if all components have finished
    if not continueRoutine:  # a component has requested a forced-end of Routine
        routineForceEnded = True
        break
    continueRoutine = False  # will revert to True if at least one component still running
    for thisComponent in instructions_expComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# --- Ending Routine "instructions_exp" ---
for thisComponent in instructions_expComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
# the Routine "instructions_exp" was not non-slip safe, so reset the non-slip timer
routineTimer.reset()

# set up handler to look after randomisation of conditions etc
trials_exp = data.TrialHandler(nReps=6.0, method='fullRandom', 
    extraInfo=expInfo, originPath=-1,
    trialList=data.importConditions('cond_exp.xlsx'),
    seed=None, name='trials_exp')
thisExp.addLoop(trials_exp)  # add the loop to the experiment
thisTrials_exp = trials_exp.trialList[0]  # so we can initialise stimuli with some values
# abbreviate parameter names if possible (e.g. rgb = thisTrials_exp.rgb)
if thisTrials_exp != None:
    for paramName in thisTrials_exp:
        exec('{} = thisTrials_exp[paramName]'.format(paramName))

for thisTrials_exp in trials_exp:
    currentLoop = trials_exp
    # abbreviate parameter names if possible (e.g. rgb = thisTrials_exp.rgb)
    if thisTrials_exp != None:
        for paramName in thisTrials_exp:
            exec('{} = thisTrials_exp[paramName]'.format(paramName))
    
    # --- Prepare to start Routine "ITI_Exp" ---
    continueRoutine = True
    routineForceEnded = False
    # update component parameters for each repeat
    # keep track of which components have finished
    ITI_ExpComponents = [text_iti_exp]
    for thisComponent in ITI_ExpComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    # reset timers
    t = 0
    _timeToFirstFrame = win.getFutureFlipTime(clock="now")
    frameN = -1
    
    # --- Run Routine "ITI_Exp" ---
    while continueRoutine:
        # get current time
        t = routineTimer.getTime()
        tThisFlip = win.getFutureFlipTime(clock=routineTimer)
        tThisFlipGlobal = win.getFutureFlipTime(clock=None)
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *text_iti_exp* updates
        if text_iti_exp.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            text_iti_exp.frameNStart = frameN  # exact frame index
            text_iti_exp.tStart = t  # local t and not account for scr refresh
            text_iti_exp.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(text_iti_exp, 'tStartRefresh')  # time at next scr refresh
            # add timestamp to datafile
            thisExp.timestampOnFlip(win, 'text_iti_exp.started')
            text_iti_exp.setAutoDraw(True)
        if text_iti_exp.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > text_iti_exp.tStartRefresh + d_iti-frameTolerance:
                # keep track of stop time/frame for later
                text_iti_exp.tStop = t  # not accounting for scr refresh
                text_iti_exp.frameNStop = frameN  # exact frame index
                # add timestamp to datafile
                thisExp.timestampOnFlip(win, 'text_iti_exp.stopped')
                text_iti_exp.setAutoDraw(False)
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            routineForceEnded = True
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in ITI_ExpComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # --- Ending Routine "ITI_Exp" ---
    for thisComponent in ITI_ExpComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    # the Routine "ITI_Exp" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    
    # --- Prepare to start Routine "experiment" ---
    continueRoutine = True
    routineForceEnded = False
    # update component parameters for each repeat
    img_exp.setImage(img_rel_path)
    judgement_exp.reset()
    # Run 'Begin Routine' code from code_exp
    modify = False
    judgement_exp.text = ''
    event.clearEvents('keyboard')
    # keep track of which components have finished
    experimentComponents = [img_exp, judgement_exp]
    for thisComponent in experimentComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    # reset timers
    t = 0
    _timeToFirstFrame = win.getFutureFlipTime(clock="now")
    frameN = -1
    
    # --- Run Routine "experiment" ---
    while continueRoutine:
        # get current time
        t = routineTimer.getTime()
        tThisFlip = win.getFutureFlipTime(clock=routineTimer)
        tThisFlipGlobal = win.getFutureFlipTime(clock=None)
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *img_exp* updates
        if img_exp.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            img_exp.frameNStart = frameN  # exact frame index
            img_exp.tStart = t  # local t and not account for scr refresh
            img_exp.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(img_exp, 'tStartRefresh')  # time at next scr refresh
            # add timestamp to datafile
            thisExp.timestampOnFlip(win, 'img_exp.started')
            img_exp.setAutoDraw(True)
        
        # *judgement_exp* updates
        if judgement_exp.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            judgement_exp.frameNStart = frameN  # exact frame index
            judgement_exp.tStart = t  # local t and not account for scr refresh
            judgement_exp.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(judgement_exp, 'tStartRefresh')  # time at next scr refresh
            # add timestamp to datafile
            thisExp.timestampOnFlip(win, 'judgement_exp.started')
            judgement_exp.setAutoDraw(True)
        # Run 'Each Frame' code from code_exp
        keys = event.getKeys(['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', 'return', 'backspace'])
        
        if len(keys):
            if 'backspace' in keys:
                judgement_exp.text = judgement_exp.text[:-1]
            elif 'return' in keys and judgement_exp.text != '':
                continueRoutine = False
            elif 'return' in keys and judgement_exp.text == '':
                pass
            else:
                judgement_exp.text = judgement_exp.text + keys[0]
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            routineForceEnded = True
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in experimentComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # --- Ending Routine "experiment" ---
    for thisComponent in experimentComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    # Run 'End Routine' code from code_exp
    thisExp.addData("answer", judgement_exp.text)
    thisExp.addData("RT", t)
    thisExp.addData("looker_gender", looker[0])
    # the Routine "experiment" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    thisExp.nextEntry()
    
# completed 6.0 repeats of 'trials_exp'


# --- Prepare to start Routine "end_screen" ---
continueRoutine = True
routineForceEnded = False
# update component parameters for each repeat
# keep track of which components have finished
end_screenComponents = [text]
for thisComponent in end_screenComponents:
    thisComponent.tStart = None
    thisComponent.tStop = None
    thisComponent.tStartRefresh = None
    thisComponent.tStopRefresh = None
    if hasattr(thisComponent, 'status'):
        thisComponent.status = NOT_STARTED
# reset timers
t = 0
_timeToFirstFrame = win.getFutureFlipTime(clock="now")
frameN = -1

# --- Run Routine "end_screen" ---
while continueRoutine and routineTimer.getTime() < 10.0:
    # get current time
    t = routineTimer.getTime()
    tThisFlip = win.getFutureFlipTime(clock=routineTimer)
    tThisFlipGlobal = win.getFutureFlipTime(clock=None)
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # *text* updates
    if text.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
        # keep track of start time/frame for later
        text.frameNStart = frameN  # exact frame index
        text.tStart = t  # local t and not account for scr refresh
        text.tStartRefresh = tThisFlipGlobal  # on global time
        win.timeOnFlip(text, 'tStartRefresh')  # time at next scr refresh
        # add timestamp to datafile
        thisExp.timestampOnFlip(win, 'text.started')
        text.setAutoDraw(True)
    if text.status == STARTED:
        # is it time to stop? (based on global clock, using actual start)
        if tThisFlipGlobal > text.tStartRefresh + 10-frameTolerance:
            # keep track of stop time/frame for later
            text.tStop = t  # not accounting for scr refresh
            text.frameNStop = frameN  # exact frame index
            # add timestamp to datafile
            thisExp.timestampOnFlip(win, 'text.stopped')
            text.setAutoDraw(False)
    
    # check for quit (typically the Esc key)
    if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
        core.quit()
    
    # check if all components have finished
    if not continueRoutine:  # a component has requested a forced-end of Routine
        routineForceEnded = True
        break
    continueRoutine = False  # will revert to True if at least one component still running
    for thisComponent in end_screenComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# --- Ending Routine "end_screen" ---
for thisComponent in end_screenComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
# using non-slip timing so subtract the expected duration of this Routine (unless ended on request)
if routineForceEnded:
    routineTimer.reset()
else:
    routineTimer.addTime(-10.000000)

# --- End experiment ---
# Flip one final time so any remaining win.callOnFlip() 
# and win.timeOnFlip() tasks get executed before quitting
win.flip()

# these shouldn't be strictly necessary (should auto-save)
thisExp.saveAsWideText(filename+'.csv', delim='auto')
thisExp.saveAsPickle(filename)
logging.flush()
# make sure everything is closed down
if eyetracker:
    eyetracker.setConnectionState(False)
thisExp.abort()  # or data files will save again on exit
win.close()
core.quit()

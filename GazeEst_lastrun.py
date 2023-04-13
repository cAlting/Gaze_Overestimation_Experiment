#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
This experiment was created using PsychoPy3 Experiment Builder (v2022.2.4),
    on April 13, 2023, at 11:10
If you publish work using this script the most relevant publication is:

    Peirce J, Gray JR, Simpson S, MacAskill M, Höchenberger R, Sogo H, Kastman E, Lindeløv JK. (2019) 
        PsychoPy2: Experiments in behavior made easy Behav Res 51: 195. 
        https://doi.org/10.3758/s13428-018-01193-y

"""

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

import psychopy.iohub as io
from psychopy.hardware import keyboard



# Ensure that relative paths start from the same directory as this script
_thisDir = os.path.dirname(os.path.abspath(__file__))
os.chdir(_thisDir)
# Store info about the experiment session
psychopyVersion = '2022.2.4'
expName = 'GazeEst'  # from the Builder filename that created this script
expInfo = {
    'participant': f"{randint(0, 999999):06.0f}",
    'gender': ["m", "w", "d"],
    'age': f"{randint(18, 35):02.0f}",
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
    originPath='C:\\Users\\calti\\Documents\\Masterarbeit\\PsychoPy\\GazeEst_lastrun.py',
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

# Setup iohub keyboard
ioConfig['Keyboard'] = dict(use_keymap='psychopy')

ioSession = '1'
if 'session' in expInfo:
    ioSession = str(expInfo['session'])
ioServer = io.launchHubServer(window=win, **ioConfig)
eyetracker = None

# create a default keyboard (e.g. to check for escape)
defaultKeyboard = keyboard.Keyboard(backend='iohub')

# --- Initialize components for Routine "instructions_experiment" ---
inst_exp = visual.TextStim(win=win, name='inst_exp',
    text='Herzlich Willkommen.\n\nIn dieser Studie untersuchen wir, wie wir die Blicke anderer Personen wahrnehmen.\n\nDazu werden Ihnen im Folgenden die Fotos verschiedener Personen gezeigt. Ihre Aufgabe besteht darin, die Blickrichtung der gerade auf dem Bildschirm präsentierten Person einzuschätzen.\n\nGenauer geht es darum, einzuschätzen, welchen Punkt der vor Ihnen platzierten Leiste die Person in dem Foto anschaut. Wenn Sie sich entschieden haben, geben Sie Ihr Urteil bitte in die dafür vorgesehene Textbox auf dem Bildschirm ein.\n\n\n',
    font='Open Sans',
    pos=(0, 0), height=0.05, wrapWidth=1.75, ori=0.0, 
    color='white', colorSpace='rgb', opacity=None, 
    languageStyle='LTR',
    depth=0.0);
inst_exp_continue = visual.TextStim(win=win, name='inst_exp_continue',
    text='Herzlich Willkommen.\n\nIn dieser Studie untersuchen wir, wie wir die Blicke anderer Personen wahrnehmen.\n\nDazu werden Ihnen im Folgenden die Fotos verschiedener Personen gezeigt. Ihre Aufgabe besteht darin, die Blickrichtung der gerade auf dem Bildschirm präsentierten Person einzuschätzen.\n\nGenauer geht es darum, einzuschätzen, welchen Punkt der vor Ihnen platzierten Leiste die Person in dem Foto anschaut. Wenn Sie sich entschieden haben, geben Sie Ihr Urteil bitte in die dafür vorgesehene Textbox auf dem Bildschirm ein.\n\n\nWeiter durch Drücken der LEERTASTE',
    font='Open Sans',
    pos=(0, 0), height=0.05, wrapWidth=1.75, ori=0.0, 
    color='white', colorSpace='rgb', opacity=None, 
    languageStyle='LTR',
    depth=-1.0);
kb_inst = keyboard.Keyboard()

# --- Initialize components for Routine "instructions_training" ---
inst_train = visual.TextStim(win=win, name='inst_train',
    text='Trainingsblock\n\nIn den folgenden 9 Durchgängen haben Sie die Möglichkeit, sich mit dem Ablauf des Experimentes vertraut zu machen. \n\nDie Aufgabe:\nBitte schätzen Sie unter Zuhilfenahme der vor Ihnen platzierten Leiste und Skala den Punkt auf der Leiste/Skala ein, der von der auf dem Bildschirm präsentierten Person angeschaut wird. \nGeben Sie Ihr Urteil bitte in die dafür vorgesehene Textbox ein.\n\nIm Anschluss an das Training haben Sie die Möglichkeit, mögliche Fragen mit dem:der Versuchsleiter:in zu klären.\n\n',
    font='Open Sans',
    pos=(0, 0), height=0.05, wrapWidth=1.75, ori=0.0, 
    color='white', colorSpace='rgb', opacity=None, 
    languageStyle='LTR',
    depth=0.0);
inst_train_continue = visual.TextStim(win=win, name='inst_train_continue',
    text='Trainingsblock\n\nIn den folgenden 9 Durchgängen haben Sie die Möglichkeit, sich mit dem Ablauf des Experimentes vertraut zu machen. \n\nDie Aufgabe:\nBitte schätzen Sie unter Zuhilfenahme der vor Ihnen platzierten Leiste und Skala den Punkt auf der Leiste/Skala ein, der von der auf dem Bildschirm präsentierten Person angeschaut wird. \nGeben Sie Ihr Urteil bitte in die dafür vorgesehene Textbox ein.\n\nIm Anschluss an das Training haben Sie die Möglichkeit, mögliche Fragen mit dem:der Versuchsleiter:in zu klären.\n\nWeiter durch Drücken der LEERTASTE',
    font='Open Sans',
    pos=(0, 0), height=0.05, wrapWidth=1.75, ori=0.0, 
    color='white', colorSpace='rgb', opacity=None, 
    languageStyle='LTR',
    depth=-1.0);
key_resp = keyboard.Keyboard()

# --- Initialize components for Routine "training" ---
img_training = visual.ImageStim(
    win=win,
    name='img_training', units='norm', 
    image='sin', mask=None, anchor='center',
    ori=0.0, pos=(0, 0), size=(2, 1.6),
    color=[1,1,1], colorSpace='rgb', opacity=None,
    flipHoriz=False, flipVert=False,
    texRes=128.0, interpolate=True, depth=0.0)
judgement1 = visual.TextStim(win=win, name='judgement1',
    text=None,
    font='Open Sans',
    pos=(0.6, -0.6), height=0.05, wrapWidth=None, ori=0.0, 
    color=[-0.4667, -0.4667, -0.4667], colorSpace='rgb', opacity=None, 
    languageStyle='LTR',
    depth=-1.0);
judgement = visual.TextBox2(
     win, text=None, font='Open Sans',
     pos=(0, -0.9),units='norm',     letterHeight=0.05,
     size=(0.15, 0.1), borderWidth=1.0,
     color='white', colorSpace='rgb',
     opacity=None,
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

# --- Initialize components for Routine "trial" ---

# Create some handy timers
globalClock = core.Clock()  # to track the time since experiment started
routineTimer = core.Clock()  # to track time remaining of each (possibly non-slip) routine 

# --- Prepare to start Routine "instructions_experiment" ---
continueRoutine = True
routineForceEnded = False
# update component parameters for each repeat
kb_inst.keys = []
kb_inst.rt = []
_kb_inst_allKeys = []
# keep track of which components have finished
instructions_experimentComponents = [inst_exp, inst_exp_continue, kb_inst]
for thisComponent in instructions_experimentComponents:
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

# --- Run Routine "instructions_experiment" ---
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
        if tThisFlipGlobal > inst_exp.tStartRefresh + 10-frameTolerance:
            # keep track of stop time/frame for later
            inst_exp.tStop = t  # not accounting for scr refresh
            inst_exp.frameNStop = frameN  # exact frame index
            # add timestamp to datafile
            thisExp.timestampOnFlip(win, 'inst_exp.stopped')
            inst_exp.setAutoDraw(False)
    
    # *inst_exp_continue* updates
    if inst_exp_continue.status == NOT_STARTED and tThisFlip >= 10.0-frameTolerance:
        # keep track of start time/frame for later
        inst_exp_continue.frameNStart = frameN  # exact frame index
        inst_exp_continue.tStart = t  # local t and not account for scr refresh
        inst_exp_continue.tStartRefresh = tThisFlipGlobal  # on global time
        win.timeOnFlip(inst_exp_continue, 'tStartRefresh')  # time at next scr refresh
        # add timestamp to datafile
        thisExp.timestampOnFlip(win, 'inst_exp_continue.started')
        inst_exp_continue.setAutoDraw(True)
    
    # *kb_inst* updates
    waitOnFlip = False
    if kb_inst.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
        # keep track of start time/frame for later
        kb_inst.frameNStart = frameN  # exact frame index
        kb_inst.tStart = t  # local t and not account for scr refresh
        kb_inst.tStartRefresh = tThisFlipGlobal  # on global time
        win.timeOnFlip(kb_inst, 'tStartRefresh')  # time at next scr refresh
        # add timestamp to datafile
        thisExp.timestampOnFlip(win, 'kb_inst.started')
        kb_inst.status = STARTED
        # keyboard checking is just starting
        waitOnFlip = True
        win.callOnFlip(kb_inst.clock.reset)  # t=0 on next screen flip
        win.callOnFlip(kb_inst.clearEvents, eventType='keyboard')  # clear events on next screen flip
    if kb_inst.status == STARTED and not waitOnFlip:
        theseKeys = kb_inst.getKeys(keyList=['space'], waitRelease=False)
        _kb_inst_allKeys.extend(theseKeys)
        if len(_kb_inst_allKeys):
            kb_inst.keys = _kb_inst_allKeys[-1].name  # just the last key pressed
            kb_inst.rt = _kb_inst_allKeys[-1].rt
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
    for thisComponent in instructions_experimentComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# --- Ending Routine "instructions_experiment" ---
for thisComponent in instructions_experimentComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
# check responses
if kb_inst.keys in ['', [], None]:  # No response was made
    kb_inst.keys = None
thisExp.addData('kb_inst.keys',kb_inst.keys)
if kb_inst.keys != None:  # we had a response
    thisExp.addData('kb_inst.rt', kb_inst.rt)
thisExp.nextEntry()
# the Routine "instructions_experiment" was not non-slip safe, so reset the non-slip timer
routineTimer.reset()

# --- Prepare to start Routine "instructions_training" ---
continueRoutine = True
routineForceEnded = False
# update component parameters for each repeat
key_resp.keys = []
key_resp.rt = []
_key_resp_allKeys = []
# keep track of which components have finished
instructions_trainingComponents = [inst_train, inst_train_continue, key_resp]
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
        if tThisFlipGlobal > inst_train.tStartRefresh + 10-frameTolerance:
            # keep track of stop time/frame for later
            inst_train.tStop = t  # not accounting for scr refresh
            inst_train.frameNStop = frameN  # exact frame index
            # add timestamp to datafile
            thisExp.timestampOnFlip(win, 'inst_train.stopped')
            inst_train.setAutoDraw(False)
    
    # *inst_train_continue* updates
    if inst_train_continue.status == NOT_STARTED and tThisFlip >= 10.0-frameTolerance:
        # keep track of start time/frame for later
        inst_train_continue.frameNStart = frameN  # exact frame index
        inst_train_continue.tStart = t  # local t and not account for scr refresh
        inst_train_continue.tStartRefresh = tThisFlipGlobal  # on global time
        win.timeOnFlip(inst_train_continue, 'tStartRefresh')  # time at next scr refresh
        # add timestamp to datafile
        thisExp.timestampOnFlip(win, 'inst_train_continue.started')
        inst_train_continue.setAutoDraw(True)
    
    # *key_resp* updates
    waitOnFlip = False
    if key_resp.status == NOT_STARTED and tThisFlip >= 0-frameTolerance:
        # keep track of start time/frame for later
        key_resp.frameNStart = frameN  # exact frame index
        key_resp.tStart = t  # local t and not account for scr refresh
        key_resp.tStartRefresh = tThisFlipGlobal  # on global time
        win.timeOnFlip(key_resp, 'tStartRefresh')  # time at next scr refresh
        # add timestamp to datafile
        thisExp.timestampOnFlip(win, 'key_resp.started')
        key_resp.status = STARTED
        # keyboard checking is just starting
        waitOnFlip = True
        win.callOnFlip(key_resp.clock.reset)  # t=0 on next screen flip
        win.callOnFlip(key_resp.clearEvents, eventType='keyboard')  # clear events on next screen flip
    if key_resp.status == STARTED and not waitOnFlip:
        theseKeys = key_resp.getKeys(keyList=['space'], waitRelease=False)
        _key_resp_allKeys.extend(theseKeys)
        if len(_key_resp_allKeys):
            key_resp.keys = _key_resp_allKeys[-1].name  # just the last key pressed
            key_resp.rt = _key_resp_allKeys[-1].rt
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
# check responses
if key_resp.keys in ['', [], None]:  # No response was made
    key_resp.keys = None
thisExp.addData('key_resp.keys',key_resp.keys)
if key_resp.keys != None:  # we had a response
    thisExp.addData('key_resp.rt', key_resp.rt)
thisExp.nextEntry()
# the Routine "instructions_training" was not non-slip safe, so reset the non-slip timer
routineTimer.reset()

# set up handler to look after randomisation of conditions etc
trials_training = data.TrialHandler(nReps=1.0, method='random', 
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
    
    # --- Prepare to start Routine "training" ---
    continueRoutine = True
    routineForceEnded = False
    # update component parameters for each repeat
    img_training.setImage(img_rel_path)
    # Run 'Begin Routine' code from code
    modify = False
    judgement.text = ''
    event.clearEvents('keyboard')
    judgement.reset()
    # keep track of which components have finished
    trainingComponents = [img_training, judgement1, judgement]
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
        
        # *judgement1* updates
        if judgement1.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            judgement1.frameNStart = frameN  # exact frame index
            judgement1.tStart = t  # local t and not account for scr refresh
            judgement1.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(judgement1, 'tStartRefresh')  # time at next scr refresh
            # add timestamp to datafile
            thisExp.timestampOnFlip(win, 'judgement1.started')
            judgement1.setAutoDraw(True)
        # Run 'Each Frame' code from code
        keys = event.getKeys()
        if len(keys):
            if 'backspace' in keys:
                judgement.text = judgement.text[:-1]
            elif 'return' in keys:
                continueRoutine = False
            else:
                judgement.text = judgement.text + keys[0]
        
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
    # Run 'End Routine' code from code
    thisExp.addData("answer", judgement.text)
    # the Routine "training" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    thisExp.nextEntry()
    
# completed 1.0 repeats of 'trials_training'


# --- Prepare to start Routine "trial" ---
continueRoutine = True
routineForceEnded = False
# update component parameters for each repeat
# keep track of which components have finished
trialComponents = []
for thisComponent in trialComponents:
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

# --- Run Routine "trial" ---
while continueRoutine:
    # get current time
    t = routineTimer.getTime()
    tThisFlip = win.getFutureFlipTime(clock=routineTimer)
    tThisFlipGlobal = win.getFutureFlipTime(clock=None)
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # check for quit (typically the Esc key)
    if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
        core.quit()
    
    # check if all components have finished
    if not continueRoutine:  # a component has requested a forced-end of Routine
        routineForceEnded = True
        break
    continueRoutine = False  # will revert to True if at least one component still running
    for thisComponent in trialComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# --- Ending Routine "trial" ---
for thisComponent in trialComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
# the Routine "trial" was not non-slip safe, so reset the non-slip timer
routineTimer.reset()

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

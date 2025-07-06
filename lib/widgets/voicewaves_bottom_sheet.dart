
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:pathly/constant.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:pathly/utils/textstyles.dart';
import 'package:pathly/widgets/voice_services_listview.dart';
import 'dart:ui' as ui show Gradient;

class VoiceWavesBottomsheetBody extends StatefulWidget {
  final Function(String)? onResult;

  const VoiceWavesBottomsheetBody({super.key, this.onResult});

  @override
  State<VoiceWavesBottomsheetBody> createState() => _VoiceWavesBottomsheetBodyState();
}

class _VoiceWavesBottomsheetBodyState extends State<VoiceWavesBottomsheetBody> {
  late stt.SpeechToText _speech;
  late RecorderController _recorderController;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _recorderController = RecorderController();

  
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initSpeech();
    });
  }

  Future<void> _initSpeech() async {
    final available = await _speech.initialize(
      onStatus: (status) => log("Status: $status"),
      onError: (error) => log("Error: $error"),
    );

    if (available) {
      _speech.listen(
        onResult: (result) {
          log("Result: ${result.recognizedWords}");
          if (widget.onResult != null) {
            widget.onResult!(result.recognizedWords);
          }
        },
        listenFor: Duration(seconds: 15),
        pauseFor: Duration(seconds: 4),
        partialResults: false,
        onSoundLevelChange: (level) => log("Sound level: $level"),
      );
      await _recorderController.record();
    } else {
      log("Speech not available");
    }
  }

  @override
  void dispose() {
    _recorderController.dispose();
    _speech.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.65,
          width: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.only(top: 20),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Say Where you wanna go",
                      style: Styles.stylePrimaryColorbold24,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Color(0xff999999)),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 100),
            
                AudioWaveforms(
  size: Size(MediaQuery.of(context).size.width * 0.7, 100.0),
  recorderController: _recorderController,
  enableGesture: false,
 
  waveStyle:  WaveStyle(
    waveColor: kPrimaryColor,
     gradient:  ui.Gradient.linear(
                     const Offset(70, 50),
                     Offset(MediaQuery.of(context).size.width / 2, 0),
                       [
        kPrimaryColor,
        Colors.indigo,

      ],
                   ),
    extendWaveform: true,
    showMiddleLine: false,
    waveThickness: 5.0, 
    waveCap: StrokeCap.square,
    spacing: 6.0,    
 scaleFactor: 100,
    durationLinesHeight: 30   
 
  ),
),

                const SizedBox(height: 100),
                VoiceServicesListview(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

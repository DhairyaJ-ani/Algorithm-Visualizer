import 'dart:math';
import 'dart:async';
import 'package:algorithm_visualizer/algorithms/algos.dart';
import 'package:algorithm_visualizer/algorithms/frames.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Algorithm _algo = Algorithm.mergeSort;

  // Sorting data
  List<int> _array = [];
  List<Frame> _frames = [];
  int _currentFrame = 0;

  // Rabin-Karp data
  final TextEditingController _textController = TextEditingController(text: 'ABABDABACDABABCABAB');
  final TextEditingController _patternController = TextEditingController(text: 'ABABCABAB');
  List<RKFrame> _rkFrames = [];
  int _currentRKFrame = 0;

  // Playback & controls
  Timer? _timer;
  int _speedMs = 300;
  bool _isPlaying = false;
  int _arraySize = 30;

  @override
  void initState() {
    super.initState();
    _generateArray();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _textController.dispose();
    _patternController.dispose();
    super.dispose();
  }

  void _generateArray() {
    final rnd = Random();
    _array = List.generate(_arraySize, (_) => rnd.nextInt(100) + 5);
    _frames = [Frame(_array.toList())];
    _currentFrame = 0;
    _rkFrames = [];
    _currentRKFrame = 0;
    _stop();
    setState(() {});
  }

  void _generateFramesForSorting() {
    final copy = _array.toList();
    _frames = [Frame(copy.toList())];
    if (copy.isEmpty) return;
    if (_algo == Algorithm.mergeSort) {
      mergeSort(copy, 0, copy.length - 1, _frames);
    } else if (_algo == Algorithm.quickSort) {
      quickSort(copy, 0, copy.length - 1, _frames);
    }
    _frames.add(Frame(copy.toList(), op: 'done'));
    _currentFrame = 0;
    setState(() {});
  }

  void _generateFramesForRabinKarp() {
    final text = _textController.text;
    final pat = _patternController.text;
    _rkFrames = rabinKarpSteps(text, pat);
    _currentRKFrame = 0;
    setState(() {});
  }

  void _play() {
    if (_isPlaying) return;
    _isPlaying = true;
    _timer = Timer.periodic(Duration(milliseconds: _speedMs), (_) {
      if (_algo == Algorithm.rabinKarp) {
        if (_currentRKFrame < _rkFrames.length - 1) {
          setState(() => _currentRKFrame++);
        } else {
          _stop();
        }
      } else {
        if (_currentFrame < _frames.length - 1) {
          setState(() => _currentFrame++);
        } else {
          _stop();
        }
      }
    });
    setState(() {});
  }

  void _stop() {
    _timer?.cancel();
    _isPlaying = false;
    setState(() {});
  }

  void _stepForward() {
    if (_algo == Algorithm.rabinKarp) {
      if (_currentRKFrame < _rkFrames.length - 1) setState(() => _currentRKFrame++);
    } else {
      if (_currentFrame < _frames.length - 1) setState(() => _currentFrame++);
    }
  }

  void _stepBackward() {
    if (_algo == Algorithm.rabinKarp) {
      if (_currentRKFrame > 0) setState(() => _currentRKFrame--);
    } else {
      if (_currentFrame > 0) setState(() => _currentFrame--);
    }
  }

  // Sorting algorithms that record frames
 
  // UI building
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Algorithm Visualizer')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SingleChildScrollView(scrollDirection: Axis.horizontal,child: _buildControls(),),
              
              const SizedBox(height: 12),
              Expanded(child: _buildVisualizerArea()),
              const SizedBox(height: 12),
              _buildPlaybackInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControls() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Algorithm: '),
            const SizedBox(width: 8),
            DropdownButton<Algorithm>(
              value: _algo,
              items: const [
                DropdownMenuItem(value: Algorithm.mergeSort, child: Text('Merge Sort')),
                DropdownMenuItem(value: Algorithm.quickSort, child: Text('Quick Sort')),
                DropdownMenuItem(value: Algorithm.rabinKarp, child: Text('Rabin-Karp')),
              ],
              onChanged: (v) {
                if (v == null) return;
                setState(() {
                  _algo = v;
                  _stop();
                });
              },
            ),
            const SizedBox(width: 12),
            if (_algo != Algorithm.rabinKarp) ...[
              ElevatedButton.icon(onPressed: _generateArray, icon: const Icon(Icons.shuffle), label: const Text('Randomize')),
              const SizedBox(width: 8),
              ElevatedButton.icon(onPressed: _generateFramesForSorting, icon: const Icon(Icons.playlist_add), label: const Text('Prepare')),
              const SizedBox(width: 8),
              const Text('Size:'),
              Slider(
                value: _arraySize.toDouble(),
                min: 5,
                max: 120,
                divisions: 115,
                label: '$_arraySize',
                onChanged: (v) {
                  _arraySize = v.toInt();
                  _generateArray();
                },
              ),
            ],
            if (_algo == Algorithm.rabinKarp) ...[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(controller: _textController, decoration: const InputDecoration(labelText: 'Text')),
                      TextField(controller: _patternController, decoration: const InputDecoration(labelText: 'Pattern')),
                      const SizedBox(height: 6),
                      Row(children: [
                        ElevatedButton.icon(onPressed: _generateFramesForRabinKarp, icon: const Icon(Icons.playlist_add), label: const Text('Prepare RK')),
                        const SizedBox(width: 8),
                        ElevatedButton.icon(onPressed: () {
                          _textController.text = 'ABABDABACDABABCABAB';
                          _patternController.text = 'ABABCABAB';
                        }, icon: const Icon(Icons.refresh), label: const Text('Reset')),
                      ])
                    ],
                  ),
                ),
              ),
            ]
          ],
        ),
        const SizedBox(height: 8),
        Row(children: [
          const Text('Speed:'),
          Slider(
            value: _speedMs.toDouble(),
            min: 50,
            max: 1200,
            divisions: 23,
            label: '$_speedMs ms',
            onChanged: (v) {
              _speedMs = v.toInt();
              if (_isPlaying) {
                _stop();
                _play();
              } else {
                setState(() {});
              }
            },
          ),
          const SizedBox(width: 8),
          ElevatedButton.icon(onPressed: _isPlaying ? _stop : _play, icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow), label: Text(_isPlaying ? 'Pause' : 'Play')),
          const SizedBox(width: 8),
          IconButton(onPressed: _stepBackward, icon: const Icon(Icons.skip_previous)),
          IconButton(onPressed: _stepForward, icon: const Icon(Icons.skip_next)),
        ])
      ],
    );
  }

  Widget _buildVisualizerArea() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(border: Border.all(color: Colors.black12), borderRadius: BorderRadius.circular(8)),
      child: _algo == Algorithm.rabinKarp ? _buildRabinKarpView() : _buildSortingView(),
    );
  }

  Widget _buildSortingView() {
    final frame = (_frames.isNotEmpty && _currentFrame < _frames.length) ? _frames[_currentFrame] : Frame(_array.toList());
    final arr = frame.arr;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: LayoutBuilder(builder: (context, constraints) {
            final maxVal = arr.isNotEmpty ? arr.reduce(max).toDouble() : 1.0;
            final barWidth = max(4.0, (constraints.maxWidth - 8) / (arr.isEmpty? 1 : arr.length) - 2);

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                height: constraints.maxHeight,
                width: max(constraints.maxWidth, barWidth * arr.length + 40),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(arr.length, (i) {
                    double h = (arr[i] / maxVal) * (constraints.maxHeight - 20);
                    Color color = Colors.blueGrey.shade300;
                    if (frame.a == i || frame.b == i) {
                      if (frame.op.contains('swap')){ color = Colors.redAccent;}
                      else if (frame.op.contains('set')){ color = Colors.green;}
                      else {color = Colors.orangeAccent;}
                    }
                    return Container(
                      width: barWidth,
                      height: h,
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
                    );
                  }),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
        Text('Step: ${_currentFrame + 1} / ${_frames.length}   Op: ${_frames.isNotEmpty ? _frames[_currentFrame].op : ''}'),
      ],
    );
  }

  Widget _buildRabinKarpView() {
    if (_rkFrames.isEmpty) return const Center(child: Text('Prepare Rabin-Karp frames to visualize (use Prepare RK)'));
    final frame = _rkFrames[_currentRKFrame];
    final txt = frame.text;
    final pat = frame.pattern;
    final s = frame.index;

    List<TextSpan> spans = [];
    for (int i = 0; i < txt.length; i++) {
      final inWindow = i >= s && i < s + pat.length;
      Color bg = Colors.transparent;
      if (inWindow) {
        bg = frame.match ? Colors.green.withOpacity(0.6) : Colors.orange.withOpacity(0.6);
      }
      spans.add(TextSpan(text: txt[i], style: TextStyle(backgroundColor: bg, fontSize: 20, color: Colors.black)));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(scrollDirection: Axis.horizontal, child: RichText(text: TextSpan(children: spans))),
        const SizedBox(height: 8),
        Text('Shift: ${s}  Pattern hash: ${frame.patternHash}   Window hash: ${frame.textHash}  Match: ${frame.match}'),
        const SizedBox(height: 8),
        Text('Step: ${_currentRKFrame + 1} / ${_rkFrames.length}'),
      ],
    );
  }

  Widget _buildPlaybackInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Status: ${_isPlaying ? 'Playing' : 'Stopped'}'),
        if (_algo != Algorithm.rabinKarp) Text('Array size: ${_array.length}'),
        if (_algo == Algorithm.rabinKarp && _rkFrames.isNotEmpty) Text('RK steps: ${_rkFrames.length}'),
      ],
    );
  }
}

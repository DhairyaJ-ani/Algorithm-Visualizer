import 'frames.dart';

enum Algorithm { mergeSort, quickSort, rabinKarp }

 void mergeSort(List<int> arr, int l, int r, List<Frame> frames) {
    if (l >= r) return;
    int m = (l + r) >> 1;
    mergeSort(arr, l, m, frames);
    mergeSort(arr, m + 1, r, frames);

    List<int> temp = [];
    int i = l, j = m + 1;
    while (i <= m && j <= r) {
      frames.add(Frame(arr.toList(), a: i, b: j, op: 'compare'));
      if (arr[i] <= arr[j]) {
        temp.add(arr[i]);
        i++;
      } else {
        temp.add(arr[j]);
        j++;
      }
    }
    while (i <= m) {temp.add(arr[i++]);}
    while (j <= r) {temp.add(arr[j++]);}

    for (int k = l; k <= r; k++) {
      arr[k] = temp[k - l];
      frames.add(Frame(arr.toList(), a: k, op: 'set'));
    }
  }

  void quickSort(List<int> arr, int low, int high, List<Frame> frames) {
    if (low < high) {
      int pi = partition(arr, low, high, frames);
      quickSort(arr, low, pi - 1, frames);
      quickSort(arr, pi + 1, high, frames);
    }
  }

  int partition(List<int> arr, int low, int high, List<Frame> frames) {
    int pivot = arr[high];
    int i = low - 1;
    for (int j = low; j < high; j++) {
      frames.add(Frame(arr.toList(), a: j, b: high, op: 'compare'));
      if (arr[j] < pivot) {
        i++;
        int t = arr[i];
        arr[i] = arr[j];
        arr[j] = t;
        frames.add(Frame(arr.toList(), a: i, b: j, op: 'swap'));
      }
    }
    int t = arr[i + 1];
    arr[i + 1] = arr[high];
    arr[high] = t;
    frames.add(Frame(arr.toList(), a: i + 1, b: high, op: 'swapPivot'));
    return i + 1;
  }

  // Rabin-Karp steps (simple mod-based rolling hash, q is a small prime)
  List<RKFrame> rabinKarpSteps(String txt, String pat) {
    List<RKFrame> steps = [];
    final int n = txt.length;
    final int m = pat.length;
    if (m == 0 || m > n) return steps;
    const int d = 256;
    const int q = 101; // small prime modulus for demonstration

    int h = 1;
    for (int i = 0; i < m - 1; i++) h = (h * d) % q;

    int p = 0; // pattern hash
    int t = 0; // text hash
    for (int i = 0; i < m; i++) {
      p = (d * p + pat.codeUnitAt(i)) % q;
      t = (d * t + txt.codeUnitAt(i)) % q;
    }

    for (int s = 0; s <= n - m; s++) {
      bool match = false;
      // record current shift with hashes
      if (p == t) {
        // verify actual characters
        bool ok = true;
        for (int k = 0; k < m; k++) {
          if (txt[s + k] != pat[k]) {
            ok = false;
            break;
          }
        }
        match = ok;
      }
      steps.add(RKFrame(text: txt, pattern: pat, index: s, match: match, textHash: t, patternHash: p));

      // roll hash forward
      if (s < n - m) {
        t = (d * (t - txt.codeUnitAt(s) * h) + txt.codeUnitAt(s + m)) % q;
        if (t < 0) t += q;
      }
    }

    return steps;
  }


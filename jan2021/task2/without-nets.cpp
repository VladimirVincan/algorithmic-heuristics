#include <algorithm>
#include <fstream>
#include <iomanip>
#include <iostream>

using namespace std;

int n, K;
float cost[10][10];
int neighbor[10];

float E(char x) {
  int sum = 0;
  for (int i = 0; i < n; ++i)
    if (i != x - 'a' && neighbor[x - 'a'] != neighbor[i])
      sum += cost[x - 'a'][i];
  return sum;
}

float I(char x) {
  int sum = 0;
  for (int i = 0; i < n; ++i)
    if (i != x - 'a' && neighbor[x - 'a'] == neighbor[i])
      sum += cost[x - 'a'][i];
  return sum;
}

float gain(char x, char y) {
  return (E(x) - I(x)) + (E(y) - I(y)) - 2 * cost[x - 'a'][y - 'a'];
}

void read(string s) {
  ifstream f(s);
  f >> n;
  f >> K;
  for (int i = 0; i < n; ++i)
    for (int j = 0; j < n; ++j)
      f >> cost[i][j];
  for (int i = 0; i < n; ++i)
    f >> neighbor[i];
  f.close();
}

void swap_neighbors(char x, char y) {
  swap(neighbor[x - 'a'], neighbor[y - 'a']);
}

void print_mat(const float a[][10]) {
  for (int i = 0; i < n; ++i) {
    for (int j = 0; j < n; ++j)
      cout << setw(5) << a[i][j] << " ";
    cout << endl;
  }
}

int main() {
  read("without-nets.in");
  // print_mat(cost);
  for (int k = 0; k < K; ++k) {
    bool initialized = false;
    float max_gain;
    char max_source;
    char max_target;

    // cout << "k = " << k << endl;
    for (char i = 'a'; i < 'a' + (char)n; ++i) {
      for (char j = 'a'; j < 'a' + (char)n; ++j) {
        if (i != j && neighbor[i-'a'] != neighbor[j-'a']) {

          float curr_gain = gain(i, j);
          if (!initialized) {
            initialized = true;
            max_gain = curr_gain;
            max_source = i;
            max_target = j;
            continue;
          }

          if (curr_gain > max_gain) {
            max_gain = curr_gain;
            max_source = i;
            max_target = j;
          }

          // cout << "(" << i << ", " << j << "): " << curr_gain << endl;
        }
        // cout << "i=" << i << " j=" << j << " n[i]=" << neighbor[i - 'a']
        //      << " n[j]=" << neighbor[j-'a'] << endl;
      }
      // cout << endl;
    }

    swap_neighbors(max_source, max_target);
  }

  for (int i = 0; i < n; ++i)
    cout << (char)('a' + i) << ": " << neighbor[i] << endl;
  return 0;
}

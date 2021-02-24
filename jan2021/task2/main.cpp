#include <algorithm>
#include <fstream>
#include <iomanip>
#include <iostream>

using namespace std;

int nets, gates, K;
float cost[10][10];
int adjacency[8][10];
int neighbor[10], min_cutsize_neighbor[10];
int min_cutsize;

void swap_neighbors(char x, char y) {
  swap(neighbor[x - 'a'], neighbor[y - 'a']);
}

void print_mat(const float a[][10], int n, int m) {
  for (int i = 0; i < n; ++i) {
    for (int j = 0; j < m; ++j)
      cout << setw(5) << a[i][j] << " ";
    cout << endl;
  }
}

void print_mat(const int a[][10], int n, int m) {
  for (int i = 0; i < n; ++i) {
    for (int j = 0; j < m; ++j)
      cout << setw(5) << a[i][j] << " ";
    cout << endl;
  }
}

float E(char x) {
  int sum = 0;
  for (int i = 0; i < gates; ++i)
    if (i != x - 'a' && neighbor[x - 'a'] != neighbor[i])
      sum += cost[x - 'a'][i];
  return sum;
}

float I(char x) {
  int sum = 0;
  for (int i = 0; i < gates; ++i)
    if (i != x - 'a' && neighbor[x - 'a'] == neighbor[i])
      sum += cost[x - 'a'][i];
  return sum;
}

float gain(char x, char y) {
  return (E(x) - I(x)) + (E(y) - I(y)) - 2 * cost[x - 'a'][y - 'a'];
}

void copy_cutsize() {
  for (int i = 0; i < gates; ++i)
    min_cutsize_neighbor[i] = neighbor[i];
}

int cutsize() {
  int cutsize_sum = 0;
  for (int i = 0; i < nets; ++i) {
    int neighbor_of_first = -1;
    for (int j = 0; j < gates; ++j) {
      if (neighbor_of_first == -1 && adjacency[i][j])
        neighbor_of_first = neighbor[j];
      else if (neighbor_of_first != neighbor[j] && adjacency[i][j]) {
        ++cutsize_sum;
        break;
      }
    }
  }
  return cutsize_sum;
}

void read(string s) {
  ifstream f(s);
  f >> gates >> nets;
  f >> K;
  for (int i = 0; i < nets; ++i)
    for (int j = 0; j < gates; ++j)
      f >> adjacency[i][j];
  for (int i = 0; i < gates; ++i)
    f >> neighbor[i];
  copy_cutsize();
  min_cutsize = cutsize();
  f.close();
}

void calc_cost() {
  // initialize cost matrix
  for (int i = 0; i < gates; ++i)
    for (int j = 0; j < gates; ++j)
      cost[i][j] = 0;

  // calculate cost matrix
  // cost matrix is gate-gate adjacency matrix
  // whereas adjacency matrix is net-gate adjacency
  for (int i = 0; i < nets; ++i) {
    int sum = 0;
    for (int j = 0; j < gates; ++j)
      sum += (float)adjacency[i][j];
    float weight = 1 / ((float)sum - 1);
    for (int j = 0; j < gates; ++j)
      for (int k = 0; k < gates; ++k)
        if (adjacency[i][j] && adjacency[i][k] && j!=k)
          cost[j][k] += weight;
  }
}

int main() {
  read("matrix.in");
  calc_cost();
  cout << "adj" << endl;
  print_mat(adjacency, nets, gates);
  cout << "cost" << endl;
  print_mat(cost, gates, gates);
  for (int k = 0; k < K; ++k) {
    bool initialized = false;
    float max_gain;
    char max_source;
    char max_target;

    // cout << "k = " << k << endl;
    for (char i = 'a'; i < 'a' + (char)gates; ++i) {
      for (char j = 'a'; j < 'a' + (char)gates; ++j) {
        if (i != j && neighbor[i - 'a'] != neighbor[j - 'a']) {

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

    int curr_cutsize = cutsize();
    if (curr_cutsize < min_cutsize) {
      min_cutsize = curr_cutsize;
      copy_cutsize();
    }
    swap_neighbors(max_source, max_target);
    // for (int i = 0; i < gates; ++i)
    //   cout << (char)('a' + i) << ": " << neighbor[i] << endl;
    // cout << "Cutsize = " << curr_cutsize << endl;
    // cout << endl;
  }

  for (int i = 0; i < gates; ++i)
    cout << (char)('a' + i) << ": " << min_cutsize_neighbor[i] << endl;
  cout << "Minimal cutsize = " << min_cutsize << endl;
  return 0;
}

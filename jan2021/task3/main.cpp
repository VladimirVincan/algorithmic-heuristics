#include <algorithm>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <math.h>
#include <stdlib.h>
#include <time.h>

using namespace std;

int nets, gates, K;
float cost[10][10];
int adjacency[8][10];
int neighbor[10], min_cutsize_neighbor[10], prev_cutsize_neighbor[10];
int min_cutsize, prev_cutsize;

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

// float gain(char x, char y) {
//   return (E(x) - I(x)) + (E(y) - I(y)) - 2 * cost[x - 'a'][y - 'a'];
// }

float gain(char x, char y) {
  return (E(x) - I(x)) + (E(y) - I(y)) - 2 * cost[x - 'a'][y - 'a'];
}

float cell_gain(char x) { return E(x) - I(x); }

void copy_cutsize() {
  for (int i = 0; i < gates; ++i)
    prev_cutsize_neighbor[i] = neighbor[i];
}

void copy_min_cutsize() {
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

float temp_0, alpha;

void read(string s) {
  ifstream f(s);
  f >> gates >> nets;
  f >> temp_0 >> alpha >> K;
  for (int i = 0; i < nets; ++i)
    for (int j = 0; j < gates; ++j)
      f >> adjacency[i][j];
  for (int i = 0; i < gates; ++i)
    f >> neighbor[i];
  copy_cutsize();
  copy_min_cutsize();
  min_cutsize = cutsize();
  prev_cutsize = cutsize();
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
        if (adjacency[i][j] && adjacency[i][k] && j != k)
          cost[j][k] += weight;
  }
}

float randZeroToOne() { return rand() / (RAND_MAX + 1.); }

int randZeroToN(int n) { return rand() % n; }

void simulated_annealing() { // float temp_0, float alpha, float K){
  float temp = temp_0;
  for (int k = 0; k < K; ++k) {
    int left_cell_offset = randZeroToN(gates / 2);
    int right_cell_offset = randZeroToN(gates / 2);
    int left_cell, right_cell, loffset = 0, roffset = 0;
    for (int i = 0; i < gates; ++i) {
      if (neighbor[i] == 1)
        ++loffset;
      if (neighbor[i] == 2)
        ++roffset;
      if (loffset == left_cell_offset)
        left_cell = i;
      if (roffset == right_cell_offset)
        right_cell = i;
    }

    int curr_cutsize = cutsize();
    if (curr_cutsize < min_cutsize) {
      min_cutsize = curr_cutsize;
      copy_min_cutsize();
    }
    if (curr_cutsize < prev_cutsize) {
      prev_cutsize = curr_cutsize;
      copy_cutsize();
      swap_neighbors(left_cell + 'a', right_cell + 'a');
    } else if (randZeroToOne() < exp((curr_cutsize - min_cutsize) / temp)) {
      prev_cutsize = curr_cutsize;
      copy_cutsize();
      swap_neighbors(left_cell + 'a', right_cell + 'a');
    }
    temp *= alpha;
  }
}

int main() {
  srand(time(NULL));
  read("matrix.in");
  calc_cost();
  cout << "adj" << endl;
  print_mat(adjacency, nets, gates);
  cout << "cost" << endl;
  print_mat(cost, gates, gates);

  simulated_annealing();

  for (int i = 0; i < gates; ++i)
    cout << (char)('a' + i) << ": " << min_cutsize_neighbor[i] << endl;
  cout << "Minimal cutsize = " << min_cutsize << endl;
  return 0;
}

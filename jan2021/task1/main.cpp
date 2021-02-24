#include <fstream>
#include <iostream>
#include <math.h>
#include <queue>
#include <set>
#include <vector>
#include <iomanip>

using namespace std;

/*
 * nx, ny - matrix size
 * sx, sy - source position
 * tx, ty - target position
 * a - matrix
 */

int nx, ny, sx, sy, tx, ty;
int a[8][8], prev_mat[8][8];
float cost[8][8];

void read(string s) {
  ifstream f(s);
  f >> nx >> ny;
  f >> sx >> sy;
  f >> tx >> ty;
  for (int i = 0; i < ny; ++i)
    for (int j = 0; j < nx; ++j)
      f >> a[i][j];
  f.close();
}

class Node {
public:
  // x, y - coordinates
  // prev - coordinates of "previous" matrix position
  // f - total cost, f=g+h
  int x, y;
  float f;
  int prev;
  Node(int x, int y, float f, int prev) : x(x), y(y), f(f), prev(prev){};
  // bool operator<(const Node &n) { return this->f < n.f; }
};

class comparison {
public:
  comparison(){};
  bool operator()(const Node &a, const Node &b) const { return a.f > b.f; }
};

struct set_comparison {
  bool operator()(const Node &a, const Node &b) const { return a.f < b.f; }
};

float distance1(int x, int y) {
  float g = abs(x - sx) + abs(y - sy);
  float h = abs(x - tx) + abs(y - ty);
  return g + h;
}

float distance2(int x, int y) {
  float g = abs(x - sx) + abs(y - sy);
  float h = max(abs(x - tx), abs(y - ty));
  return g + h;
}

// int mat_pos(int x, int y) { return y * 8 + x; }
// int mat_posx(int pos) {return pos % 8;}
// int mat_posy(int pos) {return pos / 8;}

int mat_pos(int x, int y) { return y * 10 + x; }
int mat_posx(int pos) {return pos % 10;}
int mat_posy(int pos) {return pos / 10;}

void astar() {
  priority_queue<Node, vector<Node>, comparison> open;
  open.emplace(sx, sy, 0, mat_pos(sx, sy));
  set<pair<int, int>> closed;
  bool finished = false;

  while (!open.empty()) {
    Node q = open.top();
    open.pop();

    // ii) if this node is in the OPEN list
    // check if the same node is already in CLOSED set
    if (closed.find(make_pair(q.x, q.y)) != closed.end())
      continue;

    // finished is true only if a road has been found from source to target
    if (finished)
      continue;

    // just for analysis purposes
    prev_mat[q.x][q.y] = q.prev;
    cost[q.x][q.y] = q.f;

    for (int x = q.x - 1; x <= q.x + 1; ++x)
      for (int y = q.y - 1; y <= q.y + 1; ++y) {

        // skip the same node
        if (x == q.x && y == q.y)
          continue;

        // skip if out of bounds
        if (x < 0 || x >= nx || y < 0 || y >= ny)
          continue;

        // skip node if on an obstacle
        if (!a[y][x])
          continue;

        // i) if successor is the goal
        if (x == tx && y == ty) {
          prev_mat[x][y] = mat_pos(q.x, q.y);
          cost[x][y] = distance2(x,y);
          finished = true;
          break;
        }

        // iii) if this node is in the CLOSED set
        Node curr(x, y, distance2(x, y), mat_pos(q.x, q.y));
        if (closed.find(make_pair(x,y)) != closed.end())
          continue;

        // iiii) else push to OPEN
        open.push(curr);
      }
    closed.insert(make_pair(q.x, q.y));
  }
}

void print_mat(const int a[][8]) {
  for (int i = 0; i < nx; ++i) {
    for (int j = 0; j < ny; ++j)
      cout << setw(3) << a[j][i] << " ";
    cout << endl;
  }
}

void print_mat(const float a[][8]) {
  for (int i = 0; i < nx; ++i) {
    for (int j = 0; j < ny; ++j)
      cout << setw(3) << a[j][i] << " ";
    cout << endl;
  }
}

int main() {
  read("matrix.in");
  astar();
  cout << "f = " << endl;
  print_mat(cost);
  cout << endl;
  cout << "prev = " << endl;
  print_mat(prev_mat);
  cout << endl;
  return 0;
}

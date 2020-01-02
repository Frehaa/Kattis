#include <iostream>
#include <string>
#include <vector>
#include <utility>
#include <map>

using namespace std;

int count_stars(const int& i0, const int& j0, const int& i1, const int& j1, map<pair<int,int>,char>& pixels) {
    if (i0 == i1 && j0 == j1) {
        return (pixels[make_pair(i0, j0)] == '-')? 1 : 0;
    }


    cout << "i0: " << i0 << " - j0: " << j0 << " - i1: " << i1 << " - j1: " << j1 << endl;
    if (i0 > i1 || j0 > j1) {
        cout << "Error" << endl;
        return 0;
    } 
    if (i1 - i0 > j1 - j0) { // Split rows
        int split = i1/2;
        cout << "Spliting on rows: " << split << " - " << split+1 << endl;
        int t = count_stars(i0, j0, split, j1, pixels);
        int b = count_stars(split+1, j0, i1, j1, pixels);
        cout << t << ", " << b << endl;

        return t + b;

    } else { // Split columns
        int split = j1/2;
        cout << "Spliting on cols: " << split << " - " << split+1 << endl;
        int l = count_stars(i0, j0, i1, split, pixels);
        int r = count_stars(i1, split+1, i1, j1, pixels);
        cout << l << ", " << r << endl;

        return l + r;
    }

       
    return 1;
}

int main(int argc, char** argv) {
    int m, n;
    string line;

    while (cin >> m >> n) {
        map<pair<int, int>, char> pixels;
        cout << m << " " << n << endl;
        for (int i = 0; i < m; ++i) {
            cin >> line;
            for (int j = 0; j < n; ++j) {
                pixels[make_pair(i, j)] = line[j];
            }
        }

        cout << count_stars(0, 0, m-1, n-1, pixels) << endl;
    }

   return 0; 
}

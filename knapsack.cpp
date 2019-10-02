#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Item {
    const int value, weight;

public:
    Item (int v, int w): value(v), weight(w) {}
    int getValue() { return value; }
    int getWeight() { return weight; }
};

int knapsack(const vector<Item*>& items, const int& c) {
    const int n = items.size() + 1;
    const int W = c + 1;

    cout << n << " " << c << endl;

    int* M = new int[n * W];
    for (int w = 0; w < W; ++w) {
        M[0 + n * w] = 0;
    }

    for (int i = 1; i <= items.size(); ++i) {
        int j = i-1;
        for (int w = 0; w <= c; ++w) {
            int wi = items[j]->getWeight();
            int vi = items[j]->getValue(); 
            if (w < wi) {
                M[i + n * w] = M[i-1 + n * w];
            } else {
                M[i + n * w] = max(M[i-1 + n * w], vi + M[i-1 + n * (w - wi)]);
            }
        }
    }

    return M[items.size() + n * W];
}

int main (int argc, char **argv) {
    int c, n;
    int v, w;

    while (cin >> c >> n) {
        vector<Item*> items; 
        items.reserve(n);

        for (int i = 0; i < n; ++i) {
            cin >> v >> w;
            items.push_back(new Item(v, w));
        }

        cout << knapsack(items, c) << endl;

    }

    return 0;
}

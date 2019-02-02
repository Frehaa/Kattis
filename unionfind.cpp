#include <iostream>
#include <string>
#include <vector>

std::vector<std::string> split(std::string str, char delim) {
    std::vector<std::string> result;

    int current, previous = 0;
    current = str.find(delim);
    while (current != std::string::npos) {
        result.push_back(str.substr(previous, current - previous));
        previous = current + 1;
        current = str.find(delim, previous);
    }
    result.push_back(str.substr(previous, str.length()));
    return result;
}

int find(int p, int id[]) {
    while (p != id[p]) p = id[p];
    return p;
}

int main() {
    std::string line;
    std::getline(std::cin, line);

    auto line_split = split(line, ' ');
    const int sites = std::stoi(line_split[0]);
    const int inputs = std::stoi(line_split[1]);

    int id[sites];
    int sz[sites];
    for (int i = 0; i < sites; i++) {
        id[i] = i;
        sz[i] = 1;
    }

    for (int i = 0; i < inputs; ++i) {
        std::getline(std::cin, line);
        line_split = split(line, ' ');

        std::string op = line_split[0];
        const int p = std::stoi(line_split[1]);
        const int q = std::stoi(line_split[2]);

        const int p_root = find(p, id);
        const int q_root = find(q, id);
        
        if (op == "?") {
            if (p_root == q_root) std::cout << "yes" << std::endl;
            else std::cout << "no" << std::endl;
        }
        else if (op == "=") {
            if (p_root == q_root) continue;

            if (sz[p_root] < sz[q_root]) {
                id[p_root] = q_root;
                sz[q_root] += sz[p_root];
            }
            else {
                id[q_root] = p_root;
                sz[p_root] += sz[q_root];

            }
        }
    }
        
    return 0;

}


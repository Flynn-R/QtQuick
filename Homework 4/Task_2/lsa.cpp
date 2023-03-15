#include "lsa.h"
#include <QDebug>

LSA::LSA(QObject *parent)
    : QObject{parent}
{   
    int C1[Matrix2x2::size] { 0 };
    int C2[Matrix2x2::size] { 0, static_cast<int>(x.length()) };
    for (auto& it : x) {
        C1[0] += it * it;
        C1[1] += it;
        C2[0] += it;
    }
    Matrix2x2 C(C1, C2);

    int R[Matrix2x2::size] { 0 };
    for (auto itX = x.begin(), itY = y.begin(); itX != x.end(); ++itX, ++itY) {
        R[0] += (*itX) * (*itY);
        R[1] += *itY;
    }

    Matrix2x2 A(R, C2);

    Matrix2x2 B(C1, R);

    const int detC = C.getDet();

    if (detC == 0) {
        qDebug() << "check";
        exit(-2);
    }

    const double a = static_cast<double>(A.getDet()) / detC;
    const double b = static_cast<double>(B.getDet()) / detC;

    for (auto& it : X)
        Y.append(a * it + b);
}

QVector<int> LSA::getx() const {
    return x;
}

QVector<int> LSA::gety() const {
    return y;
}

QVector<int> LSA::getX() const {
    return X;
}

QVector<int> LSA::getY() const {
    return Y;
}

LSA::Matrix2x2::Matrix2x2(int* first, int* second) {
    for (auto i = 0; i < size; ++i)
        matrix[i][0] = first[i];

    for (auto i = 0; i < size; ++i)
        matrix[i][1] = second[i];

    det = matrix[0][0] * matrix[1][1] - matrix[0][1] * matrix[1][0];
}

int LSA::Matrix2x2::getDet() const {
    return det;
}


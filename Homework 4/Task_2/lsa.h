#pragma once

#include <QObject>
#include <QtQml/qqmlregistration.h>
#include <QArrayData>

class LSA : public QObject
{
    Q_OBJECT
    QML_NAMED_ELEMENT(LSA)

    Q_PROPERTY(QVector<int> x READ getx CONSTANT)
    Q_PROPERTY(QVector<int> y READ gety CONSTANT)
    Q_PROPERTY(QVector<int> X READ getX CONSTANT)
    Q_PROPERTY(QVector<int> Y READ getY CONSTANT)

public:
    explicit LSA(QObject *parent = nullptr);

    QVector<int> getx() const;
    QVector<int> gety() const;

    QVector<int> getX() const;
    QVector<int> getY() const;

private:
    const QVector<int> x { 7, 31, 61, 99, 129, 178, 209 };
    const QVector<int> y { 13, 10, 9, 10, 12, 20, 26 };

    const QVector<int> X { 0, 210 };
    QVector<int> Y;

    class Matrix2x2 {
    public:
        Matrix2x2(int*, int*);
        int getDet() const;
        static const qsizetype size = 2;

    private:
        int matrix[2][2] { 0 };
        int det;
    };

signals:

};

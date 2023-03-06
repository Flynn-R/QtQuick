#include "calculator.h"

Calculator::Calculator(QObject *parent)
    : QObject{parent}
{

}

QString Calculator::execBySide(QString A, QString B, QString C)
{
    bool ok;

    float a = A.toFloat(&ok);
    if (!ok)
        return "A is not a number!";

    float b = B.toFloat(&ok);
    if (!ok)
        return "B is not a number!";

    float c = C.toFloat(&ok);
    if (!ok)
        return "C is not a number!";

    float p = (a + b + c) / 2;
    return QString::number(sqrt(p * (p - a) * (p - b) * (p - c)), 'g', 2);
}

QString Calculator::execByCoord(QString A, QString B, QString C)
{
    bool ok;

    QStringList a = A.split(',', Qt::SkipEmptyParts);
    float Axy[2];
    qsizetype i = 0;
    for (auto& it : a)
    {
        if (i != 2)
        {
            Axy[i++] = it.toFloat(&ok);
            if (!ok)
                return "A is not a coordinate!";
        }
        else
            return "A is not a coordinate!";
    }

    QStringList b = B.split(',', Qt::SkipEmptyParts);
    float Bxy[2];
    i = 0;
    for (auto& it : b)
    {
        if (i != 2)
        {
            Bxy[i++] = it.toFloat(&ok);
            if (!ok)
                return "B is not a coordinate!";
        }
        else
            return "B is not a coordinate!";
    }

    QStringList c = C.split(',', Qt::SkipEmptyParts);
    float Cxy[2];
    i = 0;
    for (auto& it : c)
    {
        if (i != 2)
        {
            Cxy[i++] = it.toFloat(&ok);
            if (!ok)
                return "C is not a coordinate!";
        }
        else
            return "C is not a coordinate!";
    }

    float AB = sqrt(pow(Axy[0] - Bxy[0], 2) + pow(Axy[1] - Bxy[1], 2));
    float BC = sqrt(pow(Bxy[0] - Cxy[0], 2) + pow(Bxy[1] - Cxy[1], 2));
    float AC = sqrt(pow(Axy[0] - Cxy[0], 2) + pow(Axy[1] - Cxy[1], 2));

    float p = (AB + BC + AC) / 2;
    return QString::number(sqrt(p * (p - AC) * (p - BC) * (p - AC)), 'g', 2);
}

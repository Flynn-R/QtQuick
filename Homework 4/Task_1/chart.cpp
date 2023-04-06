#include "chart.h"

Chart::Chart(QObject *parent)
    : QObject{parent}
{
    double i = 0;
    while (i <= 5) {
        x.append(i);
        i += 0.1;
    }
}

QColor Chart::getColor() {
    return color;
}

void Chart::setColor(QColor newColor) {
    color = newColor;
    emit colorChanged();
}

QString Chart::getName() {
    return name;
}

void Chart::setName(QString newName) {
    name = newName;
    emit nameChanged();
}

QList<double> Chart::getX() const {
    return x;
}

QList<double> Chart::getY() const {
    return y;
}

void Chart::calculate(Chart::CHART_TYPES chart) {
    y.clear();

    for (auto& it : x) {
        switch (chart) {
        case CHART_TYPES::SINX:
            y.append(sin(it));
            break;
        case CHART_TYPES::LINEAR:
            y.append(it);
            break;
        case CHART_TYPES::ABS_LINEAR:
            y.append(fabs(it - 2.5));
            break;
        case CHART_TYPES::SQUARED:
            y.append(pow(it, 2));
            break;
        case CHART_TYPES::LOG2:
            y.append(log2(it));
            break;
        default:
            break;
        }
    }

    emit yChanged();
}

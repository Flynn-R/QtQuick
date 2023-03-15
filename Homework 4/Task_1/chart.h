#pragma once

#include <QtQml/qqmlregistration.h>
#include <QObject>
#include <QColor>
#include <QVariant>

class Chart : public QObject
{
    Q_OBJECT
    QML_NAMED_ELEMENT(Chart)
    Q_PROPERTY(QColor color READ getColor WRITE setColor NOTIFY colorChanged)
    Q_PROPERTY(QString name READ getName WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QList<double> x READ getX CONSTANT)
    Q_PROPERTY(QList<double> y READ getY NOTIFY yChanged)

public:
    explicit Chart(QObject *parent = nullptr);

    enum CHART_TYPES {
        SINX, LINEAR, ABS_LINEAR, SQUARED, LOG2
    };
    Q_ENUM(CHART_TYPES)

    QColor getColor();
    void setColor(QColor);

    QString getName();
    void setName(QString);

    QList<double> getX() const;

    QList<double> getY() const;

    Q_INVOKABLE void calculate(Chart::CHART_TYPES);

signals:
    void colorChanged();
    void nameChanged();
    void yChanged();

private:
    QColor color;
    QString name;
    QList<double> x;
    QList<double> y;
};

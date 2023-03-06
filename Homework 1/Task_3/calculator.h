#ifndef CALCULATOR_H
#define CALCULATOR_H

#include <QObject>

class Calculator : public QObject
{
    Q_OBJECT
public:
    explicit Calculator(QObject *parent = nullptr);
    Q_INVOKABLE QString execBySide(QString, QString, QString);
    Q_INVOKABLE QString execByCoord(QString, QString, QString);
};

#endif // CALCULATOR_H

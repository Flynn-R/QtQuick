#include "mainwindow.h"

#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    MainWindow w;
    w.resize(640, 480);
    w.setWindowTitle("Login form");
    w.show();
    return a.exec();
}

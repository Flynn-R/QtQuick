#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QVBoxLayout>
#include <QLineEdit>
#include <QPushButton>
#include <QFrame>

class Frame;

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow() = default;

private:
    const QString styleSheet = "QMainWindow { background-color: #e5ecef; }"
                               "QLineEdit { background-color: white; color: #535353; }"
                               "QPushButton { background-color: #f6f6f6; color: #535353; }"
                               "QPushButton:pressed { background-color: #bbbbbb; }"
                               "QPushButton:hover { background-color: #d6d6d6; }"
                               "QFrame { background-color: white; border-radius: 5 }";
    QVBoxLayout *layout;
    QLineEdit *login, *password;
    QPushButton *submit;
    QFrame *frame;

    const QString lgn = "Login";
    const QString psswd = "Password";

    void successAnimation();
    void failAnimation();

private slots:
    void submitted();
    void animationBlock();
};

#endif // MAINWINDOW_H

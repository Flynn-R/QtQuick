#include "mainwindow.h"
#include <QPropertyAnimation>
#include <QSequentialAnimationGroup>
#include <QParallelAnimationGroup>
#include <QGraphicsOpacityEffect>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
{
    auto widget = new QWidget(this);
    setCentralWidget(widget);
    auto lay = new QVBoxLayout(this);
    widget->setLayout(lay);
    frame = new QFrame(this);
    lay->addWidget(frame, 0, Qt::AlignCenter);
    frame->setFixedSize(300, 250);

    layout = new QVBoxLayout(this);
    layout->setContentsMargins(32, 32, 32, 32);
    layout->setSpacing(32);

    frame->setLayout(layout);

    login = new QLineEdit(this);
    login->setFixedSize(200, 40);
    login->setPlaceholderText("Логин");
    connect(login, &QLineEdit::returnPressed, this, &MainWindow::submitted);

    password = new QLineEdit(this);
    password->setFixedSize(200, 40);
    password->setPlaceholderText("Пароль");
    password->setEchoMode(QLineEdit::Password);
    connect(password, &QLineEdit::returnPressed, this, &MainWindow::submitted);

    submit = new QPushButton("Вход", this);
    submit->setFixedSize(200, 40);
    connect(submit, &QPushButton::clicked, this, &MainWindow::submitted);

    layout->addWidget(login);
    layout->addWidget(password);
    layout->addWidget(submit);
    layout->setAlignment(login, Qt::AlignHCenter);
    layout->setAlignment(password, Qt::AlignHCenter);
    layout->setAlignment(submit, Qt::AlignHCenter);

    setStyleSheet(styleSheet);
}

void MainWindow::successAnimation()
{
    auto loginOpacity = new QGraphicsOpacityEffect(this);
    login->setGraphicsEffect(loginOpacity);
    auto passwordOpacity = new QGraphicsOpacityEffect(this);
    password->setGraphicsEffect(passwordOpacity);
    auto submitOpacity = new QGraphicsOpacityEffect(this);
    submit->setGraphicsEffect(submitOpacity);

    auto anim1 = new QPropertyAnimation(loginOpacity, "opacity");
    auto anim2 = new QPropertyAnimation(passwordOpacity, "opacity");
    auto anim3 = new QPropertyAnimation(submitOpacity, "opacity");

    anim1->setDuration(400);
    anim2->setDuration(400);
    anim3->setDuration(400);

    anim1->setEndValue(0);
    anim2->setEndValue(0);
    anim3->setEndValue(0);

    auto parallelGroup = new QParallelAnimationGroup(this);
    parallelGroup->addAnimation(anim1);
    parallelGroup->addAnimation(anim2);
    parallelGroup->addAnimation(anim3);

    auto rectangleOpacity = new QGraphicsOpacityEffect(this);
    frame->setGraphicsEffect(rectangleOpacity);

    auto anim4 = new QPropertyAnimation(rectangleOpacity, "opacity");

    anim4->setDuration(600);
    anim4->setEndValue(0);

    auto sequentialGroup = new QSequentialAnimationGroup(this);
    sequentialGroup->addPause(400);
    sequentialGroup->addAnimation(anim4);

    parallelGroup->start();
    sequentialGroup->start();
}

void MainWindow::failAnimation()
{
    auto loginColor = new QGraphicsColorizeEffect(this);
    login->setGraphicsEffect(loginColor);
    auto passwordColor = new QGraphicsColorizeEffect(this);
    password->setGraphicsEffect(passwordColor);

    auto anim1 = new QPropertyAnimation(loginColor, "color");
    auto anim2 = new QPropertyAnimation(passwordColor, "color");

    anim1->setDuration(0);
    anim2->setDuration(0);

    anim1->setEndValue("dark red");
    anim2->setEndValue("dark red");

    auto parallelGroup1 = new QParallelAnimationGroup(this);

    parallelGroup1->addAnimation(anim1);
    parallelGroup1->addAnimation(anim2);

    auto anim3 = new QPropertyAnimation(loginColor, "color");
    auto anim4 = new QPropertyAnimation(passwordColor, "color");

    anim3->setDuration(400);
    anim4->setDuration(400);

    anim3->setEndValue("#535353");
    anim4->setEndValue("#535353");

    auto parallelGroup2 = new QParallelAnimationGroup(this);

    parallelGroup2->addAnimation(anim3);
    parallelGroup2->addAnimation(anim4);

    auto anim5 = new QPropertyAnimation(frame, "geometry");
    auto anim6 = new QPropertyAnimation(frame, "geometry");
    auto anim7 = new QPropertyAnimation(frame, "geometry");

    anim5->setDuration(50);
    anim6->setDuration(100);
    anim7->setDuration(50);

    QRect rect = frame->geometry();

    anim5->setEndValue(QRect(rect.x() - 5, rect.y(), rect.width(), rect.height()));
    anim6->setEndValue(QRect(rect.x() + 10, rect.y(), rect.width(), rect.height()));
    anim7->setEndValue(QRect(rect.x() - 5, rect.y(), rect.width(), rect.height()));

    auto sequentialGroup = new QSequentialAnimationGroup(this);

    sequentialGroup->addAnimation(anim5);
    sequentialGroup->addAnimation(anim6);
    sequentialGroup->addAnimation(anim7);

    auto group = new QSequentialAnimationGroup(this);
    group->addAnimation(parallelGroup1);
    group->addAnimation(parallelGroup2);

    auto superGroup = new QParallelAnimationGroup(this);
    superGroup->addAnimation(group);
    superGroup->addAnimation(sequentialGroup);

    superGroup->start();
}

void MainWindow::submitted()
{
    if (login->text() == lgn && password->text() == psswd)
        successAnimation();
    else
        failAnimation();
}

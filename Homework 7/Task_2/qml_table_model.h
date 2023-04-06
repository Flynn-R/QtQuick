#pragma once

#include <QObject>
#include <QAbstractTableModel>
#include <vector>

class QMLTableModel : public QAbstractTableModel
{
    Q_OBJECT

public:
    explicit QMLTableModel(QObject *parent = nullptr);

    struct RowElement{
        int id;
        QString name;
        QString surname;
        QStringList friends;
    };

    enum QMLTableModelRoles {
        IdRole = Qt::UserRole + 1,
        NameRole,
        SurnameRole,
        FriendsRole
    };

    int rowCount(const QModelIndex&) const override;
    int columnCount(const QModelIndex&) const override;
    QVariant data(const QModelIndex&, int) const override;
    QHash<int, QByteArray> roleNames() const override;
    void appendRowElement(const RowElement&);

private:
    std::vector<RowElement> m_data;
};

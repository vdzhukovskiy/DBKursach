#pragma once

#include <QSqlTableModel>

class SqlTableModel : public QSqlTableModel
{
    Q_OBJECT

public:
    explicit SqlTableModel(QObject *parent = nullptr, QSqlDatabase db = QSqlDatabase())
        : QSqlTableModel(parent, db) {}

    QHash<int, QByteArray> roleNames() const override {
        QHash<int, QByteArray> roles;
        for (int i = 0; i < columnCount(); ++i) {
            roles[Qt::UserRole + i] = headerData(i, Qt::Horizontal).toByteArray();
        }
        qDebug() << "Roles:" << roles;
        return roles;
    }

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override {
        if (role < Qt::UserRole) {
            return QSqlTableModel::data(index, role);
        }
        int column = role - Qt::UserRole;
        return QSqlTableModel::data(this->index(index.row(), column), Qt::DisplayRole);
    }
};

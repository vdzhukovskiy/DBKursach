#pragma once

#include <QSqlQuery>
#include <QSqlQueryModel>
#include <QSqlRecord>

class SqlQueryModel : public QSqlQueryModel
{
    Q_OBJECT
    Q_PROPERTY(QString query READ queryStr WRITE setQueryStr NOTIFY queryStrChanged)
    Q_PROPERTY(QStringList userRoleNames READ userRoleNames CONSTANT)
public:
    using QSqlQueryModel::QSqlQueryModel;
    QHash<int, QByteArray> roleNames() const override;
    Q_INVOKABLE QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QString queryStr() const;
    void setQueryStr(const QString &query);
    QStringList userRoleNames() const;
signals:
    void queryStrChanged();
};

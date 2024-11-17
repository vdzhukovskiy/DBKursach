#pragma once

#include <QObject>
#include <QSql>
#include <QSqlDatabase>
#include <QSqlTableModel>

// #include "sqlquerymodel.h"
#include <memory>

class DbConnector : public QObject
{
    Q_OBJECT
public:
    explicit DbConnector(QObject *parent = nullptr);
    static DbConnector& instance();
    ~DbConnector();

    Q_INVOKABLE QStringList tables();

    QSqlDatabase &getDatabase();

    Q_INVOKABLE void addDatabase();

signals:
    void connected();

private:
    std::shared_ptr<QSqlDatabase> db_;
};

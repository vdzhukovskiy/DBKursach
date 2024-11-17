#pragma once

#include <QObject>
#include <QSql>
#include <QSqlDatabase>
#include <QSqlTableModel>

#include "sqltablemodel.h"
#include <memory>

class DbConnector : public QObject
{
    Q_OBJECT
public:
    explicit DbConnector(QObject *parent = nullptr);
    static DbConnector& instance();
    ~DbConnector();

    Q_INVOKABLE SqlTableModel &getTable(QString const & name);
    Q_INVOKABLE void addDatabase();

signals:
    void connected();

private:
    std::unique_ptr<QSqlDatabase> db_;
    std::shared_ptr<SqlTableModel> table_model_;
};

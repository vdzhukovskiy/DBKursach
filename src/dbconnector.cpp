#include "dbconnector.h"

#include <QSqlTableModel>
#include <QSqlError>
#include <QDebug>

DbConnector::DbConnector(QObject *parent)
    : QObject{parent}
{}

DbConnector &DbConnector::instance()
{
    static DbConnector inst;
    return inst;
}

DbConnector::~DbConnector()
{
    if(db_)
        db_->close();
}

SqlTableModel& DbConnector::getTable(const QString &name)
{
    if (!table_model_) {
        qDebug() << "Error: table_model_ is not initialized!";
        throw std::runtime_error("Table model is not initialized.");
    }

    table_model_->setTable(name);  // Устанавливаем таблицу по имени
    if (!table_model_->select()) {
        qDebug() << "Table select failed:" << table_model_->lastError().text();
        throw std::runtime_error("Failed to select table data.");
    }

    qDebug() << table_model_->rowCount();

    return *table_model_;
}

void DbConnector::addDatabase()
{
    if(db_)
        return;

    db_ = std::make_unique<QSqlDatabase>(QSqlDatabase::addDatabase("QMYSQL", "conn"));
    db_->setHostName("damsel8s.beget.tech");
    db_->setDatabaseName("damsel8s_zhukkp");
    db_->setUserName("damsel8s_zhukkp");
    db_->setPassword("Admin123");
    bool ok = db_->open();
    qDebug() << ok;


    table_model_ = std::make_shared<SqlTableModel>(nullptr, *db_);
    if (!db_->isOpen()) {
        qDebug() << "Database connection failed:" << db_->lastError().text();
    }

    // table_model_->setTable("Drivers");
    // model.setFilter("salary > 50000");
    // model.setSort(2, Qt::DescendingOrder);
    // ok = table_model_->select();


    qDebug() << ok << table_model_->rowCount();
    emit connected();
    // db_.setHostName("")
}
